--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Return the current command-line type. Possible return values
-- 		are:
-- 		    :	normal Ex command
-- 		    >	debug mode command |debug-mode|
-- 		    /	forward search command
-- 		    ?	backward search command
-- 		    @	|input()| command
-- 		    -	|:insert| or |:append| command
-- 		    =	|i_CTRL-R_=|
-- 		Only works when editing the command line, thus requires use of
-- 		|c_CTRL-\_e| or |c_CTRL-R_=| or an expression mapping.
-- 		Returns an empty string otherwise.
-- 		Also see |getcmdpos()|, |setcmdpos()| and |getcmdline()|.
--- @return string
function vim.fn.getcmdtype() end

-- Ensure the buffer {expr} is loaded.  When the buffer name
-- 		refers to an existing file then the file is read.  Otherwise
-- 		the buffer will be empty.  If the buffer was already loaded
-- 		then there is no change.
-- 		If there is an existing swap file for the file of the buffer,
-- 		there will be no dialog, the buffer will be loaded anyway.
-- 		The {expr} argument is used like with |bufexists()|.
--- @return number
function vim.fn.bufload(expr) end

-- Return a |List| with spelling suggestions to replace {word}.
-- 		When {max} is given up to this number of suggestions are
-- 		returned.  Otherwise up to 25 suggestions are returned.
--
-- 		When the {capital} argument is given and it's non-zero only
-- 		suggestions with a leading capital will be given.  Use this
-- 		after a match with 'spellcapcheck'.
--
-- 		{word} can be a badly spelled word followed by other text.
-- 		This allows for joining two words that were split.  The
-- 		suggestions also include the following text, thus you can
-- 		replace a line.
--
-- 		{word} may also be a good word.  Similar words will then be
-- 		returned.  {word} itself is not included in the suggestions,
-- 		although it may appear capitalized.
--
-- 		The spelling information for the current window is used.  The
-- 		'spell' option must be set and the values of 'spelllang' and
-- 		'spellsuggest' are used.
--- @return list
function vim.fn.spellsuggest(word, max, capital) end

-- If {arg} is not specified, then information about all the tab
-- 		pages is returned as a List. Each List item is a Dictionary.
-- 		Otherwise, {arg} specifies the tab page number and information
-- 		about that one is returned.  If the tab page does not exist an
-- 		empty List is returned.
--
-- 		Each List item is a Dictionary with the following entries:
-- 			tabnr		tab page number.
-- 			variables	a reference to the dictionary with
-- 					tabpage-local variables
-- 			windows		List of |window-ID|s in the tab page.
--- @return list
function vim.fn.gettabinfo(expr) end

-- Get the value of a tab-local variable {varname} in tab page
-- 		{tabnr}. |t:var|
-- 		Tabs are numbered starting with one.
-- 		When {varname} is empty a dictionary with all tab-local
-- 		variables is returned.
-- 		Note that the name without "t:" must be used.
-- 		When the tab or variable doesn't exist {def} or an empty
-- 		string is returned, there is no error message.
function vim.fn.gettabvar(nr, varname, def) end

-- Get the value of window-local variable {varname} in window
-- 		{winnr} in tab page {tabnr}.
-- 		When {varname} is empty a dictionary with all window-local
-- 		variables is returned.
-- 		When {varname} is equal to "&" get the values of all
-- 		window-local options in a Dictionary.
-- 		Otherwise, when {varname} starts with "&" get the value of a
-- 		window-local option.
-- 		Note that {varname} must be the name without "w:".
-- 		Tabs are numbered starting with one.  For the current tabpage
-- 		use |getwinvar()|.
-- 		{winnr} can be the window number or the |window-ID|.
-- 		When {winnr} is zero the current window is used.
-- 		This also works for a global option, buffer-local option and
-- 		window-local option, but it doesn't work for a global variable
-- 		or buffer-local variable.
-- 		When the tab, window or variable doesn't exist {def} or an
-- 		empty string is returned, there is no error message.
-- 		Examples: >
-- 			:let list_is_on = gettabwinvar(1, 2, '&list')
-- 			:echo "myvar = " . gettabwinvar(3, 1, 'myvar')
-- <
-- 		To obtain all window-local variables use: >
-- 			gettabwinvar({tabnr}, {winnr}, '&')
function vim.fn.gettabwinvar(tabnr, winnr, name, def) end

-- The result is a Dict, which is the tag stack of window {nr}.
-- 		{nr} can be the window number or the |window-ID|.
-- 		When {nr} is not specified, the current window is used.
-- 		When window {nr} doesn't exist, an empty Dict is returned.
--
-- 		The returned dictionary contains the following entries:
-- 			curidx		Current index in the stack. When at
-- 					top of the stack, set to (length + 1).
-- 					Index of bottom of the stack is 1.
-- 			items		List of items in the stack. Each item
-- 					is a dictionary containing the
-- 					entries described below.
-- 			length		Number of entries in the stack.
--
-- 		Each item in the stack is a dictionary with the following
-- 		entries:
-- 			bufnr		buffer number of the current jump
-- 			from		cursor position before the tag jump.
-- 					See |getpos()| for the format of the
-- 					returned list.
-- 			matchnr		current matching tag number. Used when
-- 					multiple matching tags are found for a
-- 					name.
-- 			tagname		name of the tag
--
-- 		See |tagstack| for more information about the tag stack.
--- @return dict
function vim.fn.gettagstack(nr) end

-- Returns information about windows as a List with Dictionaries.
--
-- 		If {winid} is given Information about the window with that ID
-- 		is returned.  If the window does not exist the result is an
-- 		empty list.
--
-- 		Without {winid} information about all the windows in all the
-- 		tab pages is returned.
--
-- 		Each List item is a Dictionary with the following entries:
-- 			botline		last displayed buffer line
-- 			bufnr		number of buffer in the window
-- 			height		window height (excluding winbar)
-- 			loclist		1 if showing a location list
-- 			quickfix	1 if quickfix or location list window
-- 			terminal	1 if a terminal window
-- 			tabnr		tab page number
-- 			topline		first displayed buffer line
-- 			variables	a reference to the dictionary with
-- 					window-local variables
-- 			width		window width
-- 			winbar		1 if the window has a toolbar, 0
-- 					otherwise
-- 			wincol		leftmost screen column of the window
-- 			winid		|window-ID|
-- 			winnr		window number
-- 			winrow		topmost screen column of the window
--- @return list
function vim.fn.getwininfo(winid) end

-- The result is a list with two numbers, the result of
-- 		getwinposx() and getwinposy() combined:
-- 			[x-pos, y-pos]
-- 		{timeout} can be used to specify how long to wait in msec for
-- 		a response from the terminal.  When omitted 100 msec is used.
--- @return list
function vim.fn.getwinpos(timeout) end

