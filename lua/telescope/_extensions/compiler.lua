local telescope = require('telescope')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local config = require('telescope.config').values
local actions = require('telescope.actions')
local state = require('telescope.actions.state')

local function set_compiler(buffer)
    local selection = state.get_selected_entry()
    if (selection == nil) then
        print("[telescope] Nothing currently selected")
        return
    end
    actions.close(buffer)
    vim.cmd(string.format('compiler %s', selection.value))
end

local function set_compiler_global(buffer)
    local selection = state.get_selected_entry()
    if (selection == nil) then
        print("[telescope] Nothing currently selected")
        return
    end
    actions.close(buffer)
    vim.cmd(string.format('compiler! %s', selection.value))
end

local function compiler(opts)
    local compilers = vim.fn.getcompletion("", 'compiler')
    pickers.new(opts, {
        prompt_title = "Compilers",
        finder = finders.new_table({
            results = compilers
        }),
        sorter = config.generic_sorter(opts),
        attach_mappings = function(_, map)
            actions.select_default:replace(set_compiler)
            map('i', '<c-w>', set_compiler_global)
            map('n', '<c-w>', set_compiler_global)
            return true
        end,
    }):find()
end

return telescope.register_extension({
    exports = {
        compiler = compiler
    }
})
