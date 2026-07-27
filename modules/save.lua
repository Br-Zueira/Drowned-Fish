local json = require "libs.json"

local save = {}

local function saveJson(file, rawData)
    -- Clean up any leftover temp files from past failed saves
    love.filesystem.remove(file .. '.temp.json')

    -- Encodes lua table into a json string
    local data = json.encode(rawData)

    -- Writes into temporary file to avoid main save corruption
    local success, _ = love.filesystem.write(file .. '.temp.json', data)
    if not success then return false end -- Returns false if failed to save

    -- Checks if file is not corrupted
    local written, byteNum = love.filesystem.read(file .. '.temp.json')
    if not written or byteNum == 0 then -- Corrupted file
        love.filesystem.remove(file .. '.temp.json') -- Removes the corrupted file
        return false -- Returns false
    end

    -- Overrites main file
    success = love.filesystem.write(file .. '.json', written)
    if not success then
        return false -- Lets temp as a backup
    end
    love.filesystem.remove(file .. '.temp.json') -- Removes the temporary file
    return success -- Returns a bool telling whether the original file could be created or overriden
end

local function loadJson(file)
    -- Tries to read the raw content of file
    local rawContent, byteNum = love.filesystem.read(file .. '.json')
    if not rawContent or byteNum == 0 then return nil end -- Returns nil if can't read file

    -- Tries to decode raw content into a lua table
    local success, table = pcall(json.decode, rawContent) -- Safely returns a success bool instead of crashing game
    if not success or not table then return nil end -- Returns nil if json can't be decoded or if
    return table -- Returns decoded json
end

return save