-- the left hand side of the GUI Vim window.  The result will be
-- 		-1 if the information is not available.
-- 		The value can be used with `:winpos`.
--- @return number
function vim.fn.getwinposx() end

-- the top of the GUI Vim window.  The result will be -1 if the
-- 		information is not available.
-- 		The value can be used with `:winpos`.
--- @return number
function vim.fn.getwinposy() end

-- Like |gettabwinvar()| for the current tabpage.
-- 		Examples: >
-- 			:let list_is_on = getwinvar(2, '&list')
-- 			:echo "myvar = " . getwinvar(1, 'myvar')
function vim.fn.getwinvar(nr, varname, def) end

-- Expand the file wildcards in {expr}.  See |wildcards| for the
-- 		use of special characters.
--
-- 		Unless the optional {nosuf} argument is given and is |TRUE|,
-- 		the 'suffixes' and 'wildignore' options apply: Names matching
-- 		one of the patterns in 'wildignore' will be skipped and
-- 		'suffixes' affect the ordering of matches.
-- 		'wildignorecase' always applies.
--
-- 		When {list} is present and it is |TRUE| the result is a List
-- 		with all matching files. The advantage of using a List is,
-- 		you also get filenames containing newlines correctly.
-- 		Otherwise the result is a String and when there are several
-- 		matches, they are separated by <NL> characters.
--
-- 		If the expansion fails, the result is an empty String or List.
--
-- 		You can also use |readdir()| if you need to do complicated
-- 		things, such as limiting the number of matches.
--
-- 		A name for a non-existing file is not included.  A symbolic
-- 		link is only included if it points to an existing file.
-- 		However, when the {alllinks} argument is present and it is
-- 		|TRUE| then all symbolic links are included.
--
-- 		For most systems backticks can be used to get files names from
-- 		any external command.  Example: >
-- 			:let tagfiles = glob("`find . -name tags -print`")
-- 			:let &tags = substitute(tagfiles, "\n", ",", "g")
-- <		The result of the program inside the backticks should be one
-- 		item per line.  Spaces inside an item are allowed.
--
-- 		See |expand()| for expanding special Vim variables.  See
-- 		|system()| for getting the raw output of an external command.
--- @param list any[]
function vim.fn.glob(expr, nosuf, list, alllinks) end

-- Escape {string} for use as file name command argument.  All
-- 		characters that have a special meaning, such as '%' and '|'
-- 		are escaped with a backslash.
-- 		For most systems the characters escaped are
-- 		" \t\n*?[{`$\\%#'\"|!<".  For systems where a backslash
-- 		appears in a filename, it depends on the value of 'isfname'.
-- 		A leading '+' and '>' is also escaped (special after |:edit|
-- 		and |:write|).  And a "-" by itself (special after |:cd|).
-- 		Example: >
-- 			:let fname = '+some str%nge|name'
-- 			:exe "edit " . fnameescape(fname)
-- <		results in executing: >
-- 			edit \+some\ str\%nge\|name
--- @return string
function vim.fn.fnameescape(fname) end

-- Convert a file pattern, as used by glob(), into a search
-- 		pattern.  The result can be used to match with a string that
-- 		is a file name.  E.g. >
-- 			if filename =~ glob2regpat('Make*.mak')
-- <		This is equivalent to: >
-- 			if filename =~ '^Make.*\.mak$'
-- <		When {expr} is an empty string the result is "^$", match an
-- 		empty string.
-- 		Note that the result depends on the system.  On MS-Windows
-- 		a backslash usually means a path separator.
--- @return string
function vim.fn.glob2regpat(expr) end

-- Perform glob() on all directories in {path} and concatenate
-- 		the results.  Example: >
-- 			:echo globpath(&rtp, "syntax/c.vim")
-- <
-- 		{path} is a comma-separated list of directory names.  Each
-- 		directory name is prepended to {expr} and expanded like with
-- 		|glob()|.  A path separator is inserted when needed.
-- 		To add a comma inside a directory name escape it with a
-- 		backslash.  Note that on MS-Windows a directory may have a
-- 		trailing backslash, remove it if you put a comma after it.
-- 		If the expansion fails for one of the directories, there is no
-- 		error message.
--
-- 		Unless the optional {nosuf} argument is given and is |TRUE|,
-- 		the 'suffixes' and 'wildignore' options apply: Names matching
-- 		one of the patterns in 'wildignore' will be skipped and
-- 		'suffixes' affect the ordering of matches.
--
-- 		When {list} is present and it is |TRUE| the result is a List
-- 		with all matching files. The advantage of using a List is, you
-- 		also get filenames containing newlines correctly. Otherwise
-- 		the result is a String and when there are several matches,
-- 		they are separated by <NL> characters.  Example: >
-- 			:echo globpath(&rtp, "syntax/c.vim", 0, 1)
-- <
-- 		{allinks} is used as with |glob()|.
--
-- 		The "**" item can be used to search in a directory tree.
-- 		For example, to find all "README.txt" files in the directories
-- 		in 'runtimepath' and below: >
-- 			:echo globpath(&rtp, "**/README.txt")
-- <		Upwards search and limiting the depth of "**" is not
-- 		supported, thus using 'path' will not always work properly.
--- @param list any[]
--- @return string
function vim.fn.globpath(path, expr, nosuf, list, alllinks) end

-- {feature} argument is a feature name like "nvim-0.2.1" or
-- 		"win32", see below.  See also |exists()|.
--
-- 		Vim's compile-time feature-names (prefixed with "+") are not
-- 		recognized because Nvim is always compiled with all possible
-- 		features. |feature-compile|
--
-- 		Feature names can be:
-- 		1.  Nvim version. For example the "nvim-0.2.1" feature means
-- 		    that Nvim is version 0.2.1 or later: >
-- 			:if has("nvim-0.2.1")
--
-- <		2.  Runtime condition or other pseudo-feature. For example the
-- 		    "win32" feature checks if the current system is Windows: >
-- 			:if has("win32")
-- <							*feature-list*
-- 		    List of supported pseudo-feature names:
-- 		        acl		|ACL| support
-- 			bsd		BSD system (not macOS, use "mac" for that).
-- 		        iconv		Can use |iconv()| for conversion.
-- 		        +shellslash	Can use backslashes in filenames (Windows)
-- 			clipboard	|clipboard| provider is available.
-- 			mac		MacOS system.
-- 			nvim		This is Nvim.
-- 			python2		Legacy Vim |python2| interface. |has-python|
-- 			python3		Legacy Vim |python3| interface. |has-python|
-- 			pythonx		Legacy Vim |python_x| interface. |has-pythonx|
-- 			ttyin		input is a terminal (tty)
-- 			ttyout		output is a terminal (tty)
-- 			unix		Unix system.
-- 			*vim_starting*	True during |startup|.
-- 			win32		Windows system (32 or 64 bit).
-- 			win64		Windows system (64 bit).
-- 			wsl		WSL (Windows Subsystem for Linux) system
--
-- 							*has-patch*
-- 		3.  Vim patch. For example the "patch123" feature means that
-- 		    Vim patch 123 at the current |v:version| was included: >
-- 			:if v:version > 602 || v:version == 602 && has("patch148")
--
-- <		4.  Vim version. For example the "patch-7.4.237" feature means
-- 		    that Nvim is Vim-compatible to version 7.4.237 or later. >
-- 			:if has("patch-7.4.237")
--- @return number
function vim.fn.has(feature) end

