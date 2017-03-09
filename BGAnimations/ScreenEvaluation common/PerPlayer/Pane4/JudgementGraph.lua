local pn = ...

local storage = SL[ToEnumShortString(pn)].Stages.Stats[SL.Global.Stages.PlayedThisGame + 1]

local GraphWidth = 300
local GraphHeight = (140/2) - 6

local QuadHeight = {
	W1 = 2,
	W2 = 2,
	W3 = 2,
	W4 = 2,
	W5 = 2,
	Miss = GraphHeight,
};

local QuadY = {
	W1 = 1,
	W2 = 2,
	W3 = 4,
	W4 = 6,
	W5 = 8,
	Miss = 0,
};

local mode = ""
if SL.Global.GameMode == "StomperZ" then mode = "StomperZ" end
if SL.Global.GameMode == "ECFA" then mode = "ECFA" end

local TNSNames = {
	THEME:GetString("TapNoteScore" .. mode, "W1"),
	THEME:GetString("TapNoteScore" .. mode, "W2"),
	THEME:GetString("TapNoteScore" .. mode, "W3"),
	THEME:GetString("TapNoteScore" .. mode, "W4"),
	THEME:GetString("TapNoteScore" .. mode, "W5"),
	THEME:GetString("TapNoteScore" .. mode, "Miss")
}

local ITGColors = {
	W1 = color("#21CCE8"),	-- blue
	W2 = color("#e29c18"),	-- gold
	W3 = color("#66c955"),	-- green
	W4 = color("#9e00f7"),	-- purple
	W5 = color("#ffa64d"),  -- orange
	Miss =color("#ff0000")	-- red
}



local TotalTaps = #storage.total_judgements
local QuadWidth = GraphWidth / TotalTaps
local QuadsPosition = GraphWidth / TotalTaps



local t = Def.ActorFrame{
	Def.Quad{
		Name="Background",
		InitCommand=function(self)
			self:diffuse(Color.Black)
			self:diffusealpha(0.7)
			self:x( 0 )
			self:y( _screen.cy+80 )
			self:zoomto(GraphWidth, GraphHeight)
		end
	},
	Def.Quad{
		Name="MiddleLine",
		InitCommand=function(self)
			self:x( 0 )
			self:y( _screen.cy+80 )
			self:diffusealpha(0.4)
			self:zoomto(GraphWidth, 1)
		end
	},
};

for i=1, #storage.total_judgements do 
	local note = storage.total_judgements[i]

	local tns = ToEnumShortString(note.TapNoteScore)
	local hns = note.HoldNoteScore
	local track = note.FirstTrack
	local offset = note.TapNoteOffset

	if tns ~= "HitMine" and tns ~= "AvoidMine" then
		if not hns then 
			local noteTex = Def.Quad{
				InitCommand=function(self)
					self:x(-GraphWidth/2)
					self:y( (_screen.cy+80) - GraphHeight/2 )
					self:addx(i * QuadsPosition)
					
					if offset > 0 then
						self:addy((GraphHeight/2) - (QuadY[tns] * (track + 1)))
					elseif offset < 0 then
						self:addy((GraphHeight/2) + (QuadY[tns] * (track + 1)))
					end

					self:diffuse(ITGColors[tns])

					if tns == "Miss" then
						self:y((_screen.cy+80) - GraphHeight/2):addy(QuadHeight["Miss"]/2):setsize(1,QuadHeight["Miss"])
						self:diffusealpha(0.5)
					end
				end
			}

			t[#t + 1] = noteTex
			
		end
	end
end



return t