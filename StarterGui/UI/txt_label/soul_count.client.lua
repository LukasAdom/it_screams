local r_storage = game:GetService("ReplicatedStorage");
local plr = game.Players.LocalPlayer;
local max_souls = 0;

r_storage:WaitForChild("rem_events").max.OnClientEvent:Connect(function(_max)
	max_souls = _max
end)

r_storage:WaitForChild("rem_events").update_UI.OnClientEvent:Connect(function()
	script.Parent.Text = plr:WaitForChild("_player_datastore")._souls_datastore.Value.."/"..max_souls;
	r_storage.sfx["8bit_pickup"]:Play();
end)

r_storage:WaitForChild("rem_events").update_UI_bind.Event:Connect(function()
	script.Parent.Text = plr:WaitForChild("_player_datastore")._souls_datastore.Value.."/"..max_souls;
end)