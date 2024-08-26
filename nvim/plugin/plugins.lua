if vim.g.did_load_plugins_plugin then
  return
end
vim.g.did_load_plugins_plugin = true

-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

---------- Theme ----------
require('ayu').colorscheme()


---------- Plugins ----------
require('todo-comments').setup()
require('which-key').add {
  { '<leader>st', group = 'Search TODOs' },
}
vim.keymap.set('n', '<leader>stt', '<cmd>TodoTelescope<CR>', { desc = 'Seatch TODOs Telescope' })
vim.keymap.set('n', '<leader>stl', '<cmd>TodoLocList<CR>', { desc = 'Seatch TODOs LocList' })


require('ts_context_commentstring').setup {
  enable_autocmd = false,
}
local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring"
    and require("ts_context_commentstring.internal").calculate_commentstring()
    or get_option(filetype, option)
end


require('treesj').setup {
  use_default_keymaps = false,
}
require('which-key').add {
  { '\\t', group = 'TreeSJ' },
}
vim.keymap.set('n', '\\tm', require('treesj').toggle, { desc = 'Toggle tree splitting' })
vim.keymap.set('n', '\\tM', function()
  require('treesj').toggle { split = { recursive = true } }
end, { desc = 'Toggle tree splitting recursive' })
vim.keymap.set('n', '\\ts', require('treesj').split, { desc = 'Split tree' })
vim.keymap.set('n', '\\tj', require('treesj').join, { desc = 'Join tree' })


require('leap').create_default_mappings()
require('leap-spooky').setup {
  paste_on_remote_yank = true,
}


require('snipe').setup {
  ui = { position = 'center', },
  sort = 'last',
}
vim.keymap.set('n', 'gb', require('snipe').open_buffer_menu, { desc = 'Snipe buffer' })
vim.keymap.set("n", "<leader>bs", require('snipe').open_buffer_menu, { desc = 'Snipe buffer' })


require("toggleterm").setup {
  open_mapping = [[<C-\>]],
}


require("project_nvim").setup()


require('highlight-undo').setup()

-- TODO: Keymap for undotree

require('neoscroll').setup {
  easing = "quartic" -- linear, quadratic, cubic, quartic, quintic, circular, sine
}
