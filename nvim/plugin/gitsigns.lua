if vim.g.did_load_gitsigns_plugin then
  return
end
vim.g.did_load_gitsigns_plugin = true

vim.schedule(function()
  require('gitsigns').setup {
    current_line_blame = false,
    current_line_blame_opts = {
      ignore_whitespace = true,
    },
    signs = {
      add = { text = '' },
      change = { text = '󰧚' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '' },
    },
    signs_staged = {
      add = { text = '' },
      change = { text = '󰧚' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '' },
      untracked = { text = '' },
    },
    signs_staged_enable = true,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']g', function()
        if vim.wo.diff then
          return ']g'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Git next hunk' })

      map('n', '[g', function()
        if vim.wo.diff then
          return '[g'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Git previous hunk' })

      -- Actions
      map({ 'n', 'v' }, '<leader>hs', function()
        vim.cmd.Gitsigns('stage_hunk')
      end, { desc = 'Git hunk stage' })
      map({ 'n', 'v' }, '<leader>hr', function()
        vim.cmd.Gitsigns('reset_hunk')
      end, { desc = 'Git hunk reset' })
      map('n', '<leader>hS', gs.stage_buffer, { desc = 'Git stage buffer' })
      map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Git hunk undo stage' })
      map('n', '<leader>hR', gs.reset_buffer, { desc = 'Git buffer Reset' })
      map('n', '<leader>hp', gs.preview_hunk, { desc = 'Git hunk preview' })
      map('n', '<leader>hb', function()
        gs.blame_line { full = true }
      end, { desc = 'Git blame line (full)' })
      map('n', '<leader>glb', gs.toggle_current_line_blame, { desc = 'Git toggle current line blame' })
      map('n', '<leader>hd', gs.diffthis, { desc = 'Git diff this' })
      map('n', '<leader>hD', function()
        gs.diffthis('~')
      end, { desc = 'Git Diff ~' })
      map('n', '<leader>td', gs.toggle_deleted, { desc = 'Git toggle deleted' })
      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Git stage buffer' })
    end,
  }
end)
