/* eslint-disable @typescript-eslint/no-var-requires */
'use strict';

const fs = require('fs');
const fetch = require('node-fetch');

const packageJson = require('./package.json');
const config = require('./coc-sumneko-lua.json');

async function main() {
  let resp = await fetch('https://cdn.jsdelivr.net/gh/sumneko/vscode-lua@master/setting/schema.json');
  let schema = await resp.json();
  let properties = schema.properties;

  // merge config
  console.log('merge config');
  Object.keys(properties).forEach((k) => {
    config[k] = properties[k];
  });

  // write package.json
  console.log('write package.json');
  packageJson.contributes.configuration.properties = config;
  fs.writeFileSync('./package.json', JSON.stringify(packageJson, null, 2) + '\n');

  // write settings.md
  console.log('write settings.md');
  let settingsFileStream = fs.createWriteStream('./settings.md');
  settingsFileStream.write(`
# Get more information

- [schema.json](https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json)
- trigger completion in coc-settings
`);
  Object.keys(config).forEach((key) => {
    let v = config[key];
    settingsFileStream.write(
      `## \`${key}\`\n- type: \`${v.type}\`\n- default: \`${v.default}\`\n- description:    ${
        v.description ? v.description : v.markdownDescription
      }\n`
    );
  });
}

main();
