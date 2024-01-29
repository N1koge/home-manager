local set = vim.keymap.set

-- use <space> as <leader>
vim.g.mapleader = ' '

-- Normal --
-- misc
set("n", "<leader>co", ":copen<CR>", opts);
set("n", "<leader>cc", ":cclose<CR>", opts);
-- tab nav
set("n", "<C-.>", ":tabnext<CR>", opts)
set("n", "<C-,>", ":tabprev<CR>", opts)
-- window nav
set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
set("n", "<leader>kw", "<C-w>w", { desc = "Go to hover window", remap = true })
---- split window
-- set("n", "<leader>ss", ":split<CR><C-w>w", opts)
set("n", "<leader>vs", ":vsplit<CR><C-w>w", opts)

-- formatting
set("n", "<leader>df", vim.lsp.buf.format)

-- diagnostic
set("n", "<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>")
set("n", "<leader>dn", '<cmd>lua vim.diagnostic.goto_next({ severity = "error" })<CR>')
set("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>")

-- lsp
set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")

-- Visual --
-- misc
set("v", "<leader>cp", "\"+y")

