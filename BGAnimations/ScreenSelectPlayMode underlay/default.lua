local choices, choice_actors = {}, {}
local TopScreen = nil
-- give this a value now, before the TopScreen has been prepared and we can fetch its name
-- we'll reassign it appropriately below, once the TopScreen is available
local ScreenName = "ScreenSelectPlayMode"

local cursor = {
	h = 40,
	index = 0,
	-- the width of the cursor will be clamped to exist between these two values
	min_w = 90, max_w = 170,
}

local Update = function(af, delta)
	local index = TopScreen:GetSelectionIndex( GAMESTATE:GetMasterPlayerNumber() )
	if index ~= cursor.index then
		cursor.index = index
	end
end

local t = Def.ActorFrame{
	InitCommand=cmd(SetUpdateFunction, Update),

	OnCommand=function(self)
		-- Get the Topscreen and its name, now that that TopScreen itself actually exists
		TopScreen = SCREENMAN:GetTopScreen()
		ScreenName = TopScreen:GetName()

		-- now that we have the TopScreen's name, get the single string containing this
		-- screen's choices from Metrics.ini, and split it on commas; store those choices
		-- in the choices table, and do similarly with actors associated with those choices
		for choice in THEME:GetMetric(ScreenName, "ChoiceNames"):gmatch('([^,]+)') do
			choices[#choices+1] = choice
			choice_actors[#choice_actors+1] = TopScreen:GetChild("IconChoice"..choice)
		end

		self:queuecommand("Update")
	end,
	OffCommand=function(self)
		if ScreenName == "ScreenSelectPlayMode" then
			-- set the GameMode now; we'll use it throughout the theme
			-- to set certain Gameplay settings and determine which screen comes next
			SL.Global.GameMode = choices[cursor.index+1]

			-- now that a GameMode has been selected, set related preferences
			SetGameModePreferences()
			-- and reload the theme's Metrics
			THEME:ReloadMetrics()
		end
	end,

	-- description TODO - Figure out description text animation
	Def.BitmapText{
		Font="titlemenu",
		InitCommand=function(self)
			self:zoom(0.55):halign(0):valign(0):xy(-130,-60)
		end,
		UpdateCommand=function(self)
			self:settext( THEME:GetString("ScreenSelectPlayMode", choices[cursor.index+1] .. "Description") )
		end,
		OffCommand=function(self) self:sleep(0.4):linear(0.2):diffusealpha(0) end
	},

	-- cursor to highlight the current choice
	Def.ActorFrame{
		Name="Cursor",
		OnCommand=function(self)
			if ScreenName == "ScreenSelectPlayMode" then
				cursor.index = (FindInTable(ThemePrefs.Get("DefaultGameMode"), choices) or 1) - 1
			end
		end,
	},

	--Character
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+13;z,-100;zoom,1.3);
		LoadActor("char")..{
			InitCommand=cmd(zoom,0.55;glow,color("1,1,1,0");diffusealpha,0;linear,0.3;glow,color("1,1,1,1");sleep,0.001;diffusealpha,1;linear,0.3;glow,color("1,1,1,0"));
			MadeChoiceP1MessageCommand=cmd(playcommand,"GoOff");
			MadeChoiceP2MessageCommand=cmd(playcommand,"GoOff");
			GoOffCommand=cmd(sleep,.2;linear,0.3;diffusealpha,0;);
		};
	},
	--Selection arrows
	LoadActor(THEME:GetPathB("_shared","underlay arrows"))..{
		InitCommand=cmd(x,184);
	};
}

return t