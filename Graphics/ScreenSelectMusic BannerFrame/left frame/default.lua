return Def.ActorFrame{

	InitCommand=cmd(Center);
		LoadActor( "ITG2" )..{
			OnCommand=cmd(x,-360;y,-1;zoomx,0.8;zoomy,0.85;);
		};

};