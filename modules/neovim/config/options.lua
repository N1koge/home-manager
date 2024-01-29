local opt = vim.opt

opt.cursorline = true
opt.expandtab = true
opt.fillchars = "vert:│,horiz:-"
opt.formatoptions = "jcrql"
opt.laststatus = 3
opt.number = true
opt.showtabline = 2
opt.shiftround = true
opt.shiftwidth = 2
opt.signcolumn = "auto:2"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.undofile = true
opt.wildmode = "longest:full,full"
opt.wrap = false

-- Folding
opt.foldcolumn = '0'
opt.foldlevel = 99
opt.foldenable = true
opt.foldmethod = 'indent'

vim.api.nvim_set_option('updatetime', 1000)
