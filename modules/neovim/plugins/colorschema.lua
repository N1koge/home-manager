return {
  'folke/tokyonight.nvim',
  lazy = false,
  config = function()
    vim.cmd.colorscheme "tokyonight-moon"
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='red' })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='white' })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='red' })
  end,
}
