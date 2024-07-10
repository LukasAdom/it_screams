local user_input_service = game:GetService("UserInputService");
script.Parent.Parent.menu.Enabled = true;

local t_service = game:GetService("TweenService")
local r_storage = game:GetService("ReplicatedStorage");

local ost_1_sfx = r_storage:WaitForChild("sfx").ost_1;
local ost_1_sfx_client = ost_1_sfx:Clone()
local ost_2_sfx = r_storage:WaitForChild("sfx").ost_2;
local ost_2_sfx_client = ost_2_sfx:Clone();

local play_button = script.Parent.ImageLabel.Frame.play;
local support_button = script.Parent.ImageLabel.Frame.support;

local plr = game.Players.LocalPlayer;
local char = plr.Character or plr.CharacterAdded:Wait();

local controls = require(plr.PlayerScripts.PlayerModule):GetControls();
local cam = game.Workspace:WaitForChild("Camera");

local _for_API = r_storage:WaitForChild("for_API");
local _pathfind_service = require(_for_API:WaitForChild("AI"));

_G.first = true

r_storage:WaitForChild("rem_events").reset_datastore:FireServer(plr);
r_storage:WaitForChild("rem_events").allw:FireServer(plr);

local coreCall
do
    local MAX_RETRIES = 8

    local StarterGui = game:GetService('StarterGui')
    local RunService = game:GetService('RunService')

    function coreCall(method, ...)
        local result = {}
        for retries = 1, MAX_RETRIES do
            result = {pcall(StarterGui[method], StarterGui, ...)}
            if result[1] then break end
            RunService.Stepped:Wait()
        end
        return unpack(result)
    end
end

coreCall('SetCore', 'ResetButtonCallback', false)

controls:Disable();

script.Parent.Parent.UI.Enabled = false;
script.Parent.Parent._border.Enabled = false;

ost_1_sfx_client.Parent = plr;
ost_1_sfx_client.Volume = 0.5;
ost_1_sfx_client:Play();

ost_2_sfx_client.Parent = plr;
ost_2_sfx_client.Volume = 0.1;
ost_2_sfx_client:Stop();

local tween_info = TweenInfo.new(5, Enum.EasingStyle.Sine,
                                 Enum.EasingDirection.In)
local tween = t_service:Create(ost_1_sfx_client, tween_info,
                               {Volume = ost_1_sfx_client.Volume * 2})

play_button.Activated:Connect(function()

    script.Parent.Click:Play()
    script.Parent.ImageLabel.sup.Visible = false;
    script.Parent.ImageLabel.Frame.Visible = false;
    script.Parent.ImageLabel.load.Visible = true;

    plr.PlayerGui.rbx_shaders.shader_display.ImageColor3 = Color3.new(1, 1, 1);

    for i, v in pairs(game.Workspace:GetChildren()) do
        if v.Name == "Orb" or v.Name == "Orb_min" then
            v:Destroy();
            v.CanTouch = false
        end
    end

    plr.CameraMinZoomDistance = 0.5
    char.HumanoidRootPart.CFrame = workspace.plr_spawner.plr_spawn.CFrame;
    plr.CameraMode = Enum.CameraMode.LockFirstPerson;
    user_input_service.MouseIconEnabled = false;

    r_storage:WaitForChild("rem_events").reset_datastore:FireServer(plr);
    r_storage:WaitForChild("rem_events").allw:FireServer(plr);

    task.wait(2);

    plr.PlayerGui.UI.Enabled = true;
    plr.PlayerGui.UI.txt_label.Visible = true;
    plr.PlayerGui.UI.txt_label_time.Visible = true;
    plr.PlayerGui._border.Enabled = true;

    workspace.Bob.HumanoidRootPart.CFrame =
        workspace.menu_spawn:GetChildren()[math.random(1, 4)].CFrame;

    r_storage:WaitForChild("rem_events").update_UI_bind:Fire();
    for i, k in pairs(r_storage:WaitForChild("objs"):GetChildren()) do
        k:Clone().Parent = workspace
    end

    task.wait(1);

    script.Parent.Parent.menu.Enabled = false;

    r_storage:WaitForChild("rem_events").bob_no_longer:Fire();

    r_storage:WaitForChild("rem_events").start:Fire();
    controls:Enable();
    tween:Play()
end)

r_storage:WaitForChild("rem_events").menu.Event:Connect(function()

    controls:Disable();

    plr.CameraMode = Enum.CameraMode.Classic;
    plr.CameraMinZoomDistance = 1
    cam.CameraType = Enum.CameraType.Custom;
    user_input_service.MouseIconEnabled = true;

    script.Parent.Parent.UI.Enabled = false;
    script.Parent.Parent._border.Enabled = false;
    script.Parent.Parent.menu.Enabled = true;

    ost_1_sfx_client.Parent = plr;
    ost_1_sfx_client.Volume = 0.5;
    ost_1_sfx_client:Play();

    ost_2_sfx_client.Parent = plr;
    ost_2_sfx_client.Volume = 0.2;
    ost_2_sfx_client:Stop();

    script.Parent.ImageLabel.Frame.Visible = true;
    script.Parent.ImageLabel.load.Visible = false;

end)

r_storage:WaitForChild("rem_events").win_menu.Event:Connect(function()

    controls:Disable();

    plr.CameraMode = Enum.CameraMode.Classic;
    plr.CameraMinZoomDistance = 1
    cam.CameraType = Enum.CameraType.Custom;
    user_input_service.MouseIconEnabled = true;

    script.Parent.Parent.UI.Enabled = false;
    script.Parent.Parent._border.Enabled = false;
    script.Parent.Parent.menu.Enabled = true;

    ost_1_sfx_client.Parent = plr;
    ost_1_sfx_client.Volume = 0.5;
    ost_1_sfx_client:Play();

    ost_2_sfx_client.Parent = plr;
    ost_2_sfx_client.Volume = 0.2;
    ost_2_sfx_client:Stop();

    plr.Character.HumanoidRootPart.CFrame =
        workspace.menu_spawn:GetChildren()[math.random(1, 4)].CFrame;
    plr.PlayerGui.rbx_shaders.shader_display.ImageColor3 = Color3.new(1, 1, 1)

    script.Parent.ImageLabel.Frame.Visible = false;
    script.Parent.ImageLabel.win.Visible = true;
    script.Parent.ImageLabel.load.Visible = false;

    task.wait(5)

    script.Parent.ImageLabel.Frame.Visible = true;
    script.Parent.ImageLabel.win.Visible = false;
    script.Parent.ImageLabel.load.Visible = false;

end)

play_button.MouseEnter:Connect(function()
    play_button.TextColor3 = Color3.fromRGB(244, 255, 39)
    script.Parent.Hover:Play()
end)

play_button.MouseLeave:Connect(function()
    play_button.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

support_button.MouseEnter:Connect(function()
    support_button.TextColor3 = Color3.fromRGB(244, 255, 39)
    script.Parent.Hover:Play()
end)

support_button.MouseLeave:Connect(function()
    support_button.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

support_button.Activated:Connect(function()
    script.Parent.ImageLabel.Frame.Visible = false;
    script.Parent.ImageLabel.sup.Visible = true;
end)

script.Parent.ImageLabel.sup.X.Activated:Connect(function()
    script.Parent.ImageLabel.Frame.Visible = true;
    script.Parent.ImageLabel.sup.Visible = false;
end)

while true do
    task.wait(2.5)
    if plr.PlayerGui.menu.Enabled == false then
        r_storage:WaitForChild("rem_events").update_server:FireServer(plr);
    end
end
