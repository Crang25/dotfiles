return {
  -- amongst your other plugins
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup()

      vim.keymap.set("n", "<C-`>", ":ToggleTerm direction=horizontal size=10 <CR>", {})
    end,
  },
}
