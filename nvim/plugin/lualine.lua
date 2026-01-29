if vim.g.did_load_lualine_plugin then
  return
end
vim.g.did_load_lualine_plugin = true

local navic = require('nvim-navic')
navic.setup {}

---Indicators for special modes,
---@return string status
local function extra_mode_status()
  -- recording macros
  local reg_recording = vim.fn.reg_recording()
  if reg_recording ~= '' then
    return ' @' .. reg_recording
  end
  -- executing macros
  local reg_executing = vim.fn.reg_executing()
  if reg_executing ~= '' then
    return ' @' .. reg_executing
  end
  -- ix mode (<C-x> in insert mode to trigger different builtin completion sources)
  local mode = vim.api.nvim_get_mode().mode
  if mode == 'ix' then
    return '^X: (^]^D^E^F^I^K^L^N^O^Ps^U^V^Y)'
  end
  return ''
end

require('lualine').setup {
  options = {
    theme = 'auto',
    always_show_tabline = false,
    globalstatus = true,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  -- Status line config
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = { { 'branch', draw_empty = true }, 'diff' },
    lualine_c = {
      -- nvim-navic
      { navic.get_location, cond = navic.is_available },
    },
    lualine_x = {
      {
        'encoding',
        show_bomb = true,
      },
      'fileformat',
    },
    lualine_y = {
      {
        'filetype',
        draw_empty = true,
      },
      'lsp_status',
    },
    lualine_z = {
      { 'hostname', separator = { right = '' }, left_padding = 2 },
    },
  },
  -- Tab line config
  tabline = {
    lualine_a = {
      {
        'tabs',
        mode = 1,
        use_mode_colors = true,
        separator = { left = '', right = '' },
        right_padding = 2,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  -- Window bar config
  winbar = {
    lualine_a = {
      {
        extra_mode_status,
        separator = { left = '' },
        right_padding = 2,
        draw_empty = true,
      }
    },
    lualine_b = { 'progress', 'location', },
    lualine_c = { 'diagnostics' },
    lualine_z = {
      {
        'filename',
        path = 1,
        file_status = true,
        newfile_status = true,
        separator = { left = '', right = '' },
        left_padding = 2,
      },
    },
  },
  inactive_winbar = {
    lualine_z = {
      {
        'filename',
        path = 1,
        file_status = true,
        newfile_status = true,
        separator = { left = '', right = '' },
        left_padding = 2,
      },
    },
  },
  extensions = { 'fugitive', 'fzf', 'toggleterm', 'quickfix' },
}
