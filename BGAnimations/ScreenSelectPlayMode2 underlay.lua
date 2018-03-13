local single = Def.ActorFrame{
    InitCommand=cmd(x,60;y,-50;zoom,1.4);
    GainFocusCommand=cmd(wag;effectmagnitude,0,10,0);
    LoseFocusCommand=cmd(stopeffect);
    LoadActor(THEME:GetPathG("_platform","home single"))..{
        InitCommand=cmd(rotationx,30);
    };
};



local double = Def.ActorFrame{
    InitCommand=cmd(x,60;y,-50;zoom,1.2;);
    GainFocusCommand=cmd(wag;effectmagnitude,0,10,0);
    LoseFocusCommand=cmd(stopeffect);
    LoadActor(THEME:GetPathG("_platform","home single"))..{
        InitCommand=cmd(x,-55;rotationx,30);
    };
    LoadActor(THEME:GetPathG("_platform","home single"))..{
        InitCommand=cmd(x,55;rotationx,30);
    };
};

local versus = 
Def.ActorFrame {
    Def.ActorFrame{
        InitCommand=cmd(x,-30;y,-50);
        GainFocusCommand=cmd(wag;effectmagnitude,0,10,0);
        LoseFocusCommand=cmd(stopeffect);
        LoadActor(THEME:GetPathG("_platform","home single"))..{
            InitCommand=cmd(zoom,1.2;rotationx,30);
        };
    },
    Def.ActorFrame{
        InitCommand=cmd(x,150;y,-50);
        GainFocusCommand=cmd(wag;effectmagnitude,0,10,0);
        LoseFocusCommand=cmd(stopeffect);
        LoadActor(THEME:GetPathG("_platform","home single"))..{
            InitCommand=cmd(zoom,1.2;rotationx,30);
        };
    },
}
SM(SL.Global.Gamestate.Style)
if SL.Global.Gamestate.Style == "single" then return single
elseif SL.Global.Gamestate.Style == "versus" then return versus
elseif SL.Global.Gamestate.Style == "double" then return double