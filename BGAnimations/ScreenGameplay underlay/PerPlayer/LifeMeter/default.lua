if SL.Global.GameMode ~= "Casual" then
	local player = ...

	--Always use the competitive lifebar
	local lifemeter = LoadActor("Competitive.lua", player)
	
	--if SL.Global.GameMode == "StomperZ" or SL.Global.GameMode == "ECFA" then
	--	lifemeter = LoadActor("StomperZ.lua", player)
	--else
	--	lifemeter = LoadActor("Competitive.lua", player)
	--end
	
	return lifemeter
end