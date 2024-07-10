local rs = game:GetService("RunService")
local _time = os.clock();
local delta_time = os.clock() - _time
_G.time_allw = false

local function format_time(_delta)
	local h = math.floor(_delta / 3600)
	local m = math.floor((_delta - (h * 3600))/60)
	local sec = math.floor((_delta - (h * 3600) - (m * 60)))
	local ms = 100 * (_delta - math.floor(_delta))
	local format = "%02d:%02d:%02d:%02d"
	return format:format(h,m,sec,ms)
end


rs.Stepped:Connect(function(time, deltaTime) 
	script.Parent.Text = format_time(time - deltaTime);
end)