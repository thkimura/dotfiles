-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Undo/Redo
keymap.set("n", "<C-z>", "u", opts) -- Desfazer
keymap.set("n", "<C-r>", "<C-r>", opts) -- Refazer

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Navegation with Ctrl + h/j/k/l
keymap.set("n", "<C-h>", "b", opts) -- Palavra para esquerda
keymap.set("n", "<C-l>", "w", opts) -- Palavra para direita
keymap.set("n", "<C-k>", "10k", opts) -- Início da página
keymap.set("n", "<C-j>", "10j", opts) -- Fim da página

-- Diagnostics
--keymap.set("n", "<C-j>", function()
--    vim.diagnostic.goto_next()
--end, opts)

keymap.set("n", "<leader>r", function()
  require("craftzdog.hsl").replaceHexWithHSL()
end)

keymap.set("n", "<leader>i", function()
  require("craftzdog.lsp").toggleInlayHints()
end)
