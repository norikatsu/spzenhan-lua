-- **************************************************
-- *  spzenhan-lua 
-- **************************************************

local exe_path = '../zenhan/spzenhan.exe'

-- Get this scripst file path
local this_full_path = debug.getinfo(1, 'S').source:sub(2)
local file_name      = string.match( this_full_path, '[^/]+$')
local this_path      = this_full_path:sub(1, #this_full_path - #file_name)
local spzenhan_exe   = this_path .. exe_path
--print( this_path    )
--print( spzenhan_exe )



-- Run spzenhan setup function
require("spzenhan-lua").setup({
    spzenhan_defautlt = 0,              -- Status 0:IME off when InsertLeave / 1:Keep IME status when InsertLeave
    spzenhan_exe      = spzenhan_exe,   -- Set spzenhan.exe full path
})

-- for Debug
--require("spzenhan-lua").put()




