# Review Tier Process

This document describes how this Strapi project records review activity, calculates the current review tier, and changes the review tier for a flashcard or a "word".

## Short Version

- The review state is stored on `flashcard`, not on `word` or `user-word`.
- A "word tier" is therefore the tier of the flashcard linked to that word definition for a given user.
- Review events are dispatched to a review-event queue, and the queued handler writes `reviewlog`.
- The current tier is derived from `correct_streak` and the `review-tire` rules, then stored on `flashcard.review_tire`.

## Relevant Models

### `flashcard`

Source: [src/api/flashcard/content-types/flashcard/schema.json](/Users/James/develop/apple/langgo_strapi4/src/api/flashcard/content-types/flashcard/schema.json:1)

Fields that matter for review:

- `last_reviewed_at`: last effective review time
- `correct_streak`: number of effective correct reviews used for promotion
- `wrong_streak`: consecutive effective wrong reviews used for demotion
- `is_remembered`: explicit remembered flag
- `review_tire`: relation to the active review tier record
- `word_definition`: relation to the word definition this flashcard represents
- `reviewlogs`: history of recorded review attempts

### `review-tire`

Source: [src/api/review-tire/content-types/review-tire/schema.json](/Users/James/develop/apple/langgo_strapi4/src/api/review-tire/content-types/review-tire/schema.json:1)

This content type defines the rules:

- `tier`: enum value such as `new`, `warmup`, `weekly`, `monthly`, `remembered`
- `min_streak` / `max_streak`: streak range that maps to this tier
- `cooldown_hours`: how long the card must wait before the next effective review
- `demote_bar`: number of consecutive wrong answers before demotion from this tier

Note:

- The model name and relation field are spelled `review_tire` in code and schema. This is a typo in naming, but it is the current persisted API name.

### `reviewlog`

Source: [src/api/reviewlog/content-types/reviewlog/schema.json](/Users/James/develop/apple/langgo_strapi4/src/api/reviewlog/content-types/reviewlog/schema.json:1)

Each log stores:

- `user`
- `flashcard`
- `reviewed_at`
- `event_id`: idempotency key for queued review processing
- `result`: `correct` or `wrong`
- `level`: the tier name at the time of review
- `effective`: whether this review counted after cooldown was checked
- `points_awarded`: reward points granted for this review event
- `newlevel`: the tier name after the review calculation finished

Important detail:

- `reviewlog.level` still allows `daily`, but `review-tire.tier` does not define `daily`. In the current flashcard flow, the level written into logs comes from the current `review_tire.tier`.

### `point-rule`

Source: [src/api/point-rule/content-types/point-rule/schema.json](/Users/James/develop/langgo/langgo_strapi4/src/api/point-rule/content-types/point-rule/schema.json:1)

The local review-event handler currently reads the first `point-rule` row and uses:

- `review_point`
- `review_tier_up_point`

For review events:

- `review_point` is always added
- `review_tier_up_point` is added only when `newlevel` is above `level`

### `user-point`

Source: [src/api/user-point/content-types/user-point/schema.json](/Users/James/develop/langgo/langgo_strapi4/src/api/user-point/content-types/user-point/schema.json:1)

This is the local daily snapshot table for user points.

Fields currently written by the review-event handler:

- `user`
- `record_date`
- `point_group`
- `points`
- `points_add`
- `word_count`
- `word_add`
- `article_count`
- `article_add`
- `group_rank_change`
- `rank`
- `rank_change`

The handler currently only changes:

- `points`
- `points_add`
- `point_group`

The other counters are initialized and carried forward, but not yet recalculated by review events.

### `user-point-group`

Source: [src/api/user-point-group/content-types/user-point-group/schema.json](/Users/James/develop/langgo/langgo_strapi4/src/api/user-point-group/content-types/user-point-group/schema.json:1)

This stores a user's current point-group assignment:

- `user`
- `point_group`
- `period_points`

It is only created when the user does not already have one.

### `group-rank`

Source: [src/api/group-rank/content-types/group-rank/schema.json](/Users/James/develop/langgo/langgo_strapi4/src/api/group-rank/content-types/group-rank/schema.json:1)

This defines point-group bands using:

- `title`
- `min_period_points`

The target group-rank for a first-time assignment is the highest rank where:

