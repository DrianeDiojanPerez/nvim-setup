return {
    "okuuva/auto-save.nvim",
    config = function()       require("auto-save").setup {
        enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
        execution_message = {
            enabled = true,
            message = function() -- message to print on save
                local current_time = os.date("*t")

                -- Convert hours to 12-hour format
                local hour = current_time.hour % 12
                hour = (hour == 0) and 12 or hour

                -- Format the time
                local formatted_time = string.format("%02d:%02d:%02d %s",
                    hour,
                    current_time.min,
                    current_time.sec,
                    (current_time.hour >= 12) and "PM" or "AM")
                return ("AutoSave: saved at " .. formatted_time)
            end,
            dim = 0.18, -- dim the color of `message`
            cleaning_interval = 15250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
        },
        trigger_events = { -- See :h events
            immediate_save = { "FocusLost" }, -- vim events that trigger an immediate save
            defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
            cancel_defered_save = { "InsertEnter", "CompleteChanged", "BufLeave" }, -- vim events that cancel a pending deferred save
        },
        -- function that takes the buffer handle and determines whether to save the current buffer or not
        -- return true: if buffer is ok to be saved
        -- return false: if it's not ok to be saved
        -- if set to `nil` then no specific condition is applied
        condition = function(buf)
            local fn = vim.fn
            local utils = require("auto-save.utils.data")
             if
                fn.getbufvar(buf, "&modifiable") == 1 and
                vim.api.nvim_buf_is_valid(buf) and
                utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
                return true -- met condition(s), can save
            end
            return false -- can't save
        end,
        write_all_buffers = false, -- write all buffers when the current one meets `condition`
        noautocmd = false, -- do not execute autocmds when saving
        debounce_delay = 1200, -- delay after which a pending save is executed
        -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
        debug = false,
    }
    end,
}
