local rs = game:GetService("RunService");
local char = script.Parent;
local human = char:WaitForChild("Humanoid");
local intesity = 0.3
local _intesity = 1 - intesity

function update_wobble()
	if human.MoveDirection.Magnitude > 0 then
		local wobble_X = math.cos(tick()*7)*intesity;
		local wobble_Y = math.abs(math.sin(tick()*7))*intesity;
		local wobble = Vector3.new(wobble_X,wobble_Y,0);
		
		human.CameraOffset = human.CameraOffset:lerp(wobble,intesity);
	else
		human.CameraOffset = human.CameraOffset * _intesity
	end
end

rs.RenderStepped:Connect(function()
	update_wobble();
end)