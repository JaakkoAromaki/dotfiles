return {
  -- add gruvbox
  { "JaakkoAromaki/greentext.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "greentext",
    },
  }
}
