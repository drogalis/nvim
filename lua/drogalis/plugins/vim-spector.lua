local function debuggers()
	vim.g.vimspector_install_gadgets = {
		"debugpy", -- Python
	}
end

local vimspector_cpp = [[ "configurations": {
    "FinMat": {
      "adapter": "vscode-cpptools",
      "configuration": {
        "type": "cppdbg",
        "request": "launch",
        "program": "${workspaceRoot}/build",
        "args": [],
        "cwd": "${workspaceRoot}",
        "environment": [
          { "name": "VIMRUNTIME", "value": "${workspaceRoot}" }
        ],
        "externalConsole": true,
        "stopAtEntry": true,
        "MIMode": "gdb",
        "setupCommands": [
            {
                "description": "Enable pretty-printing for gdb",
                "text": "-enable-pretty-printing",
                "ignoreFailures": true
            }
        ],
        "logging": {
          "engineLogging": false
        }
      }
    }
  } ]]

return {
	"puremourning/vimspector",
	cmd = { "VimspectorInstall", "VimspectorUpdate" },
	fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
	config = function()
		require("config.vimspector").setup()
	end,
}
