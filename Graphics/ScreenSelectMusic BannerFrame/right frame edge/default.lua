return Def.ActorFrame{

	InitCommand=cmd(Center);
		LoadActor( "ITG2" )..{
			OnCommand=cmd(x,-90;horizalign,left;zoomx,0.8;zoomy,0.85);
		};

};