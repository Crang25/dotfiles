return {
  {
    "tpope/vim-fugitive",
  },
  {
    "lewis6991/gitsigns.nvim",

    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup()

      vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Git preview hunk" })
      vim.keymap.set("n", "<leader>gt", gitsigns.toggle_current_line_blame, { desc = "Git toggle line blame" })
      vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Git reset hunk" })
      vim.keymap.set("v", "<leader>gr", function()
        local start_line = vim.fn.line("v")
        local end_line = vim.fn.line(".")
        if start_line > end_line then
          start_line, end_line = end_line, start_line
        end
        gitsigns.reset_hunk({ start_line, end_line })
      end, { desc = "Git reset selected hunks" })

      vim.keymap.set("n", "]h", gitsigns.next_hunk, { desc = "Next git hunk" })
      vim.keymap.set("n", "[h", gitsigns.prev_hunk, { desc = "Previous git hunk" })
    end,
  },
}
