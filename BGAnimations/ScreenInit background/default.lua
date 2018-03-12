return Def.ActorFrame{

	LoadActor("roxor")..{
		InitCommand=cmd(Center;FullScreen);
	};

	Def.Quad {
		InitCommand=cmd(FullScreen; diffuse, Color.Black; diffusealpha,0; sleep,5;linear,0.2; diffusealpha,1),
	}
};