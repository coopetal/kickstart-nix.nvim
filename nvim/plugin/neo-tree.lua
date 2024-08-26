require("neo-tree").setup {
  source_selector = {
    winbar = true,
    statusline = false,
    sources = {
      { source = 'filesystem' },
      { source = 'git_status' },
      { source = 'buffers' },
      { source = 'document_symbols' },
    },
  },
  sources = {
    'filesystem',
    'git_status',
    'buffers',
    'document_symbols',
  },
  filesystem = {
    filtered_items = {
      visible = true, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_hidden = false, -- only works on Windows for hidden files/directories
    },
  },
  document_symbols = {
    follow_cursor = true,
    renderers = {
      symbol = {
        { 'indent', with_expanders = true },
        { 'kind_icon', default = '?' },
        { 'name', zindex = 10 },
        -- removed the kind text as its redundant with the icon
      },
    },
  },
}

require('which-key').add {
  { '<leader>e', group = 'neotree' },
}

vim.keymap.set('n', '<leader>ee', '<cmd>Neotree toggle left<CR>', { desc = 'Toggle' })
vim.keymap.set('n', '<leader>ef', '<cmd>Neotree toggle float<CR>', { desc = 'Floating window' })
vim.keymap.set('n', '<leader>eg', '<cmd>Neotree toggle left<CR>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>eb', '<cmd>Neotree toggle left<CR>', { desc = 'Show buffers' })
vim.keymap.set('n', '<leader>eo', '<cmd>Neotree toggle left<CR>', { desc = 'Symbols Outline' })
