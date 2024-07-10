local plr = game.Players.LocalPlayer
local mps = game:GetService("MarketplaceService")

script.Parent.Activated:Connect(function()
	mps:PromptProductPurchase(plr,1852270526)
end)