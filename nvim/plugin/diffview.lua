if vim.g.did_load_diffview_plugin then
  return
end
vim.g.did_load_diffview_plugin = true

vim.keymap.set('n', '<leader>gfb', function()
  vim.cmd.DiffviewFileHistory(vim.api.nvim_buf_get_name(0))
end, { desc = 'Diffview git file history (current buffer)' })
vim.keymap.set('n', '<leader>gfc', vim.cmd.DiffviewFileHistory, { desc = 'Diffview git file history (cwd)' })
vim.keymap.set('n', '<leader>gd', vim.cmd.DiffviewOpen, { desc = 'Git diffview open' })
vim.keymap.set('n', '<leader>gft', vim.cmd.DiffviewToggleFiles, { desc = 'Git diffview files toggle' })
