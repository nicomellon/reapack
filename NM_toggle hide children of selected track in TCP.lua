--[[
  Author: Nico Mellon
  Description: Hides all children of the first selected track 
]]

-- get first selected media track
local selectedTrack = reaper.GetSelectedTrack(0, 0)

-- if no tracks are selected, end the script
if not selectedTrack then return end

-- if the selected track isn't a folder, end the script
if reaper.GetMediaTrackInfo_Value(selectedTrack, "I_FOLDERDEPTH") ~= 1 then return end

-- get selected track's depth
local selectedDepth = reaper.GetTrackDepth(selectedTrack)

-- determine whether to show or hide child tracks
-- if the selected track is in open folder state (I_FOLDERCOMPACT == 0) set toggle to 0 (will hide child tracks)
-- if it's in compact, or supercompact state set toggle to 1 (will show child tracks)
local toggle = reaper.GetMediaTrackInfo_Value(selectedTrack, "I_FOLDERCOMPACT") == 0 and 0 or 1

-- set the selected track to normal (0) or supercompact (2) state accordingly
reaper.SetMediaTrackInfo_Value(selectedTrack, "I_FOLDERCOMPACT", toggle == 0 and 2 or 0)

-- count current number of tracks in the project
local trackCount = reaper.CountTracks()

-- start a counter at the index of the next track (first child track)
local i = reaper.GetMediaTrackInfo_Value(selectedTrack, "IP_TRACKNUMBER")

-- loop through child tracks and show or hide them
while i < trackCount do

  -- get next track
  local nextTrack = reaper.GetTrack(0, i)

  -- get next track's depth
  local nextDepth = reaper.GetTrackDepth(nextTrack)
  
  -- check if track is a child of the selected track
  if nextDepth <= selectedDepth then break end
  
  -- show or hide track in TCP
  reaper.SetMediaTrackInfo_Value(nextTrack, "B_SHOWINTCP", toggle)
  
  i = i + 1
  
end

-- update reaper's window
reaper.UpdateArrange()
reaper.TrackList_AdjustWindows(false)
