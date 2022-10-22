local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.buttons.val = {
	dashboard.button("n", "New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("c", "Configuration", ":e ~/.dotfiles/config/nvim <CR>"),
	dashboard.button("q", "Quit Neovim", ":qa<CR>"),
}

local function footer()
	return "mfrata"
end

dashboard.section.footer.val = footer()

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
