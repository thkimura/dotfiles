return {
  "codota/tabnine-nvim",
  build = "./dl_binaries.sh",
  config = function()
    require("tabnine").setup({
      disable_auto_comment = true,
      accept_key = "<Tab>", -- Ou a tecla que você preferir
      dismiss_key = "<C-]>", -- Ou a tecla que você preferir
      debounce_ms = 800,
      max_lines = 1000,
      max_num_results = 20,
      sort = true,
      run_on_every_keystroke = false,
      snippet_engine = "luasnip", -- Se você usa luasnip
      inline_hint = true,
      -- Outras opções de configuração podem ser adicionadas aqui
      -- Veja a documentação do Tabnine para mais detalhes:
      -- https://github.com/codota/tabnine-nvim
    })
  end,
}
