local json = require "libs.json"

local save = {}

function save.saveJson(file, rawData)
    local temp = file .. '.temp.json'
    local main = file .. '.json'

    -- Clean up any leftover temp files from past failed saves
    love.filesystem.remove(temp)

    -- Encodes lua table into a json string
    local data = json.encode(rawData)

    -- Writes into temporary file to avoid main save corruption
    local success, _ = love.filesystem.write(temp, data)
    if not success then return false end -- Returns false if failed to save

    -- Checks if file is not corrupted
    local written, byteNum = love.filesystem.read(temp)
    if not written or byteNum == 0 then -- Corrupted file
        love.filesystem.remove(temp) -- Removes the corrupted file
        return false -- Returns false
    end

    -- Overrites main file
    success = love.filesystem.write(main, written)
    if not success then
        return false -- Lets temp as a backup
    end
    love.filesystem.remove(temp) -- Removes the temporary file
    return success -- Returns a bool telling whether the original file could be created or overriden
end

local function tryToLoad(file)
    -- Tries to read the raw content of file
    local rawContent, byteNum = love.filesystem.read(file)
    if not rawContent or byteNum == 0 then return nil end -- Returns nil if can't read file

    -- Tries to decode raw content into a lua table
    local success, table = pcall(json.decode, rawContent) -- Safely returns a success bool instead of crashing game
    if not success or not table then return nil end -- Returns nil if json can't be decoded or if
    return table -- Returns decoded json
end

function save.loadJson(file)
    -- Tries to load the main file
    local content = tryToLoad(file .. '.json')
    if content then return content end -- If successful, returns it right away

    -- Tries to load the temp file as a backup
    local backup = tryToLoad(file .. '.temp.json')
    if backup then
        -- Autorepair if possible
        save.saveJson(file, backup)
        return backup
    end

    -- Return nil if every possible option failed
    return nil
end

return save