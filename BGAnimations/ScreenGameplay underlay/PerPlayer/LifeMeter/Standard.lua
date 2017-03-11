local player = ...

local meterFillLength = 280
local meterFillHeight = 25
local meterXOffset = _screen.cx - WideScale(238, 288) - 100

if player == PLAYER_2 then
	meterXOffset = _screen.cx + WideScale(238, 288) + 100
end

local newBPS, oldBPS

local meter = Def.ActorFrame{

	InitCommand=cmd(horizalign, left),
	BeginCommand=function(self)
		if SL[ToEnumShortString(player)].ActiveModifiers.HideLifebar then
			self:visible(false)
		end
	end,
	OnCommand=cmd(y, 280),

	-- frame
	Border(meterFillHeight+4, meterFillLength+4, 2)..{
		OnCommand=function(self)
			self:x(meterXOffset)
		end
	},

	-- // start meter proper //
	Def.Quad{
		Name="MeterFillBG";
		InitCommand=cmd(zoomto,meterFillLength,meterFillHeight; diffuse,Color.Black; horizalign, left; rotationz, 270;),
		OnCommand=function(self)
			self:diffusealpha(0.7)
			self:x(meterXOffset)
			self:y(meterFillLength/2)
		end
	},

	Def.Quad{
		Name="MeterFill";
		InitCommand=cmd(zoomto,0,meterFillHeight; diffuse,PlayerColor(player); horizalign, left; rotationz, 270;),
		OnCommand=cmd(x, meterXOffset; y, meterFillLength/2),

		-- check state of mind
		HealthStateChangedMessageCommand=function(self,params)
			if(params.PlayerNumber == player) then
				if(params.HealthState == 'HealthState_Hot') then
					--self:diffuse(color("1,1,1,1"))
				else
					self:diffuse(PlayerColor(player))
				end
			end
		end,

		-- check life (LifeMeterBar)
		LifeChangedMessageCommand=function(self,params)
			if(params.Player == player) then
				local life = params.LifeMeter:GetLife() * (meterFillLength)
				self:finishtweening()
				self:smooth(0.3)
				self:zoomx( life )
			end
		end,
	},

	LoadActor("swoosh.png")..{
		Name="MeterSwoosh",
		InitCommand=cmd(zoomto,meterFillLength,meterFillHeight; diffusealpha,0.5; horizalign, left; rotationz, 270),
		OnCommand=function(self)
			self:x(meterXOffset);
			self:y(meterFillLength/2)
			self:customtexturerect(0,0,1,1);
			--texcoordvelocity is handled by the Update function below
		end,
		HealthStateChangedMessageCommand=function(self,params)
			if(params.PlayerNumber == player) then
				if(params.HealthState == 'HealthState_Hot') then
					self:diffusealpha(0.8)
				else
					self:diffusealpha(0.2)
				end
			end
		end,
		LifeChangedMessageCommand=function(self,params)
			if(params.Player == player) then
				local life = params.LifeMeter:GetLife() * (meterFillLength)
				self:finishtweening()
				self:smooth(0.3)
				self:zoomto( life, meterFillHeight )
			end
		end
	}
}



local function Update(self)

	local swoosh = self:GetChild("MeterSwoosh")

	newBPS = GAMESTATE:GetSongBPS()
	local move = (newBPS*-1)/2
	if GAMESTATE:GetSongFreeze() then move = 0 end
	if swoosh then swoosh:texcoordvelocity(move,0) end

	oldBPS = newBPS
end

meter.InitCommand=cmd(SetUpdateFunction,Update)

return meter

-- copyright 2008-2012 AJ Kelly/freem.
-- do not use this code in your own themes without my permission.