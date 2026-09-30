return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },

  opts = {
    servers = {
      lua_ls = {},
    },
  },

  config = function(_, opts)
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    for server, config in pairs(opts.servers) do
      config.capabilities = capabilities

      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end
  end,
}
