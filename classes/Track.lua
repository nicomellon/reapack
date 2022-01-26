--[[
  Class Constructor
]]

Track = {}
function Track:new(pointer)
  Track.__index = Track
  local obj = {}
  setmetatable(obj, Track)
  obj.pointer = pointer
  obj.num = reaper.GetMediaTrackInfo_Value(obj.pointer, "IP_TRACKNUMBER")
  obj.depth = reaper.GetTrackDepth(obj.pointer)
  return obj
end

--[[
  Class Methods
]]

function Track:hideInTCP()
  reaper.SetMediaTrackInfo_Value(self.pointer, "B_SHOWINTCP", 0)
end

function Track:showInTCP()
  reaper.SetMediaTrackInfo_Value(self.pointer, "B_SHOWINTCP", 1)
end

return Track