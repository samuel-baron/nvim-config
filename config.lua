-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Enable powershell as your default shell
vim.opt.shell = "pwsh.exe"
vim.opt.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

-- Set a compatible clipboard manager
vim.g.clipboard = {
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}

-- Buffer navigation keybindings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Next buffer with Tab
map('n', '<Tab>', ':bnext<CR>', opts)

-- Previous buffer with Shift + Tab
map('n', '<S-Tab>', ':bprevious<CR>', opts)

-- Custom command for formatting
vim.api.nvim_create_user_command('Format', function()
  vim.lsp.buf.formatting_sync(nil, 1000)
end, { desc = "Format current buffer" })

vim.opt.relativenumber = true;
vim.api.nvim_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true });

lvim.auto_save = true;
lvim.format_on_save = true;
lvim.lint_on_save = true;
lvim.colorscheme = "mai_dark";
lvim.transparent_window = true;
lvim.plugins = {
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      -- copilot assume mapped
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    "hrsh7th/cmp-copilot",
    config = function()
      lvim.builtin.cmp.formatting.source_names["copilot"] = "( )"
      table.insert(lvim.builtin.cmp.sources, 2, { name = "copilot" })
    end,
  },
  { "ayu-theme/ayu-vim" },
  { 'doki-theme/doki-theme-vim' },
}
