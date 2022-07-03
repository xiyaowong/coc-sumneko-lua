--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Highlight the yanked region
function vim.highlight.on_yank(opts) end

-- Highlight range between two positions
--- @param bufnr any #number of buffer to apply highlighting to
--- @param ns any #namespace to add highlight to
--- @param higroup any #highlight group to use for highlighting
--- @param start any #first position (tuple {line,col})
--- @param finish any #second position (tuple {line,col})
--- @param opts any #table with options:
function vim.highlight.range(bufnr, ns, higroup, start, finish, opts) end

