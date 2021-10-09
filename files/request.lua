local args = {...}
if #args == 1 then
    filename = args[1]
else
    print("Unexpected number of arguments")
    return 1
end

local res = http.get(SERVER_IP .. filename)

if res.getResponseCode() == 404 then
    print("TurtleTXT could not find " .. filename .. ".lua")
    return 1
end

local initialFileSize = 0
if fs.exists(filename) then
    initialFileSize = fs.getSize(filename)
end

file = fs.open(filename, "w")

initialFileSize = fs.getSize(filename)
file.write(res.readAll())

file.close()
res.close()

local finalFileSize = fs.getSize(filename)
local fileSizeDiff = finalFileSize - initialFileSize

if fileSizeDiff >= 0 then
    print("Wrote " .. fileSizeDiff .. " bytes to " .. filename .. ".lua")
else
    print("Removed " .. fileSizeDiff .. " bytes from " .. filename .. ".lua")
end

return 0