```text
min_period_points <= period_points
```

If none match, the lowest rank is used.

### `point-group-rule`

Source: [src/api/point-group-rule/content-types/point-group-rule/schema.json](/Users/James/develop/langgo/langgo_strapi4/src/api/point-group-rule/content-types/point-group-rule/schema.json:1)

The first `point-group-rule` row controls:

- `period_days`
- `group_size`

These are used for:

- rolling `period_points` calculation
- split threshold calculation at `2 * group_size`

### `honor-title` and `honer-title-rule`

Sources:

- [src/api/honor-title/content-types/honor-title/schema.json](/Users/James/develop/langgo/langgo_strapi4/src/api/honor-title/content-types/honor-title/schema.json:1)
- [src/api/honer-title-rule/content-types/honer-title-rule/schema.json](/Users/James/develop/langgo/langgo_strapi4/src/api/honer-title-rule/content-types/honer-title-rule/schema.json:1)

Honor-title fill uses:

- the first `honer-title-rule` row
- all `honor-title` rows ordered by ascending `id`

The assigned title is stored on:

- `plugin::users-permissions.user.honor_title`

## Where Tier Rules Are Calculated

Source: [src/services/tier-service.js](/Users/James/develop/apple/langgo_strapi4/src/services/tier-service.js:1)

The shared `tier-service` does two things:

1. Loads all `review-tire` entries, sorted by `min_streak`
2. Finds the matching tier for a streak

Implementation details:

- `getAllTiers()` caches the tier table in memory after the first read.
- `findTierForStreakWithRules(streak, tiers)` matches the first tier where:

```js
currentStreak >= tier.min_streak && currentStreak <= tier.max_streak
```

- If nothing matches, it falls back to the last tier in the sorted list.

Because of that fallback, tier ranges should be kept ordered and gap-free.

## How Review Activity Is Recorded

Source: [src/api/flashcard/controllers/flashcard.js](/Users/James/develop/apple/langgo_strapi4/src/api/flashcard/controllers/flashcard.js:138)

The main runtime endpoint is:

- `POST /api/flashcards/:id/review`

The controller does the following inside a DB transaction:

1. Loads the flashcard for the authenticated user.
2. Resolves the current tier from `flashcard.review_tire`, or from `correct_streak` if the relation is missing.
3. Checks whether the card is still on cooldown.
4. Calculates the review outcome payload: `level`, `effective`, `newlevel`
5. Updates streaks, tier, `last_reviewed_at`, and `is_remembered` when the review is effective
6. After the transaction commits, dispatches a `flashcard.review.completed` event to the review-event queue facade

The queue handler then performs the side effects:

1. Creates the `reviewlog` row
2. Loads the active `point-rule`
3. Calculates reward points from the review event
3. Writes `reviewlog.points_awarded`
4. Ensures there is a previous-day `user-point` snapshot
5. Adds or updates today's `user-point` row
6. Assigns `user-point-group` and `point-group` for users who do not yet have one
7. Hosts extension hooks for future side effects

This means `reviewlog` is now eventually consistent with the flashcard update. The flashcard update is the synchronous core path; the log write is asynchronous queue work.

The queued event includes:

- `reviewed_at = now`
- `result = correct|wrong`
- `level = currentTier?.tier?.toLowerCase()`
- `effective = !reviewIsOnCooldown`
- `newlevel = resulting tier after promotion/demotion logic`

So each resulting `reviewlog` still records both:

- the tier before the review changes the flashcard in `level`
- the resulting tier after calculation in `newlevel`

Current local reward behavior:

- the local Strapi handler reads the first `point-rule` entry
- `review_point` is added for each handled review event
- `review_tier_up_point` is added when `newlevel` is above `level`
- the per-event value is stored in `reviewlog.points_awarded`
- the daily snapshot is stored in `user-point`
- if the previous day row is missing, the handler backfills it before updating today's row
- honor-title calculation only runs when today's `user-point` row is being created for the first time
- point-group / group-rank calculation only runs when today's `user-point` row is being created for the first time

### Daily `user-point` write logic

The handler follows this order:

1. Calculate `points_awarded`
2. Find today's `user-point` by `user + record_date`
3. Ensure there is a previous-day `user-point` snapshot
4. If today already exists:
   update `points` and `points_add`
