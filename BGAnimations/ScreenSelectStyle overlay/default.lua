return LoadActor("../_Headers/_SelectStyle")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-140;y,SCREEN_CENTER_Y-200;draworder,-5;);
		OnCommand=cmd(zoomx,0;zoomy,3;bounceend,0.2;zoom,0.5);
};
