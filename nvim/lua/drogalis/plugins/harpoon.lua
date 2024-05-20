return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
        keys = {
      { "<leader>hp", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },	 	{ "<leader>hp1", function() require("harpoon"):list():replace_at(1) end, desc = "harpoon to file 1", },
      { "<leader>hp2", function() require("harpoon"):list():replace_at(2) end, desc = "harpoon to file 2", },
      { "<leader>hp3", function() require("harpoon"):list():replace_at(3) end, desc = "harpoon to file 3", },
      { "<leader>hp4", function() require("harpoon"):list():replace_at(4) end, desc = "harpoon to file 4", },
      { "<leader>hp5", function() require("harpoon"):list():replace_at(5) end, desc = "harpoon to file 5", }, 
    },
  }
    

