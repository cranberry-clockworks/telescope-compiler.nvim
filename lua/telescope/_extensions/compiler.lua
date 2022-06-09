local telescope = require('telescope')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local config = require('telescope.config').values
local actions = require('telescope.actions')
local state = require('telescope.actions.state')

local function compiler(opts)
    local compilers = vim.fn.getcompletion("", 'compiler')
    pickers.new(opts, {
        prompt_title = "Compilers",
        finder = finders.new_table({
            results = compilers
        }),
        sorter = config.generic_sorter(opts),
        attach_mappings = function(prompt_buffer)
            actions.select_default:replace(function ()
                local selection = state.get_selected_entry()
                if (selection == nil) then
                    print("[telescope] Nothing currently selected")
                    return
                end
                actions.close(prompt_buffer)
                vim.cmd(string.format('compiler %s', selection[1]))
            end)
            return true
        end,
    }):find()
end

return telescope.register_extension({
    exports = {
        compiler = compiler
    }
})
