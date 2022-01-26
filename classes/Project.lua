--[[
  Class Constructor
]]

Project = {}
function Project:new()
  Project.__index = Project
  local obj = {}
  setmetatable(obj, Project)
  obj.trackCount = reaper.CountTracks()
  return obj
end

--[[
  Class Methods
]]

function Project:updateWindow()
  reaper.UpdateArrange()
  reaper.UpdateTimeline()
  reaper.TrackList_AdjustWindows(false)
end

return Project