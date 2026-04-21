# 🚀 Getting started with Strapi

Strapi comes with a full featured [Command Line Interface](https://docs.strapi.io/dev-docs/cli) (CLI) which lets you scaffold and manage your project in seconds.

### `develop`

Start your Strapi application with autoReload enabled. [Learn more](https://docs.strapi.io/dev-docs/cli#strapi-develop)

```
npm run develop
# or
yarn develop
```

### `start`

Start your Strapi application with autoReload disabled. [Learn more](https://docs.strapi.io/dev-docs/cli#strapi-start)

```
npm run start
# or
yarn start
```

### `build`

Build your admin panel. [Learn more](https://docs.strapi.io/dev-docs/cli#strapi-build)

```
npm run build
# or
yarn build
```

### `test`

Run the fast unit tests.

```
npm test
```

### `test:integration`

Run the Postgres-backed integration tests that boot Strapi and verify the review flow.

Safety requirement:

- `DATABASE_NAME` must be explicitly set to a test or CI database name containing `test` or `ci`

Example:

```bash
DATABASE_HOST=127.0.0.1 \
DATABASE_PORT=5432 \
DATABASE_NAME=langgo_ci_test \
DATABASE_USERNAME=postgres \
DATABASE_PASSWORD=postgres \
npm run test:integration
```

If you are using the shared local Cloud SQL-backed setup from this workspace, this also works:

```bash
DATABASE_NAME=langgo-en-dev2 \
DATABASE_SCHEMA=ci_test \
npm test -- test/integration/strapi-review.integration.test.js
```

## Google Pub/Sub

This project now exposes a Strapi service named `pubsub`.

Example usage in code:

```js
await strapi.service('pubsub').publishJson('my-topic', {
  event: 'flashcard.reviewed',
  flashcardId: 123,
});
```

Environment variables:

- `GOOGLE_PUBSUB_PROJECT_ID`: optional explicit Pub/Sub project id
- `GOOGLE_PROJECT_ID`: fallback project id
- `GOOGLE_PUBSUB_CREDENTIALS_JSON`: optional inline service account JSON for local/dev use
- `GOOGLE_CREDENTIALS_JSON`: fallback inline credentials JSON
- `GOOGLE_APPLICATION_CREDENTIALS`: optional path to a service account key file
- `REVIEWLOG_EVENTS_TOPIC`: optional Pub/Sub topic used to publish reviewlog-created events for PointServer

Recommended production setup on Cloud Run:

- do not mount a key file
- rely on Application Default Credentials from the Cloud Run service account
- grant that service account the minimum Pub/Sub IAM role it needs, typically `roles/pubsub.publisher` and/or `roles/pubsub.subscriber`

## Run With PointServer

Shared Pub/Sub resources:

- topic: `pointserver-reviewlogs`
- subscription: `pointserver-reviewlogs-sub`

The local `.env` is configured to publish reviewlog events to:

```bash
REVIEWLOG_EVENTS_TOPIC=pointserver-reviewlogs
```

Start Strapi:

```bash
npm install
npm run develop
```

Start PointServer in the sibling repo:

```bash
cd ../pointserver
npm install
npm run build
npm start
```

End-to-end flow:

1. Review a flashcard in Strapi.
2. Strapi creates `reviewlog` and publishes `reviewlog.created` to `pointserver-reviewlogs`.
3. PointServer consumes from `pointserver-reviewlogs-sub`.
4. Check the leaderboard API:

```bash
curl http://127.0.0.1:3000/leaderboard
curl http://127.0.0.1:3000/leaderboard/<userId>/points
```

## ⚙️ Deployment

Strapi gives you many possible deployment options for your project including [Strapi Cloud](https://cloud.strapi.io). Browse the [deployment section of the documentation](https://docs.strapi.io/dev-docs/deployment) to find the best solution for your use case.

## 📚 Learn more

- [Resource center](https://strapi.io/resource-center) - Strapi resource center.
- [Strapi documentation](https://docs.strapi.io) - Official Strapi documentation.
- [Strapi tutorials](https://strapi.io/tutorials) - List of tutorials made by the core team and the community.
- [Strapi blog](https://strapi.io/blog) - Official Strapi blog containing articles made by the Strapi team and the community.
- [Changelog](https://strapi.io/changelog) - Find out about the Strapi product updates, new features and general improvements.

Feel free to check out the [Strapi GitHub repository](https://github.com/strapi/strapi). Your feedback and contributions are welcome!

## ✨ Community

- [Discord](https://discord.strapi.io) - Come chat with the Strapi community including the core team.
- [Forum](https://forum.strapi.io/) - Place to discuss, ask questions and find answers, show your Strapi project and get feedback or just talk with other Community members.
- [Awesome Strapi](https://github.com/strapi/awesome-strapi) - A curated list of awesome things related to Strapi.

---

<sub>🤫 Psst! [Strapi is hiring](https://strapi.io/careers).</sub>
