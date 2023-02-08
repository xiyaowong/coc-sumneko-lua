
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
- description:    Automatically check for updates after startup(Only one check within 4 hours)
## `sumneko-lua.serverDir`
- type: `string`
- default: `null`
- description:    The server directory which contains: bin/, changelog.md, debugger.lua, locale/, main.lua, meta/, script/. Download and set by default
## `Lua.codeLens.enable`
- type: `boolean`
- default: `false`
- description:    Enable code lens.
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
## `Lua.completion.postfix`
- type: `string`
- default: `@`
- description:    The symbol used to trigger the postfix suggestion.
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
- default: ``
- description:    Disabled diagnostic (Use code in hover brackets).
## `Lua.diagnostics.disableScheme`
- type: `array`
- default: `git`
- description:    Do not diagnose Lua files that use the following scheme.
## `Lua.diagnostics.enable`
- type: `boolean`
- default: `true`
- description:    Enable diagnostics.
## `Lua.diagnostics.globals`
- type: `array`
- default: ``
- description:    Defined global variables.
## `Lua.diagnostics.groupFileStatus`
- type: `object`
- default: `undefined`
- description:    Modify the diagnostic needed file status in a group.

* Opened:  only diagnose opened files
* Any:     diagnose all files
* None:    disable this diagnostic

`Fallback` means that diagnostics in this group are controlled by `diagnostics.neededFileStatus` separately.
Other settings will override individual settings without end of `!`.

## `Lua.diagnostics.groupSeverity`
- type: `object`
- default: `undefined`
- description:    Modify the diagnostic severity in a group.
`Fallback` means that diagnostics in this group are controlled by `diagnostics.severity` separately.
Other settings will override individual settings without end of `!`.

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
- description:    * Opened:  only diagnose opened files
* Any:     diagnose all files
* None:    disable this diagnostic

End with `!` means override the group setting `diagnostics.groupFileStatus`.

## `Lua.diagnostics.severity`
- type: `object`
- default: `undefined`
- description:    Modify the diagnostic severity.

End with `!` means override the group setting `diagnostics.groupSeverity`.

