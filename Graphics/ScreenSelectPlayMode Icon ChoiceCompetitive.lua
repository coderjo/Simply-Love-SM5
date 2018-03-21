-- Standard
return Def.ActorFrame{
	LoadFont("titlemenu")..{
		Text=ScreenString("CompetitiveDescription");
		InitCommand=cmd(x,SCREEN_CENTER_X+75;y,SCREEN_CENTER_Y+138;zoom,.68;maxwidth,840;horizalign,center;shadowlength,0);
		GainFocusCommand=cmd(visible,true;finishtweening;cropright,1;linear,0.5;cropright,0);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(linear,0.3;diffusealpha,0);
	};
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_LEFT+65;y,SCREEN_CENTER_Y-135 + 90;horizalign,left);
		LoadActor(THEME:GetPathG("_join","icons/standard_icon"))..{
			GainFocusCommand=cmd(accelerate,0.1;diffuse,color("#FFFFFF");x,SCREEN_LEFT+65);
			LoseFocusCommand=cmd(finishtweening;decelerate,0.1;diffuse,color("#636363");x,SCREEN_LEFT+46);
			OffFocusCommand=cmd(accelerate,0.4;addx,-SCREEN_WIDTH*.5);
		};
		LoadActor(THEME:GetPathG("_join","icons/gameglow"))..{
			InitCommand=cmd(blend,Blend.Add);
			GainFocusCommand=cmd(accelerate,0.1;diffusealpha,1;x,SCREEN_LEFT+65;sleep,.07;linear,.2;diffusealpha,0);
			LoseFocusCommand=cmd(finishtweening;decelerate,0.1;x,SCREEN_LEFT+46;diffusealpha,0);
			OffFocusCommand=cmd(accelerate,0.4;addx,-SCREEN_WIDTH*.5);
		};
	};
};