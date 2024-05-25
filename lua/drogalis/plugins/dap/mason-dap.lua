return {
	"jay-babu/mason-nvim-dap.nvim",
	event = "VeryLazy",
	dependencies = {
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		local dap = require("dap")

		-- setup mason and ensure cpptools is installed
		require("mason").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = { "cpptools" },
		})

		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = "OpenDebugAD7",
			options = {
				detached = false,
			},
		}
		
		dap.adapters.codelldb = {
			id = "codelldb",
			type = "executable",
			command = "gdb",
			args = { "--quiet", "--interpreter=dap" },
		}

		dap.adapters.gdb = {
			id = "gdb",
			type = "executable",
			command = "gdb",
			args = { "--quiet", "--interpreter=dap" },
		}

		dap.configurations.cpp = {
			{
				name = "Run executable (GDB)",
				type = "gdb",
				request = "launch",
				-- This requires special handling of 'run_last', see
				-- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
				program = function()
					local path = vim.fn.input({
						prompt = "Path to executable: ",
						default = vim.fn.getcwd() .. "/",
						completion = "file",
					})

					return (path and path ~= "") and path or dap.ABORT
				end,
			},
			{
				name = "Run executable with arguments (GDB)",
				type = "gdb",
				request = "launch",
				-- This requires special handling of 'run_last', see
				-- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
				program = function()
					local path = vim.fn.input({
						prompt = "Path to executable: ",
						default = vim.fn.getcwd() .. "/",
						completion = "file",
					})

					return (path and path ~= "") and path or dap.ABORT
				end,
				args = function()
					local args_str = vim.fn.input({
						prompt = "Arguments: ",
					})
					return vim.split(args_str, " +")
				end,
			},
			{
				name = "Attach to process (GDB)",
				type = "gdb",
				request = "attach",
				processId = require("dap.utils").pick_process,
			},
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
		}

		dap.configurations.h = dap.configurations.cpp
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.hpp = dap.configurations.cpp
	end,
}
