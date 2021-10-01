
# Get more information

- [schema.json](https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json)
- trigger completion in coc-settings
## `sumneko-lua.enable`
- type: `boolean`
- default: `true`
- description:    Enable coc-sumneko-lua extension
## `sumneko-lua.prompt`
- type: `boolean`
- default: `true`
- description:    Prompt when server is not found or when server can be updated
## `sumneko-lua.locale`
- type: `string`
- default: `en-us`
- description:    The localized language used
## `sumneko-lua.logPath`
- type: `string`
- default: ``
- description:    The log path
## `sumneko-lua.enableNvimLuaDev`
- type: `boolean`
- default: `false`
- description:    Enable the nvim lua development
## `sumneko-lua.checkUpdate`
- type: `boolean`
- default: `true`
- description:    Automatically check for updates after startup
## `sumneko-lua.inlayHints.typeHintsPrefix`
- type: `string`
- default: `« `
- description:    Prefix for type hints
## `sumneko-lua.inlayHints.paramHintsPrefix`
- type: `string`
- default: `» `
- description:    Prefix for parameter hints
## `sumneko-lua.inlayHints.trimSemicolon`
- type: `boolean`
- default: `true`
- description:    Trim Semicolon
## `sumneko-lua.inlayHints.refreshOnInsertMode`
- type: `boolean`
- default: `false`
- description:    Whether to refresh inlayHints on insert mode
## `Lua.color.mode`
- type: `string`
- default: `Semantic`
- description:    Color mode.
## `Lua.completion.autoRequire`
- type: `boolean`
- default: `true`
- description:    When the input looks like a file name, automatically `require` this file.
## `Lua.completion.callSnippet`
- type: `string`
- default: `Disable`
- description:    Shows function call snippets.
## `Lua.completion.displayContext`
- type: `integer`
- default: `0`
- description:    Previewing the relevant code snippet of the suggestion may help you understand the usage of the suggestion. The number set indicates the number of intercepted lines in the code fragment. If it is set to `0`, this feature can be disabled.
## `Lua.completion.enable`
- type: `boolean`
- default: `true`
- description:    Enable completion.
## `Lua.completion.keywordSnippet`
- type: `string`
- default: `Replace`
- description:    Shows keyword syntax snippets.
## `Lua.completion.requireSeparator`
- type: `string`
- default: `.`
- description:    The separator used when `require`.
## `Lua.completion.showParams`
- type: `boolean`
- default: `true`
- description:    Display parameters in completion list. When the function has multiple definitions, they will be displayed separately.
## `Lua.completion.showWord`
- type: `string`
- default: `Fallback`
- description:    Show contextual words in suggestions.
## `Lua.completion.workspaceWord`
- type: `boolean`
- default: `true`
- description:    Whether the displayed context word contains the content of other files in the workspace.
## `Lua.diagnostics.disable`
- type: `array`
- default: `undefined`
- description:    Disabled diagnostic (Use code in hover brackets).

## `Lua.diagnostics.enable`
- type: `boolean`
- default: `true`
- description:    Enable diagnostics.
## `Lua.diagnostics.globals`
- type: `array`
- default: `undefined`
- description:    Defined global variables.

## `Lua.diagnostics.ignoredFiles`
- type: `string`
- default: `Opened`
- description:    How to diagnose ignored files.
## `Lua.diagnostics.libraryFiles`
- type: `string`
- default: `Opened`
- description:    How to diagnose files loaded via `Lua.workspace.library`.
## `Lua.diagnostics.neededFileStatus`
- type: `object`
- default: `undefined`
- description:    If you want to check only opened files, choice Opened; else choice Any.

## `Lua.diagnostics.severity`
- type: `object`
- default: `undefined`
- description:    Modified diagnostic severity.

