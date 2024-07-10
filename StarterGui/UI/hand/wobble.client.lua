local rs = game:GetService("RunService");
local uis = game:GetService("UserInputService");
local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait();
local human = char:WaitForChild("Humanoid");
local intesity = .2;
local _intesity = 1 - intesity;
local allw = true
local pos = script.Parent.Position;
local pos_x = 0.32;
local pos_y = 0.488;

function update_wobble()
	if human.MoveDirection.Magnitude > 0 then
		local BobbleX = (math.cos(os.clock() * 7) * 0.01) 
		local BobbleY = math.abs(math.sin(os.clock() * 7) * 0.01)
		
		script.Parent.Position = pos + UDim2.new(BobbleX,0,BobbleY,0)
	else
		script.Parent:TweenPosition(UDim2.new(pos_x,0,pos_y,0),Enum.EasingDirection.In,Enum.EasingStyle.Sine,.05)
	end
end

uis.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if _G.dead == false then
				if allw == true then
				allw = false
					script.Parent.Visible = false;
					script.Parent.Parent.hand2.Visible = true;
				task.wait(.1);
					script.Parent.Parent.hand2.Visible = false;
					script.Parent.Parent.hand3.Visible = true;
				task.wait(.15);
					script.Parent.Parent.hand2.Visible = true;
					script.Parent.Parent.hand3.Visible = false;
				task.wait(.1);
					script.Parent.Parent.hand2.Visible = false;
					script.Parent.Visible = true;
				allw = true
			end
		end
	end
end)

rs.RenderStepped:Connect(function()
	if _G.dead == false then
		update_wobble();
	end
end)