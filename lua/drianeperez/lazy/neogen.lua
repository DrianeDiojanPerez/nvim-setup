return{
    "danymat/neogen",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "L3MON4D3/LuaSnip",
    },
    config = function ()
        -- code
        local neogen = require("neogen")
        neogen.setup({
            snippet_engine = "luasnip"
        })
        vim.keymap.set("n", "<leader>gf", function ()
            -- code
            neogen.generate({ type = "func" })
        end)
        vim.keymap.set("n", "<leader>gt", function ()
            -- code
            neogen.generate({ type = "type" })
        end)
        vim.keymap.set("n", "<leader>gc", function ()
            -- code
            neogen.generate({ type = "class" })
        end)
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
}
