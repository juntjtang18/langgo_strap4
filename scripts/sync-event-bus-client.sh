#!/bin/bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
VENDOR_DIR="${ROOT_DIR}/vendor"
PACKAGE_JSON="${ROOT_DIR}/package.json"
LOCKFILE="${ROOT_DIR}/package-lock.json"
STATE_FILE="${VENDOR_DIR}/event-bus-client.commit"
REPO_URL="https://github.com/juntjtang18/event-bus-client.git"
PACKAGE_NAME="@langgo/event-bus-client"

mkdir -p "${VENDOR_DIR}"

REMOTE_SHA="$(git ls-remote "${REPO_URL}" HEAD | awk '{print $1}')"
if [ -z "${REMOTE_SHA}" ]; then
  echo "Failed to resolve remote HEAD for ${REPO_URL}" >&2
  exit 1
fi

CURRENT_SHA=""
if [ -f "${STATE_FILE}" ]; then
  CURRENT_SHA="$(cat "${STATE_FILE}")"
fi

CURRENT_SPEC="$(node -e "const pkg=require(process.argv[1]); console.log(pkg.dependencies['${PACKAGE_NAME}'] || '')" "${PACKAGE_JSON}")"

if [ "${CURRENT_SHA}" = "${REMOTE_SHA}" ] && [[ "${CURRENT_SPEC}" == file:vendor/langgo-event-bus-client-*.tgz ]]; then
  CURRENT_FILE="${CURRENT_SPEC#file:}"
  if [ -f "${ROOT_DIR}/${CURRENT_FILE}" ]; then
    echo "event-bus-client already synced at ${REMOTE_SHA}"
    exit 0
  fi
fi

TMP_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

echo "Syncing event-bus-client from ${REMOTE_SHA}"
git clone --depth 1 "${REPO_URL}" "${TMP_DIR}/repo" >/dev/null 2>&1
git -C "${TMP_DIR}/repo" fetch --depth 1 origin "${REMOTE_SHA}" >/dev/null 2>&1 || true
git -C "${TMP_DIR}/repo" checkout --detach "${REMOTE_SHA}" >/dev/null 2>&1

npm install --prefix "${TMP_DIR}/repo" >/dev/null
PACK_FILE="$(cd "${TMP_DIR}/repo" && npm pack | tail -n 1)"

find "${VENDOR_DIR}" -maxdepth 1 -name 'langgo-event-bus-client-*.tgz' -delete
cp "${TMP_DIR}/repo/${PACK_FILE}" "${VENDOR_DIR}/${PACK_FILE}"
echo "${REMOTE_SHA}" > "${STATE_FILE}"

node <<'EOF' "${PACKAGE_JSON}" "${LOCKFILE}" "${PACK_FILE}"
const fs = require('fs');

const [packageJsonPath, lockfilePath, packFile] = process.argv.slice(2);
const spec = `file:vendor/${packFile}`;

const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
packageJson.dependencies['@langgo/event-bus-client'] = spec;
fs.writeFileSync(packageJsonPath, `${JSON.stringify(packageJson, null, 2)}\n`);

if (fs.existsSync(lockfilePath)) {
  const lockfile = JSON.parse(fs.readFileSync(lockfilePath, 'utf8'));
  if (lockfile.packages && lockfile.packages['']) {
    lockfile.packages[''].dependencies['@langgo/event-bus-client'] = spec;
  }
  if (lockfile.dependencies && lockfile.dependencies['@langgo/event-bus-client']) {
    lockfile.dependencies['@langgo/event-bus-client'].version = spec;
  }
  if (lockfile.packages) {
    delete lockfile.packages['node_modules/@langgo/event-bus-client'];
  }
  fs.writeFileSync(lockfilePath, `${JSON.stringify(lockfile, null, 2)}\n`);
}
EOF

npm install --prefix "${ROOT_DIR}" >/dev/null
echo "event-bus-client synced to ${REMOTE_SHA}"
