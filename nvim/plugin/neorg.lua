if vim.g.did_load_neorg_plugin then
  return
end
vim.g.did_load_neorg_plugin = true

require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
    }
})
