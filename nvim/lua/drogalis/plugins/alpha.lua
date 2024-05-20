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
      dashboard.button("r", "   >    Recently used files", ":Telescope oldfiles <CR>"),
      dashboard.button("SPC ee", "   >    Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("SPC ff", "   >  󰱼  Find file", "<cmd>Telescope find_files<CR>"),
      dashboard.button("c", "   >    Configuration", ":e ~/.config/nvim/init.lua<CR>"),
      dashboard.button("q", "   >     Quit Neovim", "<cmd>qa<CR>"),
    }
    
		-- Footer
		local function footer()
			local version = vim.version()
			local pluginCount = vim.fn.len(vim.fn.globpath(vim.fn.stdpath("data") .. "/lazy", "*", 0, 1))
			local print_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
			local date = os.date("%m.%d.%Y")
			--local datetime = os.date '%m.%d.%Y %H:%M'
			return " " .. print_version .. "   " .. pluginCount .. "   " .. date
		end

		dashboard.section.footer.val = footer()


    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
