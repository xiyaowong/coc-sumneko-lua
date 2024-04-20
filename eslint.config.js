const wongxy = require('@wongxy/eslint-config').default

module.exports = wongxy({
  rules: {
    'node/prefer-global/process': 'off',
  },
})
