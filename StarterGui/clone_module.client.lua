local plr = game.Players.LocalPlayer;
local t_service = game:GetService("TweenService");
_G.dead = false;
local r_storage = game:GetService("ReplicatedStorage");
local bob = r_storage:WaitForChild("Bob");
local bob_client = bob:Clone();
local death_sfx = r_storage:WaitForChild("sfx").death
local scream_sfx = r_storage:WaitForChild("sfx").run
local _for_API = r_storage:WaitForChild("for_API");
local _pathfind_service = require(_for_API:WaitForChild("AI"));
local death_sfx_client = death_sfx:Clone();
local scream_sfx_client = scream_sfx:Clone();
local cam = game.Workspace:WaitForChild("Camera");
local ost_1_sfx = r_storage:WaitForChild("sfx").ost_1;
local ost_1_sfx_client = ost_1_sfx:Clone();

local bob_dead = false
local allw = true;

r_storage:WaitForChild("rem_events").bob_active.OnClientEvent:Connect(function()

    allw = true

    local tween_info = TweenInfo.new(10, Enum.EasingStyle.Linear,
                                     Enum.EasingDirection.In)
    local tween = t_service:Create(plr.ost_2, tween_info,
                                   {Volume = plr.ost_2.Volume * 20})
    local tween2 = t_service:Create(plr.PlayerGui.rbx_shaders.shader_display,
                                    tween_info, {
        ImageColor3 = Color3.fromRGB(159, 159, 159)
    })

    plr.ost_1:Stop();
    plr.ost_2:Play();

    tween:Play();
    tween2:Play();

    task.wait(math.random(5, 30));

    Instance.new("Animator").Parent = bob_client.Humanoid

    local spawners = game.Workspace.spawner:GetChildren();

    if bob_dead == false then
        workspace.Bob:Destroy();
        bob_dead = true
    end

    bob_client.Parent = workspace;
    bob_client.HumanoidRootPart.CFrame = spawners[math.random(1, 5)].CFrame

    scream_sfx_client.Parent = bob_client
    death_sfx_client.Parent = plr

    local walk_bob = bob_client:WaitForChild("walk_bob");
    local walk_bob_track = bob_client.Humanoid:LoadAnimation(walk_bob);

    walk_bob_track:Play();
    scream_sfx_client:Stop();
    if plr:WaitForChild("_player_datastore")._deaths_datastore.Value == 0 then
        bob_client.Humanoid.WalkSpeed = 55
    else
        bob_client.Humanoid.WalkSpeed = 20
    end

    _pathfind_service.SmartPathfind(bob_client, plr, true, {
        StandardPathfindSettings = {
            AgentRadius = 7,
            AgentHeight = 13,
            AgentCanJump = false,
            AgentCanClimb = false
        },

        Visualize = false,
        Tracking = true
    });

    --[[local function on_touched(hit)
        local hum = hit.Parent:findFirstChild("Humanoid");
        if (hum ~= nil) then
            local local_plr = hum.Parent.Name;
            if (local_plr ~= nil) then
                print("1");
            end
        end    
    end
    bob_client.Humanoid.Touched:connect(on_touched);]]
end)

bob_client.Humanoid.Touched:connect(function(hit)
    if hit and game.Players:GetPlayerFromCharacter(hit.Parent) then
        local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
        if allw == true then
            local controls =
                require(plr.PlayerScripts.PlayerModule):GetControls();

            controls:Disable();

            _pathfind_service.Stop(bob_client);
            bob_client.Humanoid.Animator:Destroy();

            plr.PlayerGui.UI.txt_label.Visible = false;
            plr.PlayerGui.UI.txt_label_time.Visible = false;

            scream_sfx_client:Stop();
            death_sfx_client:Play();

            cam.CameraType = Enum.CameraType.Fixed;

            _G.dead = true;

            plr.ost_1:Stop();
            plr.ost_2:Stop();

            plr.PlayerGui.rbx_shaders.shader_display.ImageColor3 = Color3.new(1,
                                                                              0,
                                                                              0);
            plr.PlayerGui.UI.hand.ImageColor3 = Color3.fromRGB(161, 0, 0)

            r_storage:WaitForChild("rem_events").hit:FireServer(plr);

            _pathfind_service.Stop(bob_client);

            allw = false

            task.wait(3)
            hit.Parent.HumanoidRootPart.CFrame =
                workspace.menu_spawn:GetChildren()[math.random(1, 4)].CFrame;

            plr.PlayerGui.UI.hand.ImageColor3 = Color3.fromRGB(217, 217, 217);
            plr.PlayerGui.rbx_shaders.shader_display.ImageColor3 = Color3.new(1,
                                                                              1,
                                                                              1)

            r_storage.rem_events.menu:Fire();
            _pathfind_service.Stop(bob_client);

            _G.dead = false;

        end
    end
end)

r_storage:WaitForChild("rem_events").win.OnClientEvent:Connect(function()

        local controls = require(plr.PlayerScripts.PlayerModule):GetControls();
        controls:Disable();

        plr.PlayerGui.UI.txt_label.Visible = false;
        plr.PlayerGui.UI.txt_label_time.Visible = false;

        scream_sfx_client:Stop();
        death_sfx_client:Stop();

        cam.CameraType = Enum.CameraType.Fixed;

        plr.ost_1:Stop();
        plr.ost_2:Stop();

        if bob_client.Humanoid:FindFirstChild("Animator") ~= nil then
            bob_client.Humanoid.Animator:Destroy();
            _pathfind_service.Stop(bob_client);
        end

        plr.Character.HumanoidRootPart.CFrame = workspace.menu_spawn:GetChildren()[math.random(1, 4)].CFrame;

        plr.PlayerGui.UI.hand.ImageColor3 = Color3.fromRGB(217, 217, 217);
        plr.PlayerGui.rbx_shaders.shader_display.ImageColor3 = Color3.new(1, 1, 1)

        r_storage.rem_events.win_menu:Fire();

        _G.dead = false;

end)

r_storage:WaitForChild("rem_events").bob_no_longer.Event:Connect(function()

    if workspace.Bob.Humanoid:FindFirstChild("Animator") ~= nil then
        workspace.Bob.Humanoid.Animator:Destroy();
    end

    _pathfind_service.Stop(workspace.Bob);

    workspace.Bob.HumanoidRootPart.CFrame = workspace.menu_spawn:GetChildren()[math.random(1, 4)].CFrame;

end)

while task.wait(1) do
    for i, v in pairs(bob_client:GetChildren()) do
        if v.Name == "Waypoints" then v:Destroy(); end
    end
end
