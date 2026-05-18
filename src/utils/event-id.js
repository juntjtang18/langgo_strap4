'use strict';

const crypto = require('node:crypto');

function buildEventId() {
  return crypto.randomUUID
    ? crypto.randomUUID()
    : `${Date.now()}-${crypto.randomBytes(8).toString('hex')}`;
}

module.exports = {
  buildEventId,
};