## `Lua.diagnostics.unusedLocalExclude`
- type: `array`
- default: ``
- description:    Do not diagnose `unused-local` when the variable name matches the following pattern.
## `Lua.diagnostics.workspaceDelay`
- type: `integer`
- default: `3000`
- description:    Latency (milliseconds) for workspace diagnostics.
## `Lua.diagnostics.workspaceEvent`
- type: `string`
- default: `OnSave`
- description:    Set the time to trigger workspace diagnostics.
## `Lua.diagnostics.workspaceRate`
- type: `integer`
- default: `100`
- description:    Workspace diagnostics run rate (%). Decreasing this value reduces CPU usage, but also reduces the speed of workspace diagnostics. The diagnosis of the file you are currently editing is always done at full speed and is not affected by this setting.
## `Lua.doc.packageName`
- type: `array`
- default: ``
- description:    Treat specific field names as package, e.g. `m_*` means `XXX.m_id` and `XXX.m_type` are package, witch can only be accessed in the file where the definition is located.
## `Lua.doc.privateName`
- type: `array`
- default: ``
- description:    Treat specific field names as private, e.g. `m_*` means `XXX.m_id` and `XXX.m_type` are private, witch can only be accessed in the class where the definition is located.
## `Lua.doc.protectedName`
- type: `array`
- default: ``
- description:    Treat specific field names as protected, e.g. `m_*` means `XXX.m_id` and `XXX.m_type` are protected, witch can only be accessed in the class where the definition is located and its subclasses.
## `Lua.format.defaultConfig`
- type: `object`
- default: ``
- description:    The default format configuration. Has a lower priority than `.editorconfig` file in the workspace.
Read [formatter docs](https://github.com/CppCXY/EmmyLuaCodeStyle/tree/master/docs) to learn usage.

## `Lua.format.enable`
- type: `boolean`
- default: `true`
- description:    Enable code formatter.
## `Lua.hint.arrayIndex`
- type: `string`
- default: `Auto`
- description:    Show hints of array index when constructing a table.
## `Lua.hint.await`
- type: `boolean`
- default: `true`
- description:    If the called function is marked `---@async`, prompt `await` at the call.
## `Lua.hint.enable`
- type: `boolean`
- default: `true`
- description:    Enable inlay hint.
## `Lua.hint.paramName`
- type: `string`
- default: `All`
- description:    Show hints of parameter name at the function call.
## `Lua.hint.paramType`
- type: `boolean`
- default: `true`
- description:    Show type hints at the parameter of the function.
## `Lua.hint.semicolon`
- type: `string`
- default: `SameLine`
- description:    If there is no semicolon at the end of the statement, display a virtual semicolon.
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
## `Lua.hover.expandAlias`
- type: `boolean`
- default: `true`
- description:    Whether to expand the alias. For example, expands `---@alias myType boolean|number` appears as `boolean|number`, otherwise it appears as `myType'.

## `Lua.hover.previewFields`
- type: `integer`
- default: `50`
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
## `Lua.misc.executablePath`
- type: `string`
- default: ``
- description:    Specify the executable path in VSCode.
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
## `Lua.runtime.meta`
- type: `string`
- default: `${version} ${language} ${encoding}`
- description:    Format of the directory name of the meta files.
## `Lua.runtime.nonstandardSymbol`
- type: `array`
- default: ``
- description:    Supports non-standard symbols. Make sure that your runtime environment supports these symbols.
## `Lua.runtime.path`
- type: `array`
- default: `?.lua,?/init.lua`
- description:    When using `require`, how to find the file based on the input name.
Setting this config to `?/init.lua` means that when you enter `require 'myfile'`, `${workspace}/myfile/init.lua` will be searched from the loaded files.
if `runtime.pathStrict` is `false`, `${workspace}/**/myfile/init.lua` will also be searched.
If you want to load files outside the workspace, you need to set `Lua.workspace.library` first.

## `Lua.runtime.pathStrict`
- type: `boolean`
- default: `false`
- description:    When enabled, `runtime.path` will only search the first level of directories, see the description of `runtime.path`.
## `Lua.runtime.plugin`
- type: `string`
- default: ``
- description:    Plugin path. Please read [wiki](https://github.com/LuaLS/lua-language-server/wiki/Plugins) to learn more.
## `Lua.runtime.pluginArgs`
- type: `array`
- default: ``
- description:    Additional arguments for the plugin.
## `Lua.runtime.special`
- type: `object`
- default: ``
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
## `Lua.semantic.annotation`
- type: `boolean`
- default: `true`
- description:    Semantic coloring of type annotations.
## `Lua.semantic.enable`
- type: `boolean`
- default: `true`
- description:    Enable semantic color. You may need to set `editor.semanticHighlighting.enabled` to `true` to take effect.
## `Lua.semantic.keyword`
- type: `boolean`
- default: `false`
- description:    Semantic coloring of keywords/literals/operators. You only need to enable this feature if your editor cannot do syntax coloring.
## `Lua.semantic.variable`
- type: `boolean`
- default: `true`
- description:    Semantic coloring of variables/fields/parameters.
## `Lua.signatureHelp.enable`
- type: `boolean`
- default: `true`
- description:    Enable signature help.
## `Lua.spell.dict`
- type: `array`
- default: ``
- description:    Custom words for spell checking.
## `Lua.type.castNumberToInteger`
- type: `boolean`
- default: `true`
- description:    Allowed to assign the `number` type to the `integer` type.
## `Lua.type.weakNilCheck`
- type: `boolean`
- default: `false`
- description:    When checking the type of union type, ignore the `nil` in it.

When this setting is `false`, the `number|nil` type cannot be assigned to the `number` type. It can be with `true`.

## `Lua.type.weakUnionCheck`
- type: `boolean`
- default: `false`
- description:    Once one subtype of a union type meets the condition, the union type also meets the condition.

When this setting is `false`, the `number|boolean` type cannot be assigned to the `number` type. It can be with `true`.

## `Lua.typeFormat.config`
- type: `object`
- default: `undefined`
- description:    Configures the formatting behavior while typing Lua code.
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
* LÖVR
* skynet
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
- default: ``
- description:    In addition to the current workspace, which directories will load files from. The files in these directories will be treated as externally provided code libraries, and some features (such as renaming fields) will not modify these files.
## `Lua.workspace.maxPreload`
- type: `integer`
- default: `5000`
- description:    Max preloaded files.
## `Lua.workspace.preloadFileSize`
- type: `integer`
- default: `500`
- description:    Skip files larger than this value (KB) when preloading.
## `Lua.workspace.useGitIgnore`
- type: `boolean`
- default: `true`
- description:    Ignore files list in `.gitignore` .
## `Lua.workspace.userThirdParty`
- type: `array`
- default: ``
- description:    Add private third-party library configuration file paths here, please refer to the built-in [configuration file path](https://github.com/LuaLS/lua-language-server/tree/master/meta/3rd)
