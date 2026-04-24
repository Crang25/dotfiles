return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Spectre",
    opts = {},
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").toggle()
        end,
        desc = "Search/replace in project",
      },
      {
        "<leader>sw",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Search current word in project",
      },
      {
        "<leader>sf",
        function()
          require("spectre").open_file_search({ select_word = true })
        end,
        desc = "Search/replace in current file",
      },
      {
        "<leader>sr",
        mode = "v",
        function()
          require("spectre").open_visual()
        end,
        desc = "Search selected text in project",
      },
    },
  },
}
