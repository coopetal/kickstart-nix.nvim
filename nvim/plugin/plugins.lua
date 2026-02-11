if vim.g.did_load_plugins_plugin then
  return
end
vim.g.did_load_plugins_plugin = true

-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

---------- Theme ----------
require("nightfox").setup({
  palettes = {
    carbonfox = {
      blue = { base = "#39BAE6", bright = "#56C4E9", dim = "#309EC3" },
      magenta = { base = "#FF8F40", bright = "#FF9F5C", dim = "#D87936" },
      cyan = { base = "#FFB454", bright = "#FFBF6D", dim = "#D89947" },
      red = { base = "#F07178", bright = "#F2868C", dim = "#CC6066" },
      pink = { base = "#CB9FF8", bright = "#D2ADF9", dim = "#AC87D2" },
      white = { base = "#F2F4F8", bright = "#F3F5F9", dim = "#CDCFD2" },

      comment = "#636A72",
      -- bg0 = "#0B0E14",
      -- bg1 = "#0B0E14",
      bg0 = "#161616",
    },
  },
})
vim.cmd("colorscheme carbonfox")

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


-- require('leap').create_default_mappings()
vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')
vim.keymap.set({'x', 'o'},      'x', '<Plug>(leap-forward-till)')
vim.keymap.set({'x', 'o'},      'X', '<Plug>(leap-backward-till)')
vim.keymap.set({'x', 'o'}, 'R',  function ()
  require('leap.treesitter').select {
    opts = require('leap.user').with_traversal_keys('R', 'r')
  }
end)
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
  autochdir = true,
  direction = 'float',
}


require("project").setup()


require('highlight-undo').setup()

-- TODO: Keymap for undotree

require('neoscroll').setup {
  easing = "quartic" -- linear, quadratic, cubic, quartic, quintic, circular, sine
}

require("colorizer").setup()
