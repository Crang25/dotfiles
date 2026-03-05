return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local neotree = require("neo-tree")
    neotree.setup({
      filesystem = {
        follow_current_file = { enabled = true }, -- Automatically focus the current file
      },
    })

    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", {})
  end,
}
