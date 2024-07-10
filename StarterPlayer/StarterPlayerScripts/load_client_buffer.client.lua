local run_serv = game:GetService("RunService");
local gui = game:GetService("StarterGui")
local r_storage = game:GetService("ReplicatedStorage");
local user_input_service = game:GetService("UserInputService");
local cam = game.Workspace:WaitForChild("Camera");
local c_service = game:GetService("CollectionService");
local allw = 0;
local debounce = true;
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

user_input_service.MouseIconEnabled = true;

r_storage:WaitForChild("rem_events").start.Event:Connect(function()
    for _,v in pairs(c_service:GetTagged("_soul")) do
        function on_touched(hit)
            local plr = game:GetService("Players"):GetPlayerFromCharacter(hit.Parent)
			local hum = hit.Parent:findFirstChild("Humanoid")
            if (hum ~= nil) then
                if (plr ~= nil) then
                    if debounce == true then
                        r_storage:WaitForChild("rem_events")._souls:FireServer(plr)
                        v:Destroy();
                        v.CanTouch = false
                        debounce = false
                        task.wait(1)
                        debounce = true
                    end
                end
            end
        end
        v.Touched:connect(on_touched)
    end

    for _,v in pairs(c_service:GetTagged("_orb")) do
        function on_touched(hit)
            local plr = game:GetService("Players"):GetPlayerFromCharacter(hit.Parent)
            local hum = hit.Parent:findFirstChild("Humanoid");
            if (hum ~= nil) then
                if (plr ~= nil) then
                        v:Destroy();
                        v.CanTouch = false
                    end
                end
            end
        v.Touched:connect(on_touched);
    end
end)