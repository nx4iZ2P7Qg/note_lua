-- require 即运行
require("print")


local model = require("mymod")
model.Greeting()

--[[
local model = (function ()
  mymod.lua文件的内容
end)()
]]



