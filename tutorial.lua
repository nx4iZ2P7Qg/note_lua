---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by root.
--- DateTime: 4/10/21 10:46 AM
---


-- 号称性能最高的脚本
-- 能和C语言非常好的互动
-- 设计目的是为了嵌入应用程序中，从而为应用程序提供灵活的扩展和定制功能
-- 被设计成支持通用的过程式编程
-- 对面向对象编程，函数式编程，数据驱动式编程提供很好的支持
-- 作为一个扩展式语言，Lua 没有 "main" 程序的概念：它只能 嵌入 一个宿主程序中工作，这个宿主程序被称作 embedding program 或简称为 host
-- Lua 的官方发布版就包含了一个叫做 lua 的简单的宿主程序，它用 Lua 库提供了一个保证独立的 Lua 解释器
-- 一般约定，以下划线开头连接一串大写字母的名字（比如 _VERSION）被保留用于 Lua 内部全局变量
-- Lua 可以调用（和处理）用 Lua 写的函数以及用 C 写的函数

-- 类 C，大小写字符敏感
-- 语句的分号可选
print("Hello World")

-- 交互模式

--[[
多行注释
]]

-- nil, boolean, number, string, function, userdata, thread, and table

-- 数字只有double型，64bits

-- 多行字符串
html = [[
<html>
    <head></head>
    <body></body>
</html>
]]

print(html)

print("str" .. "cat")

-- 未声明使用值为 nil
print("-- undefined")
print(undefined)

-- 默认是全局变量，局部变量前加 local

sum = 0
num = 1
while num <= 100 do
    sum = sum + num
    num = num + 1
end
print("sum =", sum)

-- 1 <= i <= 100
sum = 0
for i = 1, 100 do
    sum = sum + i
end

sum = 0
for i = 1, 100, 2 do
    sum = sum + i
end

sum = 0
for i = 100, 1, -2 do
    sum = sum + 1
end

sum = 2
repeat
    sum = sum ^ 2
    print("repeat", sum)
until sum > 1000

age = 14
sex = "male"
if age == 12 and sex == "female" then
    print("if a\n")
elseif age < 20 or sex ~= "male" then
    io.write("if b\n")
else
    local age = io.read()
    print("if d " .. age .. "\n")
end

-- 函数
function fib(n)
    if n < 2 then
        return 1
    end
    return fib(n - 2) + fib(n - 1)
end

-- 闭包
function newCounter()
    local i = 0
    return function()
        i = i + 1
        return i
    end
end

-- 多返回值
function getUserInfo(id)
    print(id)
    return "a", 37, "b"
end

-- table
table = { k1 = "v1", k2 = 2, k3 = true }

-- array
arr = { 1, 2, 3, "5" }

-- Lua的下标从1开始
-- #arr 代表长度
for i = 1, #arr do
    print(arr[i])
end

-- 全局变量保存在 _G 这个 table 中
print("_G", _G.sum)
print("_G", _G["sum"])

-- todo
--for k, v in table do
--    print("k, v =", k, v)
--end

-- 2/3 + 4/7
fraction_a = { numerator = 2, denominator = 3 }
fraction_b = { numerator = 4, denominator = 7 }

fraction_op = {}
function fraction_op.__add(f1, f2)
    ret = {}
    ret.numerator = f1.numerator * f2.denominator + f2.numerator * f1.denominator
    ret.denominator = f1.denominator * f2.denominator
    return ret
end

setmetatable(fraction_a, fraction_op)
setmetatable(fraction_b, fraction_op)

fraction_s = fraction_a + fraction_b
print("MetaTable", fraction_s.numerator, fraction_s.denominator)

-- __add 是 MetaMethod, Lua内建, 其它 MetaMethod
--__add(a, b)                     对应表达式 a + b
--__sub(a, b)                     对应表达式 a - b
--__mul(a, b)                     对应表达式 a * b
--__div(a, b)                     对应表达式 a / b
--__mod(a, b)                     对应表达式 a % b
--__pow(a, b)                     对应表达式 a ^ b
--__unm(a)                        对应表达式 -a
--__concat(a, b)                  对应表达式 a .. b
--__len(a)                        对应表达式 #a
--__eq(a, b)                      对应表达式 a == b
--__lt(a, b)                      对应表达式 a < b
--__le(a, b)                      对应表达式 a <= b
--__index(a, b)                   对应表达式 a.b
--__newindex(a, b, c)             对应表达式 a.b = c
--__call(a, ...)                  对应表达式 a(...)

-- __index，如果我们有两个对象 a 和 b，我们想让 b 作为 a 的 prototype 只需要
Window_Prototype = { x = 0, y = 0, width = 100, height = 100 }
MyWin = { title = "Hello" }
setmetatable(MyWin, { __index = Window_Prototype })

print("prototype", MyWin.width)

-- 当表要索引一个值时如 table[key], Lua 会首先在 table 本身中查找 key 的值,
-- 如果没有并且这个 table 存在一个带有 __index 属性的 Metatable, 则 Lua 会按照 __index 所定义的函数逻辑查找


-- Lua 的面向对象
Person = {}

function Person:new(p)
    local obj = p
    if (obj == nil) then
        obj = { name = "m", age = 12, handsome = true }
    end
    -- 担心 self 被扩展后改写
    self.__index = self
    return setmetatable(obj, self)
end

function Person:toString()
    return self.name .. " : " .. self.age .. " : " .. (self.handsome and "handsome" or "ugly")
end

me = Person:new()
print("me", me:toString())

kf = Person:new { name = "k", age = 30, handsome = false }
print("kf", kf:toString())

-- 继承
Student = Person:new()

function Student:new()
    newObj = { year = 2021 }
    self.__index = self
    return setmetatable(newObj, self)
end

function Student:toString()
    return "Student : " .. self.year .. " : " .. self.name
end