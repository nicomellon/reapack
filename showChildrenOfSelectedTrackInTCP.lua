--[[
  File Imports
]]

function reaperDoFile(file)
  -- necessary code to import other lua files by relative path
  local info = debug.getinfo(1,'S')
  script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
  dofile(script_path .. file)
end

reaperDoFile("classes/Track.lua") -- class for media tracks
reaperDoFile("classes/Project.lua") -- class for reaper project

--[[
  Main script
]]

local project = Project:new()

-- get first selected media track
local selected = Track:new(reaper.GetSelectedTrack(0, 0))

local i = selected.num

while i < project.trackCount do
  -- loop through child tracks and hide them

  child = Track:new(reaper.GetTrack(0, i))
  
  if child.depth <= selected.depth then break end
  
  child:showInTCP()
  
  i = i + 1
  
end

project.updateWindow() -- update reaper view
