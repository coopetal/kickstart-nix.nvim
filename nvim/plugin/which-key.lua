require('which-key').setup {
  -- preset = 'helix'
}

require('which-key').add {
  { '<leader>b', group = 'Buffers' },
  { '<leader>c', group = 'Code' },
  { '<leader>d', group = 'Document' },
  { '<leader>r', group = 'Rename' },
  { '<leader>s', group = 'Search' },
  { '<leader>w', group = 'Workspace' },
  { '<leader>p', group = 'Peek' },
  { '<leader>t', group = 'Tabs' },
  { '<leader>g', group = 'NeoGit', },
  { '<leader>gf', group = 'DiffView', },
  { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
}