-- The result is a Number, which is 1 if |Dictionary| {dict} has
-- 		an entry with key {key}.  Zero otherwise.
--- @param dict dictionary
--- @return number
function vim.fn.has_key(dict, key) end

-- Return the name of the undo file that would be used for a file
-- 		with name {name} when writing.  This uses the 'undodir'
-- 		option, finding directories that exist.  It does not check if
-- 		the undo file exists.
-- 		{name} is always expanded to the full path, since that is what
-- 		is used internally.
-- 		If {name} is empty undofile() returns an empty string, since a
-- 		buffer without a file name will not write an undo file.
-- 		Useful in combination with |:wundo| and |:rundo|.
-- 		When compiled without the |+persistent_undo| option this always
-- 		returns an empty string.
--- @return string
function vim.fn.undofile(name) end

-- The result is a Number, which is 1 if there is a mapping that
-- 		contains {what} in somewhere in the rhs (what it is mapped to)
-- 		and this mapping exists in one of the modes indicated by
-- 		{mode}.
-- 		When {abbr} is there and it is |TRUE| use abbreviations
-- 		instead of mappings.  Don't forget to specify Insert and/or
-- 		Command-line mode.
-- 		Both the global mappings and the mappings local to the current
-- 		buffer are checked for a match.
-- 		If no matching mapping is found 0 is returned.
-- 		The following characters are recognized in {mode}:
-- 			n	Normal mode
-- 			v	Visual mode
-- 			o	Operator-pending mode
-- 			i	Insert mode
-- 			l	Language-Argument ("r", "f", "t", etc.)
-- 			c	Command-line mode
-- 		When {mode} is omitted, "nvo" is used.
--
-- 		This function is useful to check if a mapping already exists
-- 		to a function in a Vim script.  Example: >
-- 			:if !hasmapto('\ABCdoit')
-- 			:   map <Leader>d \ABCdoit
-- 			:endif
-- <		This installs the mapping to "\ABCdoit" only if there isn't
-- 		already a mapping to "\ABCdoit".
--- @return number
function vim.fn.hasmapto(what, mode, abbr) end

-- Add the String {item} to the history {history} which can be
-- 		one of:					*hist-names*
-- 			"cmd"	 or ":"	  command line history
-- 			"search" or "/"   search pattern history
-- 			"expr"	 or "="   typed expression history
-- 			"input"  or "@"	  input line history
-- 			"debug"  or ">"   debug command history
-- 			empty		  the current or last used history
-- 		The {history} string does not need to be the whole name, one
-- 		character is sufficient.
-- 		If {item} does already exist in the history, it will be
-- 		shifted to become the newest entry.
-- 		The result is a Number: 1 if the operation was successful,
-- 		otherwise 0 is returned.
--
-- 		Example: >
-- 			:call histadd("input", strftime("%Y %b %d"))
-- 			:let date=input("Enter date: ")
-- <		This function is not available in the |sandbox|.
--- @return string
function vim.fn.histadd(history, item) end

-- Clear {history}, i.e. delete all its entries.  See |hist-names|
-- 		for the possible values of {history}.
--
-- 		If the parameter {item} evaluates to a String, it is used as a
-- 		regular expression.  All entries matching that expression will
-- 		be removed from the history (if there are any).
-- 		Upper/lowercase must match, unless "\c" is used |/\c|.
-- 		If {item} evaluates to a Number, it will be interpreted as
-- 		an index, see |:history-indexing|.  The respective entry will
-- 		be removed if it exists.
--
-- 		The result is a Number: 1 for a successful operation,
-- 		otherwise 0 is returned.
--
-- 		Examples:
-- 		Clear expression register history: >
-- 			:call histdel("expr")
-- <
-- 		Remove all entries starting with "*" from the search history: >
-- 			:call histdel("/", '^\*')
-- <
-- 		The following three are equivalent: >
-- 			:call histdel("search", histnr("search"))
-- 			:call histdel("search", -1)
-- 			:call histdel("search", '^'.histget("search", -1).'$')
-- <
-- 		To delete the last search pattern and use the last-but-one for
-- 		the "n" command and 'hlsearch': >
-- 			:call histdel("search", -1)
-- 			:let @/ = histget("search", -1)
--- @return string
function vim.fn.histdel(history, item) end

-- The result is a String, the entry with Number {index} from
-- 		{history}.  See |hist-names| for the possible values of
-- 		{history}, and |:history-indexing| for {index}.  If there is
-- 		no such entry, an empty String is returned.  When {index} is
-- 		omitted, the most recent item from the history is used.
--
-- 		Examples:
-- 		Redo the second last search from history. >
-- 			:execute '/' . histget("search", -2)
--
-- <		Define an Ex command ":H {num}" that supports re-execution of
-- 		the {num}th entry from the output of |:history|. >
-- 			:command -nargs=1 H execute histget("cmd", 0+<args>)
--- @return string
function vim.fn.histget(history, index) end

-- The result is the Number of the current entry in {history}.
-- 		See |hist-names| for the possible values of {history}.
-- 		If an error occurred, -1 is returned.
--
-- 		Example: >
-- 			:let inp_index = histnr("expr")
--- @return number
function vim.fn.histnr(history) end

-- The result is a Number, which is non-zero if a highlight group
-- 		called {name} exists.  This is when the group has been
-- 		defined in some way.  Not necessarily when highlighting has
-- 		been defined for it, it may also have been used for a syntax
-- 		item.
--- @return number
function vim.fn.hlexists(name) end

-- with name {name}.  When the highlight group doesn't exist,
-- 		zero is returned.
-- 		This can be used to retrieve information about the highlight
-- 		group.  For example, to get the background color of the
-- 		"Comment" group: >
-- 	:echo synIDattr(synIDtrans(hlID("Comment")), "bg")
--- @return number
function vim.fn.hlID(name) end

-- The result is a String, which is the name of the machine on
-- 		which Vim is currently running.  Machine names greater than
-- 		256 characters long are truncated.
--- @return string
function vim.fn.hostname() end

