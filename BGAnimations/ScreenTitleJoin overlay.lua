return Def.ActorFrame{
	InitCommand=cmd(queuecommand,"Refresh"),
	--OnCommand=cmd(diffuseblink; effectperiod,1; effectcolor1,1,1,1,0; effectcolor2,1,1,1,1),
	OffCommand=cmd(visible,false),
	CoinsChangedMessageCommand=cmd(playcommand,"Refresh"),
	RefreshCommand=function(self)
		if GAMESTATE:GetCoinMode() == "CoinMode_Pay" then
			local Credits = GetCredits()
			if Credits["Credits"] < 1 then
				self:visible(false)
			else
				self:visible(true)
			end
		end
	end,

	LoadFont("titlemenu")..{
		Text=THEME:GetString("ScreenTitleJoin", "Press Start"),
		InitCommand=cmd(xy,_screen.cx, _screen.h-80; shadowlength,1 ),
		OnCommand=cmd(zoom,0.715),
	},

	LoadActor(THEME:GetPathG("_common","base start button"))..{
		InitCommand=cmd(xy,_screen.cx-5, _screen.h-80;shadowlength,0;zoom,0.6);
		JoinedCommand=cmd(linear,.2;diffusealpha,0);
	};
	LoadActor(THEME:GetPathG("_common","start button"))..{
		InitCommand=cmd(xy,_screen.cx-5, _screen.h-80;zoom,0.6;);
		OnCommand=cmd(diffuseshift;effectcolor1,color("#FFFFFF");effectcolor2,color("#858585");effectclock,"beat");
		JoinedCommand=cmd(linear,.2;diffusealpha,0);
	};
	LoadActor(THEME:GetPathG("_common","glow start button"))..{
		InitCommand=cmd(xy,_screen.cx-5, _screen.h-80;zoom,0.6;blend,Blend.Add;);
		OnCommand=cmd(diffuseshift;effectcolor1,color("#6BFF75");effectcolor2,color("#FFFFFF00");effectclock,"beat");
		JoinedCommand=cmd(linear,.2;diffusealpha,0);
	};
}
