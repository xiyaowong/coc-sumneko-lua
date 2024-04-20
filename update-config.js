'use strict'

const fs = require('node:fs')
const fetch = require('node-fetch')

const packageJson = require('./package.json')
const config = require('./coc-sumneko-lua.json')

const overrids = {
  'Lua.hint.enable': {
    default: true,
  },
  'Lua.misc.parameters': {
    default: [],
    markdownDescription: 'Additional command line parameters when starting the language service.',
  },
  'Lua.misc.executablePath': {
    markdownDescription: 'Specify the executable path.',
  },
}

async function main() {
  const resp = await fetch('https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json')
  const schema = await resp.json()
  const properties = schema.properties

  // merge config
  console.log('merge config')
  Object.keys(properties).forEach((k) => {
    if (k.includes('.') || !properties[k].properties)
      config[`Lua.${k}`] = properties[k]
  })
  Object.keys(overrids).forEach((key) => {
    config[key] = { ...config[key], ...overrids[key] }
  })

  // write package.json
  console.log('write package.json')
  packageJson.contributes.configuration.properties = config
  fs.writeFileSync('./package.json', `${JSON.stringify(packageJson, null, 2)}\n`)

  // write settings.md
  console.log('write settings.md')
  const settingsFileStream = fs.createWriteStream('./settings.md')
  settingsFileStream.write(`
# Get more information

- [schema.json](https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json)
- trigger completion in coc-settings
`)
  Object.keys(config).forEach((key) => {
    const v = config[key]
    settingsFileStream.write(
      `## \`${key}\`\n- type: \`${v.type}\`\n- default: \`${JSON.stringify(v.default)}\`\n- description:    ${
        v.description ? v.description : v.markdownDescription
      }\n`,
    )
  })
}

main()