-- current buffer.  The indent is counted in spaces, the value
-- 		of 'tabstop' is relevant.  {lnum} is used just like in
-- 		|getline()|.
-- 		When {lnum} is invalid -1 is returned.
--- @return number
function vim.fn.indent(lnum) end

-- Return the lowest index in |List| {list} where the item has a
-- 		value equal to {expr}.  There is no automatic conversion, so
-- 		the String "4" is different from the Number 4.  And the number
-- 		4 is different from the Float 4.0.  The value of 'ignorecase'
-- 		is not used here, case always matters.
-- 		If {start} is given then start looking at the item with index
-- 		{start} (may be negative for an item relative to the end).
-- 		When {ic} is given and it is |TRUE|, ignore case.  Otherwise
-- 		case must match.
-- 		-1 is returned when {expr} is not found in {list}.
-- 		Example: >
-- 			:let idx = index(words, "the")
-- 			:if index(numbers, 123) >= 0
--- @param list any[]
--- @return number
function vim.fn.index(list, expr, start, ic) end

-- {textlist} must be a |List| of strings.  This |List| is
-- 		displayed, one string per line.  The user will be prompted to
-- 		enter a number, which is returned.
-- 		The user can also select an item by clicking on it with the
-- 		mouse.  For the first string 0 is returned.  When clicking
-- 		above the first item a negative number is returned.  When
-- 		clicking on the prompt one more than the length of {textlist}
-- 		is returned.
-- 		Make sure {textlist} has less than 'lines' entries, otherwise
-- 		it won't work.  It's a good idea to put the entry number at
-- 		the start of the string.  And put a prompt in the first item.
-- 		Example: >
-- 			let color = inputlist(['Select color:', '1. red',
-- 				\ '2. green', '3. blue'])
--- @return number
function vim.fn.inputlist(textlist) end

-- Restore typeahead that was saved with a previous |inputsave()|.
-- 		Should be called the same number of times inputsave() is
-- 		called.  Calling it more often is harmless though.
-- 		Returns 1 when there is nothing to restore, 0 otherwise.
--- @return number
function vim.fn.inputrestore() end

-- Preserve typeahead (also from mappings) and clear it, so that
-- 		a following prompt gets input from the user.  Should be
-- 		followed by a matching inputrestore() after the prompt.  Can
-- 		be used several times, in which case there must be just as
-- 		many inputrestore() calls.
-- 		Returns 1 when out of memory, 0 otherwise.
--- @return number
function vim.fn.inputsave() end

-- This function acts much like the |input()| function with but
-- 		two exceptions:
-- 		a) the user's response will be displayed as a sequence of
-- 		asterisks ("*") thereby keeping the entry secret, and
-- 		b) the user's response will not be recorded on the input
-- 		|history| stack.
-- 		The result is a String, which is whatever the user actually
-- 		typed on the command-line in response to the issued prompt.
-- 		NOTE: Command-line completion is not supported.
--- @return string
function vim.fn.inputsecret(prompt, text) end

-- Bitwise invert.  The argument is converted to a number.  A
-- 		List, Dict or Float argument causes an error.  Example: >
-- 			:let bits = invert(bits)
--- @return number
function vim.fn.invert(expr) end

-- Get item {idx} from |List| {list}.  When this item is not
-- 		available return {default}.  Return zero when {default} is
-- 		Get item with key {key} from |Dictionary| {dict}.  When this
-- 		item is not available return {default}.  Return zero when
-- 		{default} is omitted.  Useful example: >
-- 			let val = get(g:, 'var_name', 'default')
-- <		This gets the value of g:var_name if it exists, and uses
-- 		Get item {what} from Funcref {func}.  Possible values for
-- 		{what} are:
-- 			"name"	The function name
-- 			"func"	The function
-- 			"dict"	The dictionary
-- 			"args"	The list with arguments
function vim.fn.get(func, what) end

-- Get the value of an internal variable.  These values for
-- 		{name} are supported:
-- 			need_fileinfo
--
-- 		Can also be used as a |method|: >
-- 			GetName()->test_getvalue()
function vim.fn.test_getvalue(string) end

-- Ignore any error containing {expr}.  A normal message is given
-- 		instead.
-- 		This is only meant to be used in tests, where catching the
-- 		error with try/catch cannot be used (because it skips over
-- 		following code).
-- 		{expr} is used literally, not as a pattern.
-- 		When the {expr} is the string "RESET" then the list of ignored
-- 		errors is made empty.
--
-- 		Can also be used as a |method|: >
-- 			GetErrorText()->test_ignore_error()
--- @return none
function vim.fn.test_ignore_error(expr) end

-- Return a |Blob| that is null. Only useful for testing.
--- @return blob
function vim.fn.test_null_blob() end

-- Return a |Channel| that is null. Only useful for testing.
-- 		{only available when compiled with the +channel feature}
--- @return channel
function vim.fn.test_null_channel() end

-- Return a |Dict| that is null. Only useful for testing.
--- @return dict
function vim.fn.test_null_dict() end

-- Return a |Job| that is null. Only useful for testing.
-- 		{only available when compiled with the +job feature}
--- @return job
function vim.fn.test_null_job() end

-- Return a |List| that is null. Only useful for testing.
--- @return list
function vim.fn.test_null_list() end

-- Return a |Partial| that is null. Only useful for testing.
--- @return funcref
function vim.fn.test_null_partial() end

-- Return a |String| that is null. Only useful for testing.
--- @return string
function vim.fn.test_null_string() end

-- Reset the flag that indicates option {name} was set.  Thus it
-- 		looks like it still has the default value. Use like this: >
-- 			set ambiwidth=double
-- 			call test_option_not_set('ambiwidth')
-- <		Now the 'ambiwidth' option behaves like it was never changed,
-- 		even though the value is "double".
-- 		Only to be used for testing!
--
-- 		Can also be used as a |method|: >
-- 			GetOptionName()->test_option_not_set()
--- @return none
function vim.fn.test_option_not_set(name) end

-- Overrides certain parts of Vim's internal processing to be able
-- 		to run tests. Only to be used for testing Vim!
-- 		The override is enabled when {val} is non-zero and removed
-- 		when {val} is zero.
-- 		Current supported values for name are:
--
-- 		name	     effect when {val} is non-zero ~
-- 		redraw       disable the redrawing() function
-- 		redraw_flag  ignore the RedrawingDisabled flag
-- 		char_avail   disable the char_avail() function
-- 		starting     reset the "starting" variable, see below
-- 		nfa_fail     makes the NFA regexp engine fail to force a
-- 			     fallback to the old engine
-- 		no_query_mouse  do not query the mouse position for "dec"
-- 				terminals
-- 		no_wait_return	set the "no_wait_return" flag.  Not restored
-- 				with "ALL".
-- 		ALL	     clear all overrides ({val} is not used)
--
-- 		"starting" is to be used when a test should behave like
-- 		startup was done.  Since the tests are run by sourcing a
-- 		script the "starting" variable is non-zero. This is usually a
-- 		good thing (tests run faster), but sometimes changes behavior
-- 		in a way that the test doesn't work properly.
-- 		When using: >
-- 			call test_override('starting', 1)
-- <		The value of "starting" is saved.  It is restored by: >
-- 			call test_override('starting', 0)
--
-- <		Can also be used as a |method|: >
-- 			GetOverrideVal()-> test_override('starting')
--- @return none
function vim.fn.test_override(expr, val) end

