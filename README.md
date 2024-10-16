# Strings.lua
Полезные методы для работы со строковыми типами данных на языке программирования Lua, которые упрощают некоторые операции и делают ваш код короче и лаконичнее

# Подключение
Для подключения библиотеки, в начале вашего скрипта пропишите:
```lua
require "strings"
```

# Использование
Использовать библиотеку можно двумя способами, все они работают нативно, будто бы так и задумывалось языком программирования
1) Через обращение к string: `string.METHOD(text, ...)`
2) Используя наследование: `text:METHOD(...)`

# Примеры
> **Разделение строки равные части по 2 символа:**
```lua
local text = "Looooooooooooooooooong"

local arr = text:splitEqually(2)
print( table.concat(arr, " | ") )

-- Output: Lo | oo | oo | oo | oo | oo | oo | oo | oo | oo | ng
```
> **Сравнение строк на сходство:**
```lua
local str_1 = "Привет мир!"
local str_2 = "Привіт світ!"

local diff = string.getSimilarity(str_1, str_2)
print( ("Строки идентичны на %d%%"):format(diff * 100) )

-- Output: Строки идентичны на 58%
```
> **Проверка на начало/окончание строки:**
```lua
local path = "C:\\Images\\icon.txt"

if not path:startsWith("C:\\") then
    print("Directory must be starts with C:\\!")
end

if not path:endsWith(".png") then
    print("File is not PNG image!")
end
```
> **Перенос строк по кол-ву символов:**
```lua
local text = "Пришёл мужик на рынок, видит шляпу. Надевает, а она ему как раз!"
print( string.wrap(text, 15) )

-- Output:
-- Пришёл мужик на
-- рынок, видит
-- шляпу.
-- Надевает, а она
-- ему как раз!
```
