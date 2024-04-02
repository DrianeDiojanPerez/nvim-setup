return {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = function ()
        require('git-conflict').setup ({
            default_mappings = {
                ours = 'co',
                theirs = 'ct',
                none = 'c0',
                both = 'cb',
                next = 'gn',
                prev = 'gp',
            }, -- disable buffer local mapping created by this plugin
            default_commands = true, -- disable commands created by this plugin
            disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
            list_opener = 'copen', -- command or function to open the conflicts list
            highlights = { -- They must have background color, otherwise the default color will be used
                incoming = 'DiffAdd',
                current = 'DiffText',
            }
        })

    end
}
