return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
    window = {
      width = 30,
      mappings = { h = "toggle_hidden", ["<Space><BS>"] = "reveal_root" }
,
    },
    -- }
  },
}
