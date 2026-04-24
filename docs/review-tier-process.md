# Review Tier Process

This document describes how this Strapi project records review activity, calculates the current review tier, changes the review tier for a flashcard or a "word", and applies point updates for review events, new word-definition events, and new article events.

## Short Version

- The review state is stored on `flashcard`, not on `word` or `user-word`.
- A "word tier" is therefore the tier of the flashcard linked to that word definition for a given user.
- The API layer dispatches domain events through `event-api`.
- Those events go through a queue facade, then a queue handler, then `point-service`.
- Review events are queued and the handler writes `reviewlog`.
- New `word_definition` create events are queued and the handler updates `user-point`.
- New `user_article` create events are queued and the handler updates `user-point`.
- The current tier is derived from `correct_streak` and the `review-tire` rules, then stored on `flashcard.review_tire`.
- New user registration bootstraps one `flashcard-stat` row per review tier.

## Current Architecture

Sources:

- [src/services/event-api.js](/Users/James/develop/langgo/langgo_strapi4/src/services/event-api.js:1)
- [src/services/review-event-queue.js](/Users/James/develop/langgo/langgo_strapi4/src/services/review-event-queue.js:1)
- [src/services/event-handler.js](/Users/James/develop/langgo/langgo_strapi4/src/services/event-handler.js:1)
- [src/services/review-event-handler.js](/Users/James/develop/langgo/langgo_strapi4/src/services/review-event-handler.js:1)
- [src/services/point-service.js](/Users/James/develop/langgo/langgo_strapi4/src/services/point-service.js:1)
- [src/services/review-reward-service.js](/Users/James/develop/langgo/langgo_strapi4/src/services/review-reward-service.js:1)
- [src/services/flashcard-stat-bootstrap.js](/Users/James/develop/langgo/langgo_strapi4/src/services/flashcard-stat-bootstrap.js:1)

Runtime shape:

```text
strapi api -> event-api -> queue -> event-handler -> point-service
```

Responsibilities by layer:

- `strapi api`
  - performs the core synchronous write for its own endpoint
  - example: review endpoint updates `flashcard`
  - example: word-definition create endpoint saves `word_definition` and `flashcard`
  - example: article create endpoint saves `user_article`
- `event-api`
  - hides queue-dispatch details from controller code
  - exposes domain methods such as `dispatchReviewCompleted` and `dispatchWordDefinitionCreated`
- `queue`
  - accepts domain events
  - delivers them through the configured driver
  - can later be backed by a different transport without changing controller code
- `event-handler`
  - routes by event type
  - performs event-specific persistence that is not part of point-rule evaluation
  - for review events, creates `reviewlog`
  - delegates point/rank/group calculations to `point-service`
- `point-service`
  - owns point-rule lookup
  - owns user-point snapshot updates
  - owns honor-title updates
  - owns group-rank and point-group assignment logic
  - is the boundary the queue handler calls instead of touching rule internals
- `flashcard-stat-bootstrap`
  - owns initial `flashcard-stat` row creation for a newly registered user
  - ensures one row exists per review tier

Current compatibility detail:

- the generic facades are in place now
- `point-service` currently delegates to `review-reward-service`, which is the concrete point engine implementation
- `event-handler` currently delegates to `review-event-handler`, which is the concrete queued-event processor
- this means the design boundary is already established even though some internal filenames are still review-oriented

## Relevant Models

### `flashcard`

Source: [src/api/flashcard/content-types/flashcard/schema.json](/Users/James/develop/apple/langgo_strapi4/src/api/flashcard/content-types/flashcard/schema.json:1)

Fields that matter for review:

- `last_reviewed_at`: last effective review time
- `next_review_at`: next scheduled due time used for fast due queries
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

### `flashcard-stat`

Source: [src/api/flashcard-stat/content-types/flashcard-stat/schema.json](/Users/James/develop/langgo/langgo_strapi4/src/api/flashcard-stat/content-types/flashcard-stat/schema.json:1)

