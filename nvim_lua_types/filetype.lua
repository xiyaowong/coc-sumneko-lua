--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Add new filetype mappings.
--- @param filetypes any #table A table containing new filetype maps
---                  (see example).
function vim.filetype.add(filetypes) end

-- Set the filetype for the given buffer from a file name.
--- @param name any #string File name (can be an absolute or relative
---              path)
--- @param bufnr any #number|nil The buffer to set the filetype for.
---              Defaults to the current buffer.
function vim.filetype.match(name, bufnr) end

