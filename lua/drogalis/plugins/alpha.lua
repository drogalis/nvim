return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {
			"                                                    ",
			" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                    ",
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "   >    New File", "<cmd>ene<CR>"),
			dashboard.button("SPC so", "   >    Recently used files", ":Telescope oldfiles <CR>"),
			dashboard.button("SPC ee", "   >    Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("SPC sf", "   >  󰱼  Find file", "<cmd>Telescope find_files<CR>"),
			dashboard.button("c", "   >    Configuration", ":e ~/.config/nvim/init.lua<CR>"),
			dashboard.button("q", "   >     Quit Neovim", "<cmd>qa<CR>"),
		}

		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		require("alpha").setup(dashboard.opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

				-- local now = os.date "%d-%m-%Y %H:%M:%S"
				local version = "   v"
					.. vim.version().major
					.. "."
					.. vim.version().minor
					.. "."
					.. vim.version().patch
				local fortune = require("alpha.fortune")
				local quote = table.concat(fortune(), "\n")
				local plugins = "⚡Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
				local footer = "\t" .. version .. "\t" .. plugins .. "\n" .. quote
				dashboard.section.footer.val = footer
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
