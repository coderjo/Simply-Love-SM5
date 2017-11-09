local pn = ...

local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
local actualDP = stats:GetActualDancePoints()
local PercentDP = stats:GetPercentDancePoints()
local percent = FormatPercentScore(PercentDP)
-- Format the Percentage string, removing the % symbol
percent = percent:gsub("%%", "")

return Def.ActorFrame{
	Name="PercentageContainer"..ToEnumShortString(pn),
	OnCommand=function(self)
		self:y( _screen.cy-26 )
		self:x( (pn == PLAYER_1 and -70) or 70 )
	end,

	-- dark background quad behind player percent score
	Def.Quad{
		InitCommand=cmd(diffuse, color("#101519"); zoomto, 160,60 )
	},

	LoadFont("_wendy white")..{
		Text=percent,
		Name="Percent",
		InitCommand=cmd(valign, 1.2; horizalign, right; zoom,0.585 ),
		OnCommand=cmd(x, 70)
	},

	LoadFont("_miso")..{
		Text="Tournament Points: ",
		Name="PointsLabel",
		InitCommand=cmd(valign, -7; horizalign, left; zoom,0.45 ),
		OnCommand=cmd(x, -24; y, -27)
	},
	Def.RollingNumbers {
		Font="_wendy white",
		InitCommand=function(self)
			self:valign(-4)
			self:horizalign(right)
			self:zoom(0.15)
			self:x(67)
			self:Load("RollingNumbersEvaluationC")
		end,
		BeginCommand=function(self)
			self:targetnumber(actualDP)
		end

	}
	-- LoadFont("_wendy white")..{
	-- 	--Text=actualDP,
	-- 	Text=99999,
	-- 	Name="Points",
	-- 	InitCommand=cmd(valign, -5; horizalign, right; zoom,0.125 ),
	-- 	OnCommand=cmd(x, 67)
	-- }
}