-- Return the reference count of {expr}.  When {expr} is of a
-- 		type that does not have a reference count, returns -1.  Only
-- 		to be used for testing.
--
-- 		Can also be used as a |method|: >
-- 			GetVarname()->test_refcount()
--- @return number
function vim.fn.test_refcount(expr) end

-- Put up a directory requester.  This only works when
-- 		"has("browse")" returns |TRUE| (only in some GUI versions).
-- 		On systems where a directory browser is not supported a file
-- 		browser is used.  In that case: select a file in the directory
-- 		to be used.
-- 		The input fields are:
-- 		    {title}	title for the requester
-- 		    {initdir}	directory to start browsing in
-- 		When the "Cancel" button is hit, something went wrong, or
-- 		browsing is not possible, an empty string is returned.
--- @return string
function vim.fn.browsedir(title, initdir) end

-- Pretend using scrollbar {which} to move it to position
-- 		{value}.  {which} can be:
-- 			left	Left scrollbar of the current window
-- 			right	Right scrollbar of the current window
-- 			hor	Horizontal scrollbar
--
-- 		For the vertical scrollbars {value} can be 1 to the
-- 		line-count of the buffer.  For the horizontal scrollbar the
-- 		{value} can be between 1 and the maximum line length, assuming
-- 		'wrap' is not set.
--
-- 		When {dragging} is non-zero it's like dragging the scrollbar,
-- 		otherwise it's like clicking in the scrollbar.
-- 		Only works when the {which} scrollbar actually exists,
-- 		obviously only when using the GUI.
--
-- 		Can also be used as a |method|: >
-- 			GetValue()->test_scrollbar('right', 0)
--- @return none
function vim.fn.test_scrollbar(which, value, dragging) end

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists and is listed (has the 'buflisted' option set).
-- 		The {expr} argument is used like with |bufexists()|.
--- @return number
function vim.fn.buflisted(expr) end

-- Set the mouse position to be used for the next mouse action.
-- 		{row} and {col} are one based.
-- 		For example: >
-- 			call test_setmouse(4, 20)
-- 			call feedkeys("\<LeftMouse>", "xt")
--- @return none
function vim.fn.test_setmouse(row, col) end

-- Set the time Vim uses internally.  Currently only used for
-- 		timestamps in the history, as they are used in viminfo, and
-- 		for undo.
-- 		Using a value of 1 makes Vim not sleep after a warning or
-- 		error message.
-- 		{expr} must evaluate to a number.  When the value is zero the
-- 		normal behavior is restored.
--
-- 		Can also be used as a |method|: >
-- 			GetTime()->test_settime()
--- @return none
function vim.fn.test_settime(expr) end

-- Like `execute()` but in the context of window {id}.
-- 		The window will temporarily be made the current window,
-- 		without triggering autocommands.  When executing {command}
-- 		autocommands will be triggered, this may have unexpected side
-- 		effects.  Use |:noautocmd| if needed.
-- 		Example: >
-- 			call win_execute(winid, 'set syntax=python')
-- <		Doing the same with `setwinvar()` would not trigger
-- 		autocommands and not actually show syntax highlighting.
-- 							*E994*
-- 		Not all commands are allowed in popup windows.
-- 		When window {id} does not exist then no error is given.
--
-- 		Can also be used as a |method|, the base is passed as the
-- 		second argument: >
-- 			GetCommand()->win_execute(winid)
--- @return string
function vim.fn.win_execute(id, command, silent) end

-- Get the amount of indent for line {lnum} according the C
-- 		indenting rules, as with 'cindent'.
-- 		The indent is counted in spaces, the value of 'tabstop' is
-- 		relevant.  {lnum} is used just like in |getline()|.
-- 		When {lnum} is invalid -1 is returned.
-- 		See |C-indenting|.
--- @return number
function vim.fn.cindent(lnum) end

-- Return a list with file and directory names in {directory}.
-- 		You can also use |glob()| if you don't need to do complicated
-- 		things, such as limiting the number of matches.
--
-- 		When {expr} is omitted all entries are included.
-- 		When {expr} is given, it is evaluated to check what to do:
-- 			If {expr} results in -1 then no further entries will
-- 			be handled.
--- @return list
function vim.fn.readdir(dir, expr) end

-- Join the items in {list} together into one String.
-- 		When {sep} is specified it is put in between the items.  If
-- 		{sep} is omitted a single space is used.
-- 		Note that {sep} is not added at the end.  You might want to
-- 		add it there too: >
-- 			let lines = join(mylist, "\n") . "\n"
-- <		String items are used as-is.  |Lists| and |Dictionaries| are
-- 		converted into a string like with |string()|.
-- 		The opposite function is |split()|.
--- @param list any[]
--- @return string
function vim.fn.join(list, sep) end

-- Returns Dictionary of |api-metadata|.
--
-- 		View it in a nice human-readable format: >
-- 		       :lua print(vim.inspect(vim.fn.api_info()))
--- @return dict
function vim.fn.api_info() end

-- The result is the number of files in the argument list.  See
-- 		|arglist|.
-- 		If {winid} is not supplied, the argument list of the current
-- 		window is used.
-- 		If {winid} is -1, the global argument list is used.
-- 		Otherwise {winid} specifies the window of which the argument
-- 		list is used: either the window number or the window ID.
-- 		Returns -1 if the {winid} argument is invalid.
--- @return number
function vim.fn.argc(winid) end

-- the first file.  argc() - 1 is the last one.  See |arglist|.
--- @return number
function vim.fn.argidx() end

-- Return the argument list ID.  This is a number which
-- 		identifies the argument list being used.  Zero is used for the
-- 		global argument list.  See |arglist|.
-- 		Returns -1 if the arguments are invalid.
--
-- 		Without arguments use the current window.
-- 		With {winnr} only use this window in the current tab page.
-- 		With {winnr} and {tabnr} use the window in the specified tab
-- 		page.
-- 		{winnr} can be the window number or the |window-ID|.
--- @return number
function vim.fn.arglistid(winnr, tabnr) end

-- Run {cmd} and add an error message to |v:errors| if it does
-- 		NOT produce a beep or visual bell.
-- 		Also see |assert_fails()| and |assert-return|.
--- @return number
function vim.fn.assert_beeps(cmd) end

