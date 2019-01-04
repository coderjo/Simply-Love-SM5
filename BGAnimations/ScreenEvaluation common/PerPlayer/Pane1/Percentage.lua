local pn = ...

local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
local actualDP = stats:GetActualDancePoints()
local PercentDP = stats:GetPercentDancePoints()
local percent = FormatPercentScore(PercentDP)

local num_W1 = stats:GetTapNoteScores("TapNoteScore_W1")
local bad_scores = stats:GetTapNoteScores("TapNoteScore_Miss") + 
				   stats:GetTapNoteScores("TapNoteScore_HitMine") +
				   stats:GetHoldNoteScores("HoldNoteScore_LetGo")

local ecfa_points = num_W1 - (bad_scores * 0.5)

local ecfa_plus_points = string.format("%.2f", stats:GetPercentageOfTaps("TapNoteScore_W1") * 100)

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
		Name="TournamentPointsLabel",
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

	},

	LoadFont("_wendy white")..{
		Text="ECFA: ",
		Name="ECFAPointsLabel",
		InitCommand=cmd(valign, -3.4; horizalign, left; zoom,0.1 ),
		OnCommand=function(self)
			self:x(7)
			self:diffusealpha( SL.Global.GameMode == "Competitive" and 1 or 0 )
		end
	},
	LoadFont("_wendy white") .. {
		Text=ecfa_points,
		Name="ECFAPointsValue",
		InitCommand=function(self)
			self:diffusealpha( SL.Global.GameMode == "Competitive" and 1 or 0 )
			self:valign(-3.4)
			self:horizalign(right)
			self:zoom(0.1)
			self:x(67)
		end,
	},
	LoadFont("_wendy white")..{
		Text="ECFA: ",
		Name="ECFAPointsLabel",
		InitCommand=cmd(valign, -3.4; horizalign, left; zoom,0.1 ),
		OnCommand=function(self)
			self:x(7)
			self:diffusealpha( SL.Global.GameMode == "ECFA" and 1 or 0 )
		end
	},
	LoadFont("_wendy white") .. {
		Text=ecfa_plus_points,
		Name="ECFAPointsValue",
		InitCommand=function(self)
			self:diffusealpha( SL.Global.GameMode == "ECFA" and 1 or 0 )
			self:valign(-3.4)
			self:horizalign(right)
			self:zoom(0.1)
			self:x(67)
		end,
	},
}
