-- main module file
--local module = require("spzenhan-lua.module")

-- **************************************************
-- *  spzenhan-lua 
-- **************************************************

-- Set Path to "spzenhan.exe" 
local exe_path = '../zenhan/spzenhan.exe'

-- Get this scripst file path
local this_full_path = debug.getinfo(1, 'S').source:sub(2)
local file_name      = string.match( this_full_path, '[^/]+$')
local this_path      = this_full_path:sub(1, #this_full_path - #file_name)
local spzenhan_exe   = this_path .. exe_path



local M = {}
M.config = {
    -- default config
    opt               = "default setting",
    spzenhan_exe      = spzenhan_exe     , -- Execute Bin  
    spzenhan_default  = 0                , -- Status 0:IME off when InsertLeave / 1:Keep IME status when InsertLeave
}


-- Check WSL or Not
M.spzenhan_wsl =  0

M.checkWSL = function()
    if vim.fn.has('unix') then
        local uname = vim.fn.system( 'uname -a' )
        if ( vim.fn.stridx( uname, 'Linux') ~= -1) and ( vim.fn.stridx( uname, 'microsoft-standard') ~= -1) then
            M.spzenhan_wsl = 1
        else
            M.spzenhan_wsl = 0
        end
    end
end



-- Check Windows(inc WSL) or Not
M.spzenhan_ena = 0

M.checkWindows = function()
    if (vim.fn.has('win32') == 1) or (vim.fn.has('win32unix') == 1) or ( M.spzenhan_wsl == 1) then
        M.spzenhan_ena = 1
        --M.spzenhan_ena = 0 -- Debug
    else
        M.spzenhan_ena = 0
    end
end


-- Set autocmd (setup function)
M.setup = function(args)


    -- Overriding config settings
    M.config = vim.tbl_deep_extend("force", M.config, args or {})


    -- Environmental Check ( Windows(WSL) or Not)
    M.checkWSL()
    M.checkWindows()

    if M.spzenhan_ena == 1 then
        -- autocmd
        vim.api.nvim_create_augroup( 'zenhan', {} )
        vim.api.nvim_create_autocmd( 'BufEnter', {
            pattern ={ "*" },
            group = 'zenhan',
            callback = function()
                vim.g.spzenhan_status = tonumber( vim.fn.system( M.config.spzenhan_exe ) )
            end,
        })
        vim.api.nvim_create_autocmd( 'InsertEnter', {
            pattern ={ "*" },
            group = 'zenhan',
            callback = function()
                -- if (M.config.spzenhan_default == 1) and (vim.g.spzenhan_status == '1') then
                --     vim.g.spzenhan_status = vim.fn.system( M.config.spzenhan_exe .. ' 1' )
                -- end
                if (M.config.spzenhan_default == 1) and (vim.g.spzenhan_status == 1 ) then
                    vim.g.spzenhan_status = tonumber( vim.fn.system( M.config.spzenhan_exe .. ' 1' ) )
                end
            end,
        })
        vim.api.nvim_create_autocmd( 'InsertLeave', {
            pattern ={ "*" },
            group = 'zenhan',
            callback = function()
                vim.g.spzenhan_status = tonumber( vim.fn.system( M.config.spzenhan_exe .. ' 0' ) )
            end,
        })
    end

end



-- Debug function ...
M.put = function(args)

    print( M.config.spzenhan_exe)
    --print( M.config.spzenhan_default)
end



return M