-- When {expected} and {actual} are not equal an error message is
-- 		added to |v:errors| and 1 is returned.  Otherwise zero is
-- 		returned |assert-return|.
-- 		There is no automatic conversion, the String "4" is different
-- 		from the Number 4.  And the number 4 is different from the
-- 		Float 4.0.  The value of 'ignorecase' is not used here, case
-- 		always matters.
-- 		When {msg} is omitted an error in the form "Expected
-- 		{expected} but got {actual}" is produced.
-- 		Example: >
-- 	assert_equal('foo', 'bar')
-- <		Will result in a string to be added to |v:errors|:
-- 	test.vim line 12: Expected 'foo' but got 'bar' ~
--- @return number
function vim.fn.assert_equal(exp, act, msg) end

-- When the files {fname-one} and {fname-two} do not contain
-- 		exactly the same text an error message is added to |v:errors|.
-- 		Also see |assert-return|.
-- 		When {fname-one} or {fname-two} does not exist the error will
-- 		mention that.
--- @return number
function vim.fn.assert_equalfile(fname_one, fname_two) end

-- When v:exception does not contain the string {error} an error
-- 		message is added to |v:errors|.  Also see |assert-return|.
-- 		This can be used to assert that a command throws an exception.
-- 		Using the error number, followed by a colon, avoids problems
-- 		with translations: >
-- 			try
-- 			  commandthatfails
-- 			  call assert_false(1, 'command should have failed')
-- 			catch
-- 			  call assert_exception('E492:')
-- 			endtry
--- @return number
function vim.fn.assert_exception(error, msg) end

-- Run {cmd} and add an error message to |v:errors| if it does
-- 		NOT produce an error.  Also see |assert-return|.
-- 		When {error} is given it must match in |v:errmsg|.
-- 		Note that beeping is not considered an error, and some failing
-- 		commands only beep.  Use |assert_beeps()| for those.
--- @return number
function vim.fn.assert_fails(cmd, error) end

-- When {actual} is not false an error message is added to
-- 		|v:errors|, like with |assert_equal()|.
-- 		Also see |assert-return|.
-- 		A value is false when it is zero or |v:false|. When "{actual}"
-- 		is not a number or |v:false| the assert fails.
-- 		When {msg} is omitted an error in the form
-- 		"Expected False but got {actual}" is produced.
--- @return number
function vim.fn.assert_false(actual, msg) end

-- This asserts number and |Float| values.  When {actual}  is lower
-- 		than {lower} or higher than {upper} an error message is added
-- 		to |v:errors|.  Also see |assert-return|.
-- 		When {msg} is omitted an error in the form
-- 		"Expected range {lower} - {upper}, but got {actual}" is
-- 		produced.
--- @return number
function vim.fn.assert_inrange(lower, upper, actual, msg) end

-- When {pattern} does not match {actual} an error message is
-- 		added to |v:errors|.  Also see |assert-return|.
--
-- 		{pattern} is used as with |=~|: The matching is always done
-- 		like 'magic' was set and 'cpoptions' is empty, no matter what
-- 		the actual value of 'magic' or 'cpoptions' is.
--
-- 		{actual} is used as a string, automatic conversion applies.
-- 		Use "^" and "$" to match with the start and end of the text.
-- 		Use both to match the whole text.
--
-- 		When {msg} is omitted an error in the form
-- 		"Pattern {pattern} does not match {actual}" is produced.
-- 		Example: >
-- 	assert_match('^f.*o$', 'foobar')
-- <		Will result in a string to be added to |v:errors|:
-- 	test.vim line 12: Pattern '^f.*o$' does not match 'foobar' ~
--- @return number
function vim.fn.assert_match(pat, text, msg) end

-- The opposite of `assert_equal()`: add an error message to
-- 		|v:errors| when {expected} and {actual} are equal.
-- 		Also see |assert-return|.
--- @return number
function vim.fn.assert_notequal(exp, act, msg) end

-- The opposite of `assert_match()`: add an error message to
-- 		|v:errors| when {pattern} matches {actual}.
-- 		Also see |assert-return|.
--- @return number
function vim.fn.assert_notmatch(pat, text, msg) end

-- Report a test failure directly, using {msg}.
-- 		Always returns one.
--- @return number
function vim.fn.assert_report(msg) end

-- When {actual} is not true an error message is added to
-- 		|v:errors|, like with |assert_equal()|.
-- 		Also see |assert-return|.
-- 		A value is |TRUE| when it is a non-zero number or |v:true|.
-- 		When {actual} is not a number or |v:true| the assert fails.
-- 		When {msg} is omitted an error in the form "Expected True but
-- 		got {actual}" is produced.
--- @return number
function vim.fn.assert_true(actual, msg) end

-- Add a buffer to the buffer list with {name}.
-- 		If a buffer for file {name} already exists, return that buffer
-- 		number.  Otherwise return the buffer number of the newly
-- 		created buffer.  When {name} is an empty string then a new
-- 		buffer is always created.
-- 		The buffer will not have' 'buflisted' set.
--- @return number
function vim.fn.bufadd(name) end

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists.
-- 		If the {expr} argument is a number, buffer numbers are used.
-- 		Number zero is the alternate buffer for the current window.
--
-- 		If the {expr} argument is a string it must match a buffer name
-- 		exactly.  The name can be:
-- 		- Relative to the current directory.
-- 		- A full path.
-- 		- The name of a buffer with 'buftype' set to "nofile".
-- 		- A URL name.
-- 		Unlisted buffers will be found.
-- 		Note that help files are listed by their short name in the
-- 		output of |:buffers|, but bufexists() requires using their
-- 		long name to be able to find them.
-- 		bufexists() may report a buffer exists, but to use the name
-- 		with a |:buffer| command you may need to use |expand()|.  Esp
-- 		for MS-Windows 8.3 names in the form "c:\DOCUME~1"
-- 		Use "bufexists(0)" to test for the existence of an alternate
-- 		file name.
--- @return number
function vim.fn.bufexists(expr) end

-- The result is a Number, which is |TRUE| if a buffer called
-- 		{expr} exists and is loaded (shown in a window or hidden).
-- 		The {expr} argument is used like with |bufexists()|.
--- @return number
function vim.fn.bufloaded(expr) end