## `Lua.diagnostics.workspaceDelay`
- type: `integer`
- default: `0`
- description:    Latency (milliseconds) for workspace diagnostics. When you start the workspace, or edit any file, the entire workspace will be re-diagnosed in the background. Set to negative to disable workspace diagnostics.
## `Lua.diagnostics.workspaceRate`
- type: `integer`
- default: `100`
- description:    Workspace diagnostics run rate (%). Decreasing this value reduces CPU usage, but also reduces the speed of workspace diagnostics. The diagnosis of the file you are currently editing is always done at full speed and is not affected by this setting.
## `Lua.hint.enable`
- type: `boolean`
- default: `true`
- description:    Enabel hint.
## `Lua.hint.paramName`
- type: `string`
- default: `All`
- description:    Show hints of parameter name at the function call.
## `Lua.hint.paramType`
- type: `boolean`
- default: `true`
- description:    Show type hints at the parameter of the function.
## `Lua.hint.setType`
- type: `boolean`
- default: `false`
- description:    Show hints of type at assignment operation.
## `Lua.hover.enable`
- type: `boolean`
- default: `true`
- description:    Enable hover.
## `Lua.hover.enumsLimit`
- type: `integer`
- default: `5`
- description:    When the value corresponds to multiple types, limit the number of types displaying.
## `Lua.hover.previewFields`
- type: `integer`
- default: `20`
- description:    When hovering to view a table, limits the maximum number of previews for fields.
## `Lua.hover.viewNumber`
- type: `boolean`
- default: `true`
- description:    Hover to view numeric content (only if literal is not decimal).
## `Lua.hover.viewString`
- type: `boolean`
- default: `true`
- description:    Hover to view the contents of a string (only if the literal contains an escape character).
## `Lua.hover.viewStringMax`
- type: `integer`
- default: `1000`
- description:    The maximum length of a hover to view the contents of a string.
## `Lua.misc.parameters`
- type: `array`
- default: ``
- description:    Additional command line parameters when starting the language service.
## `Lua.runtime.builtin`
- type: `object`
- default: `undefined`
- description:    Adjust the enabled state of the built-in library. You can disable (or redefine) the non-existent library according to the actual runtime environment.

* `default`: Indicates that the library will be enabled or disabled according to the runtime version
* `enable`: always enable
* `disable`: always disable

## `Lua.runtime.fileEncoding`
- type: `string`
- default: `utf8`
- description:    File encoding. The `ansi` option is only available under the `Windows` platform.
## `Lua.runtime.nonstandardSymbol`
- type: `array`
- default: `undefined`
- description:    Supports non-standard symbols. Make sure that your runtime environment supports these symbols.
## `Lua.runtime.path`
- type: `array`
- default: `?.lua,?/init.lua`
- description:    When using `require`, how to find the file based on the input name.
Setting this config to `?/init.lua` means that when you enter `require 'myfile'`, all `**/myfile/init.lua` will be searched from the loaded files.
If you want to load files outside the workspace, you need to set `Lua.workspace.library` first.

## `Lua.runtime.plugin`
- type: `string`
- default: ``
- description:    Plugin path. Please read [wiki](https://github.com/sumneko/lua-language-server/wiki/Plugin) to learn more.
## `Lua.runtime.special`
- type: `object`
- default: `undefined`
- description:    The custom global variables are regarded as some special built-in variables, and the language server will provide special support
The following example shows that 'include' is treated as' require '.
```json
"Lua.runtime.special" : {
    "include" : "require"
}
```

## `Lua.runtime.unicodeName`
- type: `boolean`
- default: `false`
- description:    Allows Unicode characters in name.
## `Lua.runtime.version`
- type: `string`
- default: `Lua 5.4`
- description:    Lua runtime version.
## `Lua.signatureHelp.enable`
- type: `boolean`
- default: `true`
- description:    Enable signature help.
## `Lua.telemetry.enable`
- type: `boolean,null`
- default: `null`
- description:    Enable telemetry to send your editor information and error logs over the network. Read our privacy policy [here](https://github.com/sumneko/lua-language-server/wiki/Privacy-Policy).

## `Lua.window.progressBar`
- type: `boolean`
- default: `true`
- description:    Show progress bar in status bar.
## `Lua.window.statusBar`
- type: `boolean`
- default: `true`
- description:    Show extension status in status bar.
## `Lua.workspace.checkThirdParty`
- type: `boolean`
- default: `true`
- description:    Automatic detection and adaptation of third-party libraries, currently supported libraries are:

* OpenResty
* Cocos4.0
* LÖVE
* Jass

## `Lua.workspace.ignoreDir`
- type: `array`
- default: `.vscode`
- description:    Ignored files and directories (Use `.gitignore` grammar).

## `Lua.workspace.ignoreSubmodules`
- type: `boolean`
- default: `true`
- description:    Ignore submodules.
## `Lua.workspace.library`
- type: `array`
- default: `undefined`
- description:    In addition to the current workspace, which directories will load files from.
## `Lua.workspace.maxPreload`
- type: `integer`
- default: `1000`
- description:    Max preloaded files.
## `Lua.workspace.preloadFileSize`
- type: `integer`
- default: `100`
- description:    Skip files larger than this value (KB) when preloading.
## `Lua.workspace.useGitIgnore`
- type: `boolean`
- default: `true`
- description:    Ignore files list in `.gitignore` .
## `Lua.workspace.userThirdParty`
- type: `array`
- default: `undefined`
- description:    Add private third-party library configuration file paths here, please refer to the built-in [configuration file path](https://github.com/sumneko/lua-language-server/tree/master/meta/3rd)
