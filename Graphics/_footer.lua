-- return Def.Quad{
-- 	Name="Footer",
-- 	InitCommand=function(self)
-- 		self:draworder(90)
-- 		self:zoomto(_screen.w, 32):vertalign(bottom):y(32)
-- 		self:diffuse(0.65,0.65,0.65,1)
-- 	end
-- }

return LoadActor("footer_gfx")..{
	InitCommand=cmd(draworder,-5;CenterX;zoomx,1;zoomy,0.80);
	--OnCommand=cmd();
};