This content type stores per-user aggregated flashcard counts by review tier.

Fields:

- `user`
- `review_tire`
- `word_count`

Current bootstrap rule:

- when a new user registers, the app creates one `flashcard-stat` row for every review tier returned by `tier-service.getAllTiers()`
- each created row starts with `word_count = 0`

Current implementation detail:

- the bootstrap service is idempotent
- if a row for `user + review_tire` already exists, it is left unchanged
- on registration, the rows are initialized with `word_count = 0`
- during effective review tier changes, the review transaction updates these rows immediately
- if a row is missing during review, it is created on demand before the count move is applied

### `point-rule`

Source: [src/api/point-rule/content-types/point-rule/schema.json](/Users/James/develop/langgo/langgo_strapi4/src/api/point-rule/content-types/point-rule/schema.json:1)

The local point-service currently reads the first `point-rule` row and uses:

- `review_point`
- `review_tier_up_point`
- `new_word_point`
- `article_point`

For review events:

- `review_point` is always added
- `review_tier_up_point` is added only when `newlevel` is above `level`

For `word_definition.created` events:

- `new_word_point` is added
- `word_count` is incremented by `1`
- `word_add` is incremented by `1`

For `user_article.created` events:

- `article_point` is added
- `article_count` is incremented by `1`
- `article_add` is incremented by `1`

### `user-point`

Source: [src/api/user-point/content-types/user-point/schema.json](/Users/James/develop/langgo/langgo_strapi4/src/api/user-point/content-types/user-point/schema.json:1)

This is the local daily snapshot table for user points.

Fields currently written by the queued event flow:

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

The handler currently changes:

- `points`
- `points_add`
- `word_count`
- `word_add`
- `article_count`
- `article_add`
- `point_group`
- `rank`
- `rank_change`

So article counters are no longer only carried forward; they are incremented by article-create events.

### `user-point-group`

Source: [src/api/user-point-group/content-types/user-point-group/schema.json](/Users/James/develop/langgo/langgo_strapi4/src/api/user-point-group/content-types/user-point-group/schema.json:1)

This stores a user's current point-group assignment:

- `user`
- `point_group`
- `period_points`

It is created on the first qualifying daily event if the user does not already have one, and later updated when first-event-of-day reassignment is needed.

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
5. Updates streaks, tier, `last_reviewed_at`, `next_review_at`, and `is_remembered` when the review is effective
6. If the effective review changes the tier, moves `flashcard-stat.word_count` from the old tier row to the new tier row in the same transaction
7. After the transaction commits, dispatches a `flashcard.review.completed` event through `event-api`

The queue handler then performs the side effects:

1. Creates the `reviewlog` row
2. Loads the active `point-rule`
3. Calculates reward points from the review event
3. Writes `reviewlog.points_awarded`
4. Ensures there is a previous-day `user-point` snapshot
5. Adds or updates today's `user-point` row
6. Assigns `user-point-group` and `point-group` for users who do not yet have one
7. Hosts extension hooks for future side effects

This means `reviewlog` is now eventually consistent with the flashcard update. The flashcard update is the synchronous core path; the log write and point updates are asynchronous queue work.

Current synchronous `flashcard-stat` behavior:

- `flashcard-stat` is not owned by the queued review event
- it is updated in the review transaction together with the `flashcard`
- cooldown review:
  - no `flashcard-stat` change
- effective review with no tier change:
  - no `flashcard-stat` change
- effective review with tier change:
  - decrement old tier row
  - increment new tier row
- missing stat rows are created on demand

The queued event includes:

- `reviewed_at = now`
- `result = correct|wrong`
- `level = currentTier?.tier?.toLowerCase()`
- `effective = !reviewIsOnCooldown`
- `newlevel = resulting tier after promotion/demotion logic`

So each resulting `reviewlog` still records both:

- the tier before the review changes the flashcard in `level`
- the resulting tier after calculation in `newlevel`

