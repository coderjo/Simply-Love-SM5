local player = ...

local pane = Def.ActorFrame{
	Name="Pane4",
	InitCommand=function(self)
		self:visible(false)
	end,
    LoadActor("./Percentage.lua", player),
	LoadActor("./JudgementGraph.lua", player)
}
-------------------
local function isnan(n) return tostring(n) == tostring(0/0) end

local function GetAverage( t )
	local sum = 0;
	for i=1,#t do
		sum = sum + t[i];
	end
    local result = sum / #t
    
    if(isnan(result)) then return 0 end

	return result
end



local storage = SL[ToEnumShortString(player)].Stages.Stats[SL.Global.Stages.PlayedThisGame + 1]
local avg_timing_error = GetAverage(storage.timing_errors) * 1000

local t = Def.ActorFrame{
    InitCommand=cmd(zoom, 1),
    OnCommand=function(self)      
        self:y( _screen.cy - 10 )
		self:x( 15 )
    end
    
}

t[#t + 1] = LoadFont("_miso") .. 
{
    Text="AVERAGE TIMING ERROR:",
    InitCommand=cmd(NoStroke;zoom,0.833; horizalign,right; xy, 0 ,0; glowshift;effectcolor1,color("1,1,1,0"); effectcolor2,color("1,1,1,0.25")),
}

t[#t + 1] = LoadFont("_miso") .. 
{
    Text="EARLY STEPS:",
    InitCommand=cmd(NoStroke;zoom,0.833; horizalign,right; xy, 0 ,20; glowshift;effectcolor1,color("1,1,1,0"); effectcolor2,color("1,1,1,0.25")),
}

t[#t + 1] = LoadFont("_miso") .. 
{
    Text="LATE STEPS:",
    InitCommand=cmd(NoStroke;zoom,0.833; horizalign,right; xy, 0 ,40; glowshift;effectcolor1,color("1,1,1,0"); effectcolor2,color("1,1,1,0.25")),
}


t[#t+1] = LoadFont("_wendy small")..{
		InitCommand=cmd(zoom,0.4; horizalign, left),
		BeginCommand=function(self)
			self:y(0)
			self:x(5)
			self:settext( string.format("%5.2f ms", avg_timing_error) )
		end
	}

t[#t+1] = LoadFont("_wendy small")..{
		InitCommand=cmd(zoom,0.4; horizalign, left),
		BeginCommand=function(self)
			self:y(20)
			self:x(5)
			self:settext( string.format("%i", storage.early_steps) )
		end
	}

t[#t+1] = LoadFont("_wendy small")..{
		InitCommand=cmd(zoom,0.4; horizalign, left),
		BeginCommand=function(self)
			self:y(40)
			self:x(5)
			self:settext( string.format("%i", storage.late_steps) )
		end
	}
-------------------
pane[#pane + 1] = t
return pane