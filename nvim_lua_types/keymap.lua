--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Remove an existing mapping. Examples: >
--
--    vim.keymap.del('n', 'lhs')
-- <
--- @param opts any #table A table of optional arguments:
---             • buffer: (number or boolean) Remove a mapping
---               from the given buffer. When "true" or 0, use the
---               current buffer.
function vim.keymap.del(modes, lhs, opts) end

-- Add a new |mapping|. Examples: >
--
--    -- Can add mapping to Lua functions
--    vim.keymap.set('n', 'lhs', function() print("real lua function") end)
-- <
--- @param mode any #string|table Same mode short names as
---             |nvim_set_keymap()|. Can also be list of modes to
---             create mapping on multiple modes.
--- @param lhs any #string Left-hand side |{lhs}| of the mapping.
--- @param rhs any #string|function Right-hand side |{rhs}| of the
---             mapping. Can also be a Lua function.
--- @param opts any #table A table of |:map-arguments| such as
---             "silent". In addition to the options listed in
---             |nvim_set_keymap()|, this table also accepts the
---             following keys:
---             • replace_keycodes: (boolean, default true) When
---               both this and expr is "true",
---               |nvim_replace_termcodes()| is applied to the
---               result of Lua expr maps.
---             • remap: (boolean) Make the mapping recursive.
---               This is the inverse of the "noremap" option from
---               |nvim_set_keymap()|. Default `true` if `lhs` is
---               a string starting with `<plug>`
---               (case-insensitive), `false` otherwise.
function vim.keymap.set(mode, lhs, rhs, opts) end