-- The result is the name of a buffer, as it is displayed by the
-- 		":ls" command.
-- +		If {expr} is omitted the current buffer is used.
-- 		If {expr} is a Number, that buffer number's name is given.
-- 		Number zero is the alternate buffer for the current window.
-- 		If {expr} is a String, it is used as a |file-pattern| to match
-- 		with the buffer names.  This is always done like 'magic' is
-- 		set and 'cpoptions' is empty.  When there is more than one
-- 		match an empty string is returned.
-- 		"" or "%" can be used for the current buffer, "#" for the
-- 		alternate buffer.
-- 		A full match is preferred, otherwise a match at the start, end
-- 		or middle of the buffer name is accepted.  If you only want a
-- 		full match then put "^" at the start and "$" at the end of the
-- 		pattern.
-- 		Listed buffers are found first.  If there is a single match
-- 		with a listed buffer, that one is returned.  Next unlisted
-- 		buffers are searched for.
-- 		If the {expr} is a String, but you want to use it as a buffer
-- 		number, force it to be a Number by adding zero to it: >
-- 			:echo bufname("3" + 0)
-- <		If the buffer doesn't exist, or doesn't have a name, an empty
-- 		string is returned. >
-- 	bufname("#")		alternate buffer name
-- 	bufname(3)		name of buffer 3
-- 	bufname("%")		name of current buffer
-- 	bufname("file2")	name of buffer where "file2" matches.
--- @return string
function vim.fn.bufname(expr) end

-- The result is the number of a buffer, as it is displayed by
-- 		the ":ls" command.  For the use of {expr}, see |bufname()|
-- 		above.
-- 		If the buffer doesn't exist, -1 is returned.  Or, if the
-- 		{create} argument is present and not zero, a new, unlisted,
-- 		buffer is created and its number is returned.
-- 		bufnr("$") is the last buffer: >
-- 			:let last_buffer = bufnr("$")
-- <		The result is a Number, which is the highest buffer number
-- 		of existing buffers.  Note that not all buffers with a smaller
-- 		number necessarily exist, because ":bwipeout" may have removed
-- 		them.  Use bufexists() to test for the existence of a buffer.
--- @return number
function vim.fn.bufnr(expr, create) end

-- The result is a Number, which is the |window-ID| of the first
-- 		window associated with buffer {expr}.  For the use of {expr},
-- 		see |bufname()| above.  If buffer {expr} doesn't exist or
-- 		there is no such window, -1 is returned.  Example: >
--
-- 	echo "A window containing buffer 1 is " . (bufwinid(1))
-- <
-- 		Only deals with the current tab page.
--- @return number
function vim.fn.bufwinid(expr) end

-- The result is a Number, which is the number of the first
-- 		window associated with buffer {expr}.  For the use of {expr},
-- 		see |bufname()| above.  If buffer {expr} doesn't exist or
-- 		there is no such window, -1 is returned.  Example: >
--
-- 	echo "A window containing buffer 1 is " . (bufwinnr(1))
--
-- <		The number can be used with |CTRL-W_w| and ":wincmd w"
-- 		|:wincmd|.
-- 		Only deals with the current tab page.
--- @return number
function vim.fn.bufwinnr(expr) end

-- Return the line number that contains the character at byte
-- 		count {byte} in the current buffer.  This includes the
-- 		end-of-line character, depending on the 'fileformat' option
-- 		for the current buffer.  The first character has byte count
-- 		one.
-- 		Also see |line2byte()|, |go| and |:goto|.
--- @return number
function vim.fn.byte2line(byte) end

-- Return byte index of the {nr}'th character in the string
-- 		{expr}.  Use zero for the first character, it returns zero.
-- 		This function is only useful when there are multibyte
-- 		characters, otherwise the returned value is equal to {nr}.
-- 		Composing characters are not counted separately, their byte
-- 		length is added to the preceding base character.  See
-- 		|byteidxcomp()| below for counting composing characters
-- 		separately.
-- 		Example : >
-- 			echo matchstr(str, ".", byteidx(str, 3))
-- <		will display the fourth character.  Another way to do the
-- 		same: >
-- 			let s = strpart(str, byteidx(str, 3))
-- 			echo strpart(s, 0, byteidx(s, 1))
-- <		Also see |strgetchar()| and |strcharpart()|.
--
-- 		If there are less than {nr} characters -1 is returned.
-- 		If there are exactly {nr} characters the length of the string
-- 		in bytes is returned.
--- @return number
function vim.fn.byteidx(expr, nr) end

-- Like byteidx(), except that a composing character is counted
-- 		as a separate character.  Example: >
-- 			let s = 'e' . nr2char(0x301)
-- 			echo byteidx(s, 1)
-- 			echo byteidxcomp(s, 1)
-- 			echo byteidxcomp(s, 2)
-- <		The first and third echo result in 3 ('e' plus composing
-- 		character is 3 bytes), the second echo results in 1 ('e' is
-- 		one byte).
--- @return number
function vim.fn.byteidxcomp(expr, nr) end

-- Return the number of the most recent change.  This is the same
-- 		number as what is displayed with |:undolist| and can be used
-- 		with the |:undo| command.
-- 		When a change was made it is the number of that change.  After
-- 		redo it is the number of the redone change.  After undo it is
-- 		one less than the number of the undone change.
--- @return number
function vim.fn.changenr() end

-- Close a channel or a specific stream associated with it.
-- 		For a job, {stream} can be one of "stdin", "stdout",
-- 		"stderr" or "rpc" (closes stdin/stdout for a job started
-- 		with `"rpc":v:true`) If {stream} is omitted, all streams
-- 		are closed. If the channel is a pty, this will then close the
-- 		pty master, sending SIGHUP to the job process.
-- 		For a socket, there is only one stream, and {stream} should be
-- 		ommited.
--- @return number
function vim.fn.chanclose(id, stream) end

-- Send data to channel {id}. For a job, it writes it to the
-- 		stdin of the process. For the stdio channel |channel-stdio|,
-- 		it writes to Nvim's stdout.  Returns the number of bytes
-- 		written if the write succeeded, 0 otherwise.
-- 		See |channel-bytes| for more information.
--
-- 		{data} may be a string, string convertible, or a list.  If
-- 		{data} is a list, the items will be joined by newlines; any
-- 		newlines in an item will be sent as NUL. To send a final
-- 		newline, include a final empty string. Example: >
-- 			:call chansend(id, ["abc", "123\n456", ""])
-- < 		will send "abc<NL>123<NUL>456<NL>".
--
-- 		chansend() writes raw data, not RPC messages.  If the channel
-- 		was created with `"rpc":v:true` then the channel expects RPC
-- 		messages, use |rpcnotify()| and |rpcrequest()| instead.
--- @return number
function vim.fn.chansend(id, data) end

-- Return number value of the first char in {expr}.  Examples: >
-- 			char2nr(" ")		returns 32
-- 			char2nr("ABC")		returns 65
-- 			char2nr("á")		returns 225
-- 			char2nr("á"[0])		returns 195
-- 			char2nr("\<M-x>")	returns 128
-- <		Non-ASCII characters are always treated as UTF-8 characters.
-- 		{utf8} is ignored, it exists only for backwards-compatibility.
-- 		A combining character is a separate character.
-- 		|nr2char()| does the opposite.
--- @return number
function vim.fn.char2nr(expr, utf8) end

-- Clears all matches previously defined for the current window
-- 		by |matchadd()| and the |:match| commands.
--- @return none
function vim.fn.clearmatches() end

-- position given with {expr}.  The accepted positions are:
-- 		    .	    the cursor position
-- 		    $	    the end of the cursor line (the result is the
-- 			    number of bytes in the cursor line plus one)
-- 		    'x	    position of mark x (if the mark is not set, 0 is
-- 			    returned)
-- 		    v       In Visual mode: the start of the Visual area (the
-- 			    cursor is the end).  When not in Visual mode
-- 			    returns the cursor position.  Differs from |'<| in
-- 			    that it's updated right away.
-- 		Additionally {expr} can be [lnum, col]: a |List| with the line
-- 		and column number. Most useful when the column is "$", to get
-- 		the last column of a specific line.  When "lnum" or "col" is
-- 		out of range then col() returns zero.
-- 		To get the line number use |line()|.  To get both use
-- 		|getpos()|.
-- 		For the screen column position use |virtcol()|.
-- 		Note that only marks in the current file can be used.
-- 		Examples: >
-- 			col(".")		column of cursor
-- 			col("$")		length of cursor line plus one
-- 			col("'t")		column of mark t
-- 			col("'" . markname)	column of mark markname
-- <		The first column is 1.  0 is returned for an error.
-- 		For an uppercase mark the column may actually be in another
-- 		buffer.
-- 		For the cursor position, when 'virtualedit' is active, the
-- 		column is one higher if the cursor is after the end of the
-- 		line.  This can be used to obtain the column in Insert mode: >
-- 			:imap <F2> <C-O>:let save_ve = &ve<CR>
-- 				\<C-O>:set ve=all<CR>
-- 				\<C-O>:echo col(".") . "\n" <Bar>
-- 				\let &ve = save_ve<CR>
-- <
--- @return number
function vim.fn.col(expr) end

-- different from using {expr} directly.
-- 		When {expr} is a |List| a shallow copy is created.  This means
-- 		that the original |List| can be changed without changing the
-- 		copy, and vice versa.  But the items are identical, thus
-- 		changing an item changes the contents of both |Lists|.
-- 		A |Dictionary| is copied in a similar way as a |List|.
-- 		Also see |deepcopy()|.
function vim.fn.copy(expr) end

-- Add {expr} to the list of matches.  Only to be used by the
-- 		function specified with the 'completefunc' option.
-- 		Returns 0 for failure (empty string or out of memory),
-- 		1 when the match was added, 2 when the match was already in
-- 		the list.
-- 		See |complete-functions| for an explanation of {expr}.  It is
-- 		the same as one item in the list that 'omnifunc' would return.
--- @return number
function vim.fn.complete_add(expr) end

-- Returns a |String| which is a unique identifier of the
-- 		container type (|List|, |Dict| and |Partial|). It is
-- 		guaranteed that for the mentioned types `id(v1) ==# id(v2)`
-- 		returns true iff `type(v1) == type(v2) && v1 is v2` (note:
-- 		|v:_null_list| and |v:_null_dict| have the same `id()` with
-- 		different types because they are internally represented as
-- 		a NULL pointers). Currently `id()` returns a hexadecimal
-- 		representanion of the pointers to the containers (i.e. like
-- 		`0x994a40`), same as `printf("%p", {expr})`, but it is advised
-- 		against counting on exact format of return value.
--
-- 		It is not guaranteed that `id(no_longer_existing_container)`
-- 		will not be equal to some other `id()`: new containers may
-- 		reuse identifiers of the garbage-collected ones.
--- @return string
function vim.fn.id(expr) end

-- Check for a key typed while looking for completion matches.
-- 		This is to be used when looking for matches takes some time.
-- 		Returns |TRUE| when searching for matches is to be aborted,
-- 		zero otherwise.
-- 		Only to be used by the function specified with the
-- 		'completefunc' option.
--- @return number
function vim.fn.complete_check() end

-- Returns a Dictionary with information about Insert mode
-- 		completion.  See |ins-completion|.
-- 		The items are:
-- 		   mode		Current completion mode name string.
-- 				See |complete_info_mode| for the values.
-- 		   pum_visible	|TRUE| if popup menu is visible.
-- 				See |pumvisible()|.
-- 		   items	List of completion matches.  Each item is a
-- 				dictionary containing the entries "word",
-- 				"abbr", "menu", "kind", "info" and "user_data".
-- 				See |complete-items|.
-- 		   selected	Selected item index.  First index is zero.
-- 				Index is -1 if no item is selected (showing
-- 				typed text only)
-- 		   inserted	Inserted string. [NOT IMPLEMENT YET]
--
-- 							*complete_info_mode*
-- 		mode values are:
-- 		   ""		     Not in completion mode
-- 		   "keyword"	     Keyword completion |i_CTRL-X_CTRL-N|
-- 		   "ctrl_x"	     Just pressed CTRL-X |i_CTRL-X|
-- 		   "whole_line"	     Whole lines |i_CTRL-X_CTRL-L|
-- 		   "files"	     File names |i_CTRL-X_CTRL-F|
-- 		   "tags"	     Tags |i_CTRL-X_CTRL-]|
-- 		   "path_defines"    Definition completion |i_CTRL-X_CTRL-D|
-- 		   "path_patterns"   Include completion |i_CTRL-X_CTRL-I|
-- 		   "dictionary"	     Dictionary |i_CTRL-X_CTRL-K|
-- 		   "thesaurus"	     Thesaurus |i_CTRL-X_CTRL-T|
-- 		   "cmdline"	     Vim Command line |i_CTRL-X_CTRL-V|
-- 		   "function"	     User defined completion |i_CTRL-X_CTRL-U|
-- 		   "omni"	     Omni completion |i_CTRL-X_CTRL-O|
-- 		   "spell"	     Spelling suggestions |i_CTRL-X_s|
-- 		   "eval"            |complete()| completion
-- 		   "unknown"	     Other internal modes
--
-- 		If the optional {what} list argument is supplied, then only
-- 		the items listed in {what} are returned.  Unsupported items in
-- 		{what} are silently ignored.
--
-- 		To get the position and size of the popup menu, see
-- 		|pum_getpos()|. It's also available in |v:event| during the
-- 		|CompleteChanged| event.
--
-- 		Examples: >
-- 			" Get all items
-- 			call complete_info()
-- 			" Get only 'mode'
-- 			call complete_info(['mode'])
-- 			" Get only 'mode' and 'pum_visible'
-- 			call complete_info(['mode', 'pum_visible'])
-- <
--- @return dict
function vim.fn.complete_info(what) end