Current local point behavior:

- the local Strapi event handler does not know point-rule details
- it delegates point updates to `point-service`
- `point-service` reads the first `point-rule` entry
- `review_point` is added for each handled review event
- `review_tier_up_point` is added when `newlevel` is above `level`
- `new_word_point` is added for each handled `word_definition.created` event
- `article_point` is added for each handled `user_article.created` event
- the per-event value is stored in `reviewlog.points_awarded`
- the daily snapshot is stored in `user-point`
- if the previous day row is missing, the handler backfills it before updating today's row
- honor-title calculation only runs when today's `user-point` row is being created for the first time
- point-group / group-rank calculation only runs when today's `user-point` row is being created for the first time

## How Word-Definition Create Is Recorded

Source: [src/api/word-definition/controllers/word-definition.js](/Users/James/develop/langgo/langgo_strapi4/src/api/word-definition/controllers/word-definition.js:1)

The runtime endpoint is:

- `POST /api/word-definitions`

When a brand-new `word_definition` is created, the controller:

1. validates the user and payload
2. finds or creates the `word`
3. finds or creates the `part_of_speech`
4. creates the new `word_definition`
5. creates the user's `flashcard` for that `word_definition`
6. dispatches `word_definition.created` through `event-api`

The queued handler then:

1. routes the event by `event`
2. calls `point-service`
3. loads `point-rule.new_word_point`
4. upserts today's `user-point`
5. increments:
   - `points`
   - `points_add`
   - `word_count`
   - `word_add`
6. if this is the first event creating today's row, also runs:
   - honor-title sync
   - group-rank / point-group sync

The controller still separately pushes the background word-processing job for exam-option generation. That queue is independent from the event/point pipeline described here.

## How Registration Bootstraps Flashcard Stats

Sources:

- [src/services/flashcard-stat-bootstrap.js](/Users/James/develop/langgo/langgo_strapi4/src/services/flashcard-stat-bootstrap.js:1)
- [src/extensions/users-permissions/strapi-server.js](/Users/James/develop/langgo/langgo_strapi4/src/extensions/users-permissions/strapi-server.js:1)
- [src/api/user-profile/controllers/user-profile.js](/Users/James/develop/langgo/langgo_strapi4/src/api/user-profile/controllers/user-profile.js:1)

Registration flows currently covered:

- `POST /api/auth/local/register`
- `POST /api/user-profiles/register`

Both flows now call the shared `flashcard-stat-bootstrap` service after the user is created.

Bootstrap behavior:

1. Load all review tiers through `tier-service.getAllTiers()`
2. Load existing `flashcard-stat` rows for the new user
3. Build the set of already-covered tier ids
4. For each missing tier, create:
   - `user = new user`
   - `review_tire = tier.id`
   - `word_count = 0`

Effect:

- every newly registered user starts with a complete `flashcard-stat` set
- later stat-update logic can assume the per-tier rows already exist

## How User-Article Create Is Recorded

Source: [src/api/user-article/controllers/user-article.js](/Users/James/develop/langgo/langgo_strapi4/src/api/user-article/controllers/user-article.js:1)

The runtime endpoint is:

- `POST /api/user-articles`

When a new article is created, the controller:

1. validates the authenticated user and payload
2. creates `user_article`
3. sets `user` on the saved article
4. derives `word_count` from the content when it is not provided
5. dispatches `user_article.created` through `event-api`

The queued handler then:

1. routes the event by `event`
2. calls `point-service`
3. loads `point-rule.article_point`
4. upserts today's `user-point`
5. increments:
   - `points`
   - `points_add`
   - `article_count`
   - `article_add`
6. if this is the first event creating today's row, also runs:
   - honor-title sync
   - group-rank / point-group sync

### Daily `user-point` write logic

The handler follows this order:

1. Calculate `points_awarded`
2. Find today's `user-point` by `user + record_date`
3. Ensure there is a previous-day `user-point` snapshot
4. If today already exists:
   update the relevant delta columns on that row
5. If today does not exist:
   create a new row using the previous snapshot as the base, then add today's delta

Current snapshot rule:

- previous day row missing:
  backfill one from the latest prior snapshot, or zeroes if no history exists
- today row missing:
  create it from the previous snapshot plus today's awarded points
- today row exists:
  increment `points` / `points_add` and any event-specific counters such as `word_count` / `word_add`
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
   - endpoint dispatches through `event-api` instead of writing `reviewlog` directly
   - local handler writes `reviewlog` and daily `user-point`
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:239)

2. Synchronous `flashcard-stat` update during review
   - effective review tier changes move `flashcard-stat.word_count` in the same transaction as the flashcard update
   - missing stat rows are created on demand
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:385)

3. Review list due filtering uses `next_review_at`
   - `GET /api/review-flashcards` returns only cards whose `next_review_at` is null or due
   - non-due cards are excluded without a full in-memory scan
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:437)

4. New word-definition flow
   - word-definition create endpoint saves `word_definition`
   - endpoint dispatches `word_definition.created` through `event-api`
   - queue handler calls `point-service`
   - daily `user-point` is updated with `new_word_point`, `word_count`, and `word_add`
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:365)

5. Registration bootstrap for `flashcard-stat`
   - `registerWithProfile` creates one `flashcard-stat` row per review tier
   - each bootstrapped row starts with `word_count = 0`
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:500)

6. Flashcard statistics summary
   - `GET /api/flashcard-stat` returns materialized tier counts from `flashcard-stat`
   - due totals are still calculated live from `flashcard`
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:534)

7. New article flow
   - user-article create endpoint saves `user_article`
   - endpoint dispatches `user_article.created` through `event-api`
   - queue handler calls `point-service`
   - daily `user-point` is updated with `article_point`, `article_count`, and `article_add`
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:457)

8. Idempotency
   - the same `event_id` does not double-write `reviewlog`
   - the same `event_id` does not double-award points
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:549)

9. Same-day gating
   - if today's `user-point` already exists, same-day reviews only update `points` and `points_add`
   - same-day reviews do not recalculate `honor_title`
   - same-day reviews do not recalculate `user-point-group` or `group-rank`
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:607)

10. Group-rank threshold crossed on a second same-day review
   - a user can move from `278` to `280` points on the same day
   - if today's row already existed before those reviews, `group-rank` stays unchanged
   - no new target-rank group is created in that case
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:719)

11. Honor-title threshold crossed on same-day follow-up reviews
   - if today's row already existed before the reviews, the user can cross the next honor threshold
   - `honor_title` still stays unchanged for those same-day updates
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:886)

12. First review creates the day row and promotes honor title
   - previous day can be one point below the next honor threshold
   - first review of the day can promote `user.honor_title`
   - the created daily `user-point` stores the promoted `rank`
   - the created daily `user-point` stores `rank_change`
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:1034)

13. New user bootstrap
   - a new user with no `user-point-group` and no `honor_title` gets both on first review
   - if the target `group-rank` has no `point_group`, the first group is created
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:1174)

14. Reassignment to a higher group rank on first review of the day
   - a user with `279` period points can cross to `282`
   - on the first review event of the day, the user is reassigned to `Learner`
   - if `Learner` has no existing groups, the first one is created and assigned
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:1230)

15. Group split behavior
   - assignment goes to the least-filled existing group first
   - when membership reaches `2 * group_size`, the group is split into two groups
   - reference:
     [test/integration/strapi-review.integration.test.js](/Users/James/develop/langgo/langgo_strapi4/test/integration/strapi-review.integration.test.js:1109)

## Queue Drivers

Sources:

- [src/services/review-event-queue.js](/Users/James/develop/langgo/langgo_strapi4/src/services/review-event-queue.js:1)
- [src/services/review-event-queue-drivers/internal.js](/Users/James/develop/langgo/langgo_strapi4/src/services/review-event-queue-drivers/internal.js:1)
- [src/services/review-event-queue-drivers/pubsub.js](/Users/James/develop/langgo/langgo_strapi4/src/services/review-event-queue-drivers/pubsub.js:1)

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
- `next_review_at` is not updated
- The queued `reviewlog.effective = false`
- The queued `reviewlog.newlevel = reviewlog.level`

If the review is effective:

- The flashcard is updated
- `last_reviewed_at` becomes the review time
- `next_review_at` is recalculated from the resulting tier cooldown
- The queued event still carries `effective = true`

`next_review_at` is now the fast-read due field used by:

- `GET /api/review-flashcards`

## Promotion and Demotion Rules

Source: [src/api/flashcard/controllers/flashcard.js](/Users/James/develop/apple/langgo_strapi4/src/api/flashcard/controllers/flashcard.js:177)

### On `correct`

When the review is effective and `result === "correct"`:

- `correct_streak` is incremented by 1
- `wrong_streak` is reset to `0`
- `review_tire` is recalculated from the new `correct_streak`
- `last_reviewed_at` is updated
- `next_review_at` is updated to `reviewed_at + resulting tier cooldown`
- `is_remembered = true` if the new tier is `remembered`
- The queued `reviewlog.effective = true`
- The queued `reviewlog.newlevel` is the promoted or recalculated tier

### On `wrong`

When the review is effective and `result === "wrong"`:

- `wrong_streak` is incremented by 1
- `last_reviewed_at` is updated
- `next_review_at` is updated to `reviewed_at + resulting tier cooldown`
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

Sources:

- [src/api/flashcard/controllers/flashcard.js](/Users/James/develop/apple/langgo_strapi4/src/api/flashcard/controllers/flashcard.js:67)
- [src/api/flashcard-stat/services/flashcard-stat.js](/Users/James/develop/langgo/langgo_strapi4/src/api/flashcard-stat/services/flashcard-stat.js:1)

There are now two read paths.

### `GET /api/review-flashcards`

This endpoint uses `next_review_at` directly.

A card is due when:

- `next_review_at` is `null`, or
- `next_review_at <= now`

Current performance behavior:

- filtering happens in the database
- count and pagination happen in the database
- only the returned page gets full relation populate
- the list is ordered by `next_review_at ASC, id ASC`

### `GET /api/flashcard-stat`

This endpoint reads stable counts from `flashcard-stat`, but due counts are still calculated live from `flashcard`.

Its current due rule is:

- `last_reviewed_at` is `null`, or
- `now >= last_reviewed_at + cooldown_hours`

The tier used for that cooldown is:

- `flashcard.review_tire`, if present
- otherwise, the tier derived from `correct_streak`

## How Flashcard Statistics Are Queried

Sources:

- [src/api/flashcard/controllers/flashcard.js](/Users/James/develop/apple/langgo_strapi4/src/api/flashcard/controllers/flashcard.js:309)
- [src/api/flashcard-stat/services/flashcard-stat.js](/Users/James/develop/langgo/langgo_strapi4/src/api/flashcard-stat/services/flashcard-stat.js:1)

`GET /api/flashcard-stat` is now a mixed read model:

- stable counts come from `flashcard-stat`
- live due counts come from `flashcard`

Current response semantics:

- `totalCards`
  - sum of all `flashcard-stat.word_count` rows for the user
- `remembered`
  - the materialized count for the `remembered` tier
- `byTier[*].count`
  - the materialized `flashcard-stat.word_count` for that tier
- `dueForReview`
  - calculated live from flashcards
- `byTier[*].dueCount`
  - calculated live from flashcards using the same due rule
- `reviewed`
  - currently `null`
- `hardToRemember`
  - currently `null`
- `byTier[*].hardToRememberCount`
  - currently `null`

This keeps stable aggregate counts out of the request-time flashcard scan while still returning accurate due totals.

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
