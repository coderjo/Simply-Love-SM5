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
		InitCommand=cmd(valign, 0.6; horizalign, right; zoom,0.585 ),
		OnCommand=cmd(x, 70)
	},

	LoadFont("_wendy white")..{
		Text="EX: ",
		Name="PointsLabel",
		InitCommand=cmd(valign, -3.4; horizalign, left; zoom,0.1 ),
		OnCommand=function(self)
			self:x(15)
			self:diffusealpha( SL.Global.GameMode == "StomperZ" and 1 or 0 )
		end
	},
	Def.RollingNumbers {
		Font="_wendy white",
		InitCommand=function(self)
			self:diffusealpha( SL.Global.GameMode == "StomperZ" and 1 or 0 )
			self:valign(-2.1)
			self:horizalign(right)
			self:zoom(0.15)
			self:x(67)
			self:Load("RollingNumbersEvaluationC")
		end,
		BeginCommand=function(self)
			self:targetnumber(actualDP)
		end

	}
}