5. If today does not exist:
   create a new row using the previous snapshot as the base, then add today's delta

Current snapshot rule:

- previous day row missing:
  backfill one from the latest prior snapshot, or zeroes if no history exists
- today row missing:
  create it from the previous snapshot plus today's awarded points
- today row exists:
  increment `points` and `points_add`
- same-day updates do not recalculate `honor_title`
- same-day updates do not recalculate `user-point-group`, `group-rank`, or `point_group`

Point-group assignment:

- only runs on the first review event that creates today's `user-point` row
- `period_points` is calculated as the sum of `user-point.points_add` over the configured `point-group-rule.period_days` window
- the target `group-rank` is the highest rank where `min_period_points <= period_points`
- if none match, the lowest `group-rank` is used
- if the user already has a `user-point-group` in another rank, that first event of the day can reassign the user into the target rank
- inside that rank, the handler chooses the existing `point-group` with:
- smallest member count first
- lowest `group_no` as tie breaker
- it does not create a new one-person group just because all groups are at or above `group_size`
- special case: if the target `group-rank` has no `point-group` at all, the handler creates the first group and assigns the user into it
- if the selected group reaches `2 * group_size` members after assignment, the handler splits it into two groups
- the split keeps the first half in the existing group and moves the second half into a new `point-group`
- then a `user-point-group` row is created and today's `user-point.point_group` is updated

### Split rule

The split rule is intentionally different from the old "create when full" behavior.

Current rule:

- always assign to the least-filled existing group first
- do not create a new group just because a group hit `group_size`
- only split after assignment when member count reaches:

```text
2 * group_size
```

This avoids creating many tiny groups and avoids creating a new group with only one member, except for the bootstrap case where a rank has no groups at all.

Honor title thresholds are calculated by level index:

```text
pn = base_points + increase_points * (level - 1)
```

Where:

- `level = 1` is the first `honor-title` in ascending id order
- `level = 2` is the second `honor-title`, and so on
- the handler assigns the highest title whose threshold is less than or equal to the user's current total points
- on same-day updates, honor title is not recalculated
- when a new daily `user-point` row is created, honor title can be recalculated once for that day
- when the first daily row triggers an honor-title promotion, today's `user-point` also stores:
- `rank = new honor level index`
- `rank_change = new level - previous level`

## Verified Test Cases

Source: [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:1)

Current integration coverage includes these behavior checks:

1. Basic review flow
   - review endpoint updates the flashcard
   - endpoint dispatches queue event instead of writing `reviewlog` directly
   - local handler writes `reviewlog` and daily `user-point`

2. Idempotency
   - the same `event_id` does not double-write `reviewlog`
   - the same `event_id` does not double-award points

3. Same-day gating
   - if today's `user-point` already exists, same-day reviews only update `points` and `points_add`
   - same-day reviews do not recalculate `honor_title`
   - same-day reviews do not recalculate `user-point-group` or `group-rank`

4. Group-rank threshold crossed on a second same-day review
   - a user can move from `278` to `280` points on the same day
   - if today's row already existed before those reviews, `group-rank` stays unchanged
   - no new target-rank group is created in that case

5. Honor-title threshold crossed on same-day follow-up reviews
   - if today's row already existed before the reviews, the user can cross the next honor threshold
   - `honor_title` still stays unchanged for those same-day updates

6. First review creates the day row and promotes honor title
   - previous day can be one point below the next honor threshold
   - first review of the day can promote `user.honor_title`
   - the created daily `user-point` stores the promoted `rank`
   - the created daily `user-point` stores `rank_change`

7. New user bootstrap
   - a new user with no `user-point-group` and no `honor_title` gets both on first review
   - if the target `group-rank` has no `point_group`, the first group is created

8. Reassignment to a higher group rank on first review of the day
   - a user with `279` period points can cross to `282`
   - on the first review event of the day, the user is reassigned to `Learner`
   - if `Learner` has no existing groups, the first one is created and assigned

9. Group split behavior
   - assignment goes to the least-filled existing group first
   - when membership reaches `2 * group_size`, the group is split into two groups

## Queue Facade And Drivers

Sources:

- [src/services/review-event-queue.js](/Users/James/develop/langgo/langgo_strapi4/src/services/review-event-queue.js:1)
- [src/services/review-event-handler.js](/Users/James/develop/langgo/langgo_strapi4/src/services/review-event-handler.js:1)
- [src/services/review-event-queue-drivers/internal.js](/Users/James/develop/langgo/langgo_strapi4/src/services/review-event-queue-drivers/internal.js:1)
- [src/services/review-event-queue-drivers/pubsub.js](/Users/James/develop/langgo/langgo_strapi4/src/services/review-event-queue-drivers/pubsub.js:1)

The review endpoint does not write `reviewlog` directly anymore. It calls the queue facade:

- `strapi.service('review-event-queue').dispatchReviewCompleted(event)`

Driver selection is controlled by:

- `REVIEW_EVENT_QUEUE_DRIVER=internal` (default)
- `REVIEW_EVENT_QUEUE_DRIVER=pubsub`

Current behavior by driver:

- `internal`: uses an in-process `async.queue` worker and immediately hands the event to the shared handler service
- `pubsub`: publishes the same event payload to a Pub/Sub topic for external consumers

The review controller code does not need to change when the driver changes.

## What Counts As an Effective Review

Source: [src/api/flashcard/controllers/flashcard.js](/Users/James/develop/apple/langgo_strapi4/src/api/flashcard/controllers/flashcard.js:168)

A review is effective only when the flashcard is outside its cooldown window.

Cooldown formula:

```text
dueTime = last_reviewed_at + cooldown_hours
```

Development behavior:

- If `SHORT_TIME_FOR_REVIEW=true`, cooldowns are divided by `180`.

If the card is still on cooldown:

- A queued event is still dispatched
- The flashcard itself is not updated
- The queued `reviewlog.effective = false`
- The queued `reviewlog.newlevel = reviewlog.level`

## Promotion and Demotion Rules

Source: [src/api/flashcard/controllers/flashcard.js](/Users/James/develop/apple/langgo_strapi4/src/api/flashcard/controllers/flashcard.js:177)

### On `correct`

When the review is effective and `result === "correct"`:

- `correct_streak` is incremented by 1
- `wrong_streak` is reset to `0`
- `review_tire` is recalculated from the new `correct_streak`
- `last_reviewed_at` is updated
- `is_remembered = true` if the new tier is `remembered`
- The queued `reviewlog.effective = true`
- The queued `reviewlog.newlevel` is the promoted or recalculated tier

### On `wrong`

When the review is effective and `result === "wrong"`:

- `wrong_streak` is incremented by 1
- `last_reviewed_at` is updated
- `correct_streak` is unchanged unless demotion happens
- The queued `reviewlog.effective = true`

If `wrong_streak >= currentTier.demote_bar`:

- The card is demoted to the previous tier in the sorted tier list
- `correct_streak` is set to `prevTier.min_streak`
- `wrong_streak` is reset to `0`
- `review_tire` is set to the previous tier
- `is_remembered = false`
- The queued `reviewlog.newlevel` is the demoted tier

If `wrong_streak < currentTier.demote_bar`:

- the flashcard stays in the current tier
- the queued `reviewlog.newlevel` stays equal to `level`

Note:

- Demotion is tier-based, not streak-formula-based. It steps back one tier in the configured order.

## How "Word Tier" Works In This Project

There is no review-tier field on:

- [src/api/word/content-types/word/schema.json](/Users/James/develop/apple/langgo_strapi4/src/api/word/content-types/word/schema.json:1)
- [src/api/user-word/content-types/user-word/schema.json](/Users/James/develop/apple/langgo_strapi4/src/api/user-word/content-types/user-word/schema.json:1)
- [src/api/word-definition/content-types/word-definition/schema.json](/Users/James/develop/apple/langgo_strapi4/src/api/word-definition/content-types/word-definition/schema.json:1)

So in current code:

- A `word` has no direct tier.
- A `user-word` has no direct tier.
- The effective review tier belongs to the `flashcard` that references the `word_definition`.

If someone wants to "change the tier of a word", the implementation must identify the correct flashcard first and then update that flashcard.

## How New Cards Get Their Initial Tier

### Runtime review fallback

When reviewing or listing cards, the code can infer a tier from `correct_streak` if `review_tire` is missing.

Examples:

- review flow: [src/api/flashcard/controllers/flashcard.js](/Users/James/develop/apple/langgo_strapi4/src/api/flashcard/controllers/flashcard.js:164)
- due-card selection: [src/api/flashcard/controllers/flashcard.js](/Users/James/develop/apple/langgo_strapi4/src/api/flashcard/controllers/flashcard.js:89)
- mine endpoint enrichment: [src/api/flashcard/controllers/flashcard.js](/Users/James/develop/apple/langgo_strapi4/src/api/flashcard/controllers/flashcard.js:472)

### Validation/backfill path

Source: [src/services/flashcard-validate.js](/Users/James/develop/apple/langgo_strapi4/src/services/flashcard-validate.js:14)

`flashcard-validate.validateAndFix(flashcardId)` assigns `review_tire` when it is missing:

```js
const tier = await tierService.findTierForStreak(flashcard.correct_streak);
flashcardUpdateData.review_tire = tier.id;
```

This is exposed by:

- `POST /api/flashcards/:id/validate`

This path is useful after migrations or manual data repair.

## How a Word/Create Flow Relates To Review Tier

Source: [src/api/user-word/controllers/user-word.js](/Users/James/develop/apple/langgo_strapi4/src/api/user-word/controllers/user-word.js:11)

When a `user-word` is created, the controller also creates a flashcard with:

- `last_reviewed_at: null`
- `correct_streak: 0`
- `wrong_streak: 0`
- `is_remembered: false`

It does not explicitly assign `review_tire` during creation.

So the initial tier is effectively resolved later by:

- review-time fallback, or
- `POST /api/flashcards/:id/validate`

## How Due Cards Are Calculated

Source: [src/api/flashcard/controllers/flashcard.js](/Users/James/develop/apple/langgo_strapi4/src/api/flashcard/controllers/flashcard.js:67)

`GET /api/review-flashcards` considers a card due when:

- `last_reviewed_at` is `null`, or
- `now >= last_reviewed_at + cooldown_hours`

The tier used for that cooldown is:

- `flashcard.review_tire`, if present
- otherwise, the tier derived from `correct_streak`

## How To Change A Review Tier

There are three practical ways to change a tier in this project.

### 1. Normal app flow

Use:

- `POST /api/flashcards/:id/review`

This is the intended path. It updates the tier through streak changes and tier rules.

### 2. Recalculate from existing streak

Use:

- `POST /api/flashcards/:id/validate`

This does not change `correct_streak` or `wrong_streak`. It only repairs a missing `review_tire` relation based on the current streak.

Use this when:

- a migration created flashcards without `review_tire`
- you changed tier rules and need to reassign missing relations

### 3. Manual data change

If you need to force a card into a different tier in admin or in code, update the flashcard fields together:

- `review_tire`
- `correct_streak`
- sometimes `wrong_streak`
- sometimes `is_remembered`
- optionally `last_reviewed_at`, depending on whether the card should be immediately due

Do not update only `review_tire` unless you intentionally want the relation and the streak-derived tier to disagree.

Recommended manual alignment:

- If moving to a new tier, set `correct_streak` to a value inside that tier's `[min_streak, max_streak]` range.
- If moving to `remembered`, also set `is_remembered = true`.
- If moving down from `remembered`, set `is_remembered = false`.
- If you want the card reviewable immediately, set `last_reviewed_at = null` or an old enough timestamp.

## Operational Guidance

When debugging review-tier issues, inspect these values on the flashcard first:

- `review_tire.id`
- `review_tire.tier`
- `correct_streak`
- `wrong_streak`
- `last_reviewed_at`
- `is_remembered`

Then confirm the active rule table:

- all `review-tire` rows
- sorted by `min_streak`
- with expected `cooldown_hours` and `demote_bar`

When debugging review history, inspect these values on the latest `reviewlog` row:

- `level`
- `effective`
- `newlevel`
- `result`

## Current Caveats

- The API/schema naming uses `review_tire` instead of `review_tier`.
- `reviewlog.level` still includes `daily`, but `review-tire.tier` does not.
- The tier-service caches tier rules in memory. If `review-tire` rows are changed while the server is running, the cache may need a restart or explicit invalidation to reflect the new rules consistently.
