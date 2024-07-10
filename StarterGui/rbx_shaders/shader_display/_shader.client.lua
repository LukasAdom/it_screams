local RunService = game:GetService("RunService");

local render_distance = script:WaitForChild("render_distance");
local Player = game.Players.LocalPlayer;
local Camera = workspace.CurrentCamera;
local Part = Instance.new("Part");

local function createPart()
	Part.Size = Vector3.new(20.6, 12.7, 2);
	Part.Anchored = true;
	Part.CanCollide = false;
	Part.Parent = workspace;
	Part.Name = Player.Name .."_shader_display";
	script.Parent.Parent.Adornee = Part;
end
createPart();

Camera.FieldOfView = 100;

RunService.RenderStepped:Connect(function()
	if Player.Character then
		Part.CFrame = Camera.CFrame * CFrame.new(0, 0, -5);
		script.Parent.CurrentCamera = Camera;
		for _, v in ipairs(script.Parent:GetChildren()) do
			if not v:IsA("Script") then
				v:Destroy();
			end
		end

		for _, v in pairs(game.Workspace:GetChildren()) do
						if v.Name == "TOP" or v.Name == "BOTTOM" or v.Name == "RIGHT" or v.Name == "LEFT" or v.Name == "Part" or v.Name == "Orb" or v.Name == "Orb_min" then
							if (v.Position - Player.Character.PrimaryPart.Position).Magnitude <= render_distance.Value then
								v.Archivable = true;
								v:Clone().Parent = script.Parent;
							
					end
				end
			end
		end

		for _, v in pairs(game.Workspace.Bob:GetChildren()) do
			if v.Name == "Eye" or v.Name == "Left Arm" or v.Name == "Left Leg" or v.Name == "Right Arm" or v.Name == "Right Leg" or v.Name == "Head" then
				if (game.Workspace.Bob.Head.Position - Player.Character.PrimaryPart.Position).Magnitude <= render_distance.Value then
					v.Archivable = true;
					v:Clone().Parent = script.Parent;
			end
		end
	end

		local plr_list = game.Players:GetPlayers()
		for i, player in ipairs(plr_list) do 
			if player == game.Players.LocalPlayer then
				table.remove(plr_list, i)
				break
			end
		end
		for i,k in pairs(plr_list) do
			for _,v in pairs(k.Character:GetChildren()) do
				if v:IsA("Accessory") or v:IsA("CharacterMesh") then
				v.Archivable = true;
				v:Clone().Parent = script.Parent;
			end
				if v:IsA("BasePart") then	
					if (v.Position - Player.Character.PrimaryPart.Position).Magnitude <= render_distance.Value then	
					v.Archivable = true;
					v:Clone().Parent = script.Parent;
					v.Color = Color3.new(1,1,1);
					v.Material = Enum.Material.Ice
				end
			end
		end
	end
end)