# Review Tier Process

This document describes how this Strapi project records review activity, calculates the current review tier, and changes the review tier for a flashcard or a "word".

## Short Version

- The review state is stored on `flashcard`, not on `word` or `user-word`.
- A "word tier" is therefore the tier of the flashcard linked to that word definition for a given user.
- Review events are appended to `reviewlog`.
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
- `result`: `correct` or `wrong`
- `level`: the tier name at the time of review
- `effective`: whether this review counted after cooldown was checked
- `newlevel`: the tier name after the review calculation finished

Important detail:

- `reviewlog.level` still allows `daily`, but `review-tire.tier` does not define `daily`. In the current flashcard flow, the level written into logs comes from the current `review_tire.tier`.

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
4. Creates a `reviewlog` row for every call, even if the review is on cooldown.
5. Only updates streaks, tier, `last_reviewed_at`, and `is_remembered` when the review is effective.

The log write happens here:

- `reviewed_at = now`
- `result = correct|wrong`
- `level = currentTier?.tier?.toLowerCase()`
- `effective = !reviewIsOnCooldown`
- `newlevel = resulting tier after promotion/demotion logic`

That means each log now records both:

- the tier before the review changes the flashcard in `level`
- the resulting tier after calculation in `newlevel`

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

- A `reviewlog` is still created
- The flashcard itself is not updated
- `reviewlog.effective = false`
- `reviewlog.newlevel = reviewlog.level`

## Promotion and Demotion Rules

Source: [src/api/flashcard/controllers/flashcard.js](/Users/James/develop/apple/langgo_strapi4/src/api/flashcard/controllers/flashcard.js:177)

### On `correct`

When the review is effective and `result === "correct"`:

- `correct_streak` is incremented by 1
- `wrong_streak` is reset to `0`
- `review_tire` is recalculated from the new `correct_streak`
- `last_reviewed_at` is updated
- `is_remembered = true` if the new tier is `remembered`
- `reviewlog.effective = true`
- `reviewlog.newlevel` is the promoted or recalculated tier

### On `wrong`

When the review is effective and `result === "wrong"`:

- `wrong_streak` is incremented by 1
- `last_reviewed_at` is updated
- `correct_streak` is unchanged unless demotion happens
- `reviewlog.effective = true`

If `wrong_streak >= currentTier.demote_bar`:

- The card is demoted to the previous tier in the sorted tier list
- `correct_streak` is set to `prevTier.min_streak`
- `wrong_streak` is reset to `0`
- `review_tire` is set to the previous tier
- `is_remembered = false`
- `reviewlog.newlevel` is the demoted tier

If `wrong_streak < currentTier.demote_bar`:

- the flashcard stays in the current tier
- `reviewlog.newlevel` stays equal to `level`

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
