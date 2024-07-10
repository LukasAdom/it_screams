local r_storage = game:GetService("ReplicatedStorage");
local bob = game.Workspace.Bob;
local bob_hum = bob:WaitForChild("Humanoid");
local walk_bob = bob:WaitForChild("walk_bob");
local walk_bob_track = bob_hum:LoadAnimation(walk_bob);
local allw = false;
local allw2 = false;

walk_bob_track.Priority = Enum.AnimationPriority.Action;

_G._server_objs = 1493;
_G._soul_trigger = 5;
_G._max = 20;

game.Players.PlayerAdded:Connect(function(plr)
    r_storage.rem_events.max:FireClient(plr, _G._max);
end)

r_storage.rem_events.allw.OnServerEvent:Connect(function()
    allw = true;
    allw2 = true;
end)

r_storage.rem_events.update_server.OnServerEvent:Connect(function(plr)

    repeat task.wait() until #game:WaitForChild("Workspace"):GetChildren() == _G._server_objs

    if plr:WaitForChild("_player_datastore")._deaths_datastore.Value >= 0 then
        if plr:WaitForChild("_player_datastore")._souls_datastore.Value == _G._max then
            if allw2 == true then
                r_storage.rem_events.win:FireClient(plr);
                r_storage.rem_events.win_bind:Fire(plr);
                allw2 = false;
            end
        end
    end
    if plr:WaitForChild("_player_datastore")._deaths_datastore.Value == 0 then
        if plr:WaitForChild("_player_datastore")._souls_datastore.Value >= _G._soul_trigger then
            if allw == true then
                r_storage.rem_events.bob_active:FireClient(plr);
                allw = false
            end
        end
    end
    if plr:WaitForChild("_player_datastore")._deaths_datastore.Value == 1 then
        if plr:WaitForChild("_player_datastore")._souls_datastore.Value >= _G._soul_trigger + 5 then
            if allw == true then
                r_storage.rem_events.bob_active:FireClient(plr);
                allw = false
            end
        end
    end
    if plr:WaitForChild("_player_datastore")._deaths_datastore.Value == 2 then
        if plr:WaitForChild("_player_datastore")._souls_datastore.Value >= _G._soul_trigger + 10 then
            if allw == true then
                r_storage.rem_events.bob_active:FireClient(plr);
                allw = false
            end
        end
    end
    if plr:WaitForChild("_player_datastore")._deaths_datastore.Value == 3 then
        if plr:WaitForChild("_player_datastore")._souls_datastore.Value >=
            _G._soul_trigger + 11 then
            if allw == true then
                r_storage.rem_events.bob_active:FireClient(plr);
                allw = false
            end
        end
    end
    if plr:WaitForChild("_player_datastore")._deaths_datastore.Value >= 4 then
        if plr:WaitForChild("_player_datastore")._souls_datastore.Value >= _G._soul_trigger + 12 then
            if allw == true then
                r_storage.rem_events.bob_active:FireClient(plr);
                allw = false
            end
        end
    end
end)

--[[ finds all the nodes from the player to node (G) and endpoint to node (H)
 and then the code proceeds to sort the G value from lowest-highest and the H value from highest-lowest ]] --

--[[local nodes = workspace.nodes:GetChildren();

local function node_find()
    for i,k in pairs(nodes) do
        table.insert(_nodes,{part = k, G = (k.Position - bob.HumanoidRootPart.Position).Magnitude});
    end

    for i,k in pairs(nodes) do
       table.insert(_target,{part = k, H = (k.Position - workspace.target.Position).Magnitude}); 
    end
    table.sort(_nodes, function(a,b)
        return a.G < b.G;
    end)
    table.sort(_target,function(a,b)
        return a.H > b.H;        
    end)

    for i,v in pairs(_nodes) do
        table.insert(F_node,_nodes[i])
    end
    for i,v in pairs(_target) do
        table.insert(F_node,_target[i])
    end
end
node_find();]]

--[[ Organizes the G and H values for easier calculations by splitting an array into two part
 and reorganizing the G value to be next to the H value and iterating those same values by i++ ]] --

--[[local function path_find()
    local flow = false
    local F = {}
    local _F = {}

    for k = 0,node_amt-1 do
        for i,v in pairs(F_node) do
            if i <= node_amt then
                if flow == false then
                    table.insert(F,F_node[i+k]["G"]);
                    flow = true;
                end
            end
            if i >= node_amt+1 then
                if flow == true then
                    table.insert(F,F_node[i+k]["H"]);
                    flow = false;
                end
            end
        end
    end

    for i = 1,node_amt*2,2 do
        table.insert(_F,math.round(F[i]+F[i+1]))
    end

    for i = 1,node_amt do
        _nodes[i].G = _F[i];
    end

    table.sort(_nodes, function(a,b)
        return a.G < b.G
    end)
end
path_find();

print(_nodes)

local target_draw_line = {}
local bob_draw_line = {}

for i=1,node_amt-1 do
    local cent = (_nodes[i]["part"].Position + _nodes[i+1]["part"].Position)/2
    local arrow = Instance.new("Part");
        arrow.Anchored = true
        arrow.Parent = workspace
        arrow.CanCollide = false
        arrow.Name = "line"
        arrow.CFrame = CFrame.lookAt(cent,_nodes[i]["part"].Position)
        arrow.Size = Vector3.new(1,0.5,(_nodes[i]["part"].Position - _nodes[i+1]["part"].Position).Magnitude)
end

for i=1,node_amt-1 do
    if i==node_amt then
        local cent = (_nodes[i]["part"].Position + bob.HumanoidRootPart.Position)/2
        local arrow = Instance.new("Part");
        arrow.Anchored = true
        arrow.Parent = workspace
        arrow.CanCollide = false
        arrow.Name = "line_bob"
        arrow.CFrame = CFrame.lookAt(cent,_nodes[i]["part"].Position)
        arrow.Size = Vector3.new(1,0.5,(_nodes[i]["part"].Position - bob.HumanoidRootPart.Position).Magnitude)
    end
    if i==node_amt+1 then
        local cent = (_nodes[i]["part"].Position + workspace.target.Position)/2
        local arrow = Instance.new("Part");
        arrow.Anchored = true
        arrow.Parent = workspace
        arrow.CanCollide = false
        arrow.Name = "line_bob"
        arrow.CFrame = CFrame.lookAt(cent,_nodes[i]["part"].Position)
        arrow.Size = Vector3.new(1,0.5,(_nodes[i]["part"].Position - workspace.target.Position).Magnitude)
    end
end]]

--[[for i,k in pairs(nodes) do
    table.insert(bob_draw_line,(k.Position - bob.HumanoidRootPart.Position).Magnitude)
    table.sort(bob_draw_line,function(a,b)
        return a < b
    end)
    print(bob_draw_line)
end]]
