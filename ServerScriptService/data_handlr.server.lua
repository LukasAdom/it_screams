local datastore_API = require(game.ServerScriptService:WaitForChild("DataStore2"));
local r_storage = game:GetService("ReplicatedStorage");
local c_service = game:GetService("CollectionService");

local souls_req = 20;

local debounce = true;


game.Players.PlayerAdded:Connect(function(plr)
	local _souls_req_data = datastore_API("_souls", plr);
	local _death_req_data = datastore_API("_deaths", plr);
    local _wins_req_data = datastore_API("_wins", plr)
    local _total_souls_req_data = datastore_API("_totalsouls", plr)
    local _total_deaths_req_data = datastore_API("_totaldeaths", plr)

    local plr_data = Instance.new("Folder",plr);
    plr_data.Name = "_player_datastore";

    local souls_data = Instance.new("IntValue",plr_data);
	souls_data.Name = "_souls_datastore";
	
	local deaths_data = Instance.new("IntValue",plr_data);
	deaths_data.Name = "_deaths_datastore"

    local wins_data = Instance.new("IntValue", plr_data)
    wins_data.Name = "_wins_datastore"

    local totalsouls_data = Instance.new("IntValue", plr_data)
    totalsouls_data.Name = "_totalsouls_datastore"

    local totaldeaths_data = Instance.new("IntValue", plr_data)
    totaldeaths_data.Name = "_totaldeaths_datastore"

    local function souls_req_data_update(data_req_update)
        souls_data.Value = _souls_req_data:Get(data_req_update);
	end
	
	local function deaths_req_data_update(data_req_update)
		deaths_data.Value = _death_req_data:Get(data_req_update);
	end

    local function wins_req_data_update(data_req_update)
        wins_data.Value = _wins_req_data:Get(data_req_update);
    end

    local function total_souls_req_data_update(data_req_update)
        totalsouls_data.Value = _total_souls_req_data:Get(data_req_update);
    end

    local function total_deaths_req_data_update(data_req_update)
        totaldeaths_data.Value = _total_deaths_req_data:Get(data_req_update);
    end
	

	souls_req_data_update(0);
	deaths_req_data_update(0);
    wins_req_data_update(0);
    total_souls_req_data_update(0);
    total_deaths_req_data_update(0);


	_souls_req_data:OnUpdate(souls_req_data_update);
	_death_req_data:OnUpdate(deaths_req_data_update);
    _wins_req_data:OnUpdate(wins_req_data_update);
    _total_souls_req_data:OnUpdate(total_souls_req_data_update);
    _total_deaths_req_data:OnUpdate(total_deaths_req_data_update);

	_souls_req_data:Set(0);
	_death_req_data:Set(0);

    
 
end)

r_storage.rem_events.hit.OnServerEvent:Connect(function(plr)
	local _death_req_data = datastore_API("_deaths", plr);
	local _total_deaths_req_data = datastore_API("_totaldeaths", plr)
	_death_req_data:Increment(1);
	_total_deaths_req_data:Increment(1);
end)

r_storage.rem_events.reset_datastore.OnServerEvent:Connect(function(plr)
	local _souls_req_data = datastore_API("_souls", plr);
	_souls_req_data:Set(0);
end)

r_storage.rem_events._souls.OnServerEvent:Connect(function(plr)
	local _souls_req_data = datastore_API("_souls", plr);
	local _total_souls_req_data = datastore_API("_totalsouls", plr)
	_souls_req_data:Increment(1);
	_total_souls_req_data:Increment(1);
	r_storage:WaitForChild("rem_events").update_UI:FireClient(plr);
end)

r_storage.rem_events.win_bind.Event:Connect(function(plr)
	local _wins_req_data = datastore_API("_wins", plr)
	_wins_req_data:Increment(1);
end)

--[[for _,v in pairs(c_service:GetTagged("_soul")) do
    function on_touched(hit)
        local plr = game:GetService("Players"):GetPlayerFromCharacter(hit.Parent)
        local hum = hit.Parent:findFirstChild("Humanoid")
        if (hum ~= nil) then
            local local_plr = hum.Parent.Name
			if (local_plr ~= nil) then
				local _souls_req_data_1 = datastore_API("_souls", plr);
                local _total_souls_req_data_1 = datastore_API("_totalsouls", plr);
                local _wins_req_data_1 = datastore_API("_wins", plr)

                if plr:WaitForChild("_player_datastore")._souls_datastore.Value == souls_req then
                        _wins_req_data_1:Increment(1);
                    end

                if debounce == true then
                    _souls_req_data_1:Increment(1);
                    _total_souls_req_data_1:Increment(1);
                    r_storage:WaitForChild("rem_events").update_UI:FireClient(plr);
                    debounce = false
                    task.wait(2)
                    debounce = true
                end
            end
        end
    end
    v.Touched:connect(on_touched)
end]]