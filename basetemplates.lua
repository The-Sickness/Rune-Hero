-- so you wanna change a template ? 
-- change the RHtotal templates +1 
-- copy the RHsword[1] 
-- paste it on the end 
-- change the number to match the total 
-- edit away and have fun!!!!!


-- how many templates in this file ? 
RHTotal = 5; -- swords
RHTotRunes = 3; -- runes
RHsword = {}; -- do not delete me 
RHRunes = {}; -- do not delete me 
-- start of the templates - copy from here 
RHsword[1] = {
	name = "Frostmourne", -- whats it called ? 
	main = "Interface\\AddOns\\RuneHero\\textures\\runeblade2", -- what does it look like ? 
	overlay = "Interface\\AddOns\\RuneHero\\textures\\runeblade2-statusbar", -- how does it change ? 
	proc = "Interface\\AddOns\\RuneHero\\textures\\runeblade2-proc", -- Glow on special proc ? 
	l = 150; -- how many pixels across is no power 
	r = 245; -- from l - how many pixel = full power
	x = 10; -- where should the text be
	y = -50; -- where should the text be
	b1x = 105; 	-- Blood 1
	b1y = -70;  	-- Blood 1
	b1d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	b1l = 300; -- which length
	b2x = 105; 	-- Blood 2
	b2y = -90;  	-- Blood 2
	b2d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	b2l = 300; -- which length
	u1x = 105; 	-- Unholy 1
	u1y = -110;		-- Unholy 1
	u1d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	u1l = 300; -- which length
	u2x = 105;	-- Unholy 2
	u2y = -130;		-- Unholy 2
	u2d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	u2l = 300; -- which length
	f1x = 105;	-- Frost 1
	f1y = -150;		-- Frost 1
	f1d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	f1l = 300; -- which length
	f2x = 105;	-- Frost 2
	f2y = -170;		-- Frost 2
	f2d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	f2l = 300; -- which length
  scrollWidth = 360; -- how far do the runes have to travel ?   scrollWidth = 360; -- how far do the runes have to travel ? 
};
-- end of template - to here 
RHsword[2] = {
	name = "RuneHero Original",
	main = "Interface\\AddOns\\RuneHero\\textures\\runeblade",
	overlay = "Interface\\AddOns\\RuneHero\\textures\\runeblade-statusbar",
	proc = "Interface\\AddOns\\RuneHero\\textures\\runeblade-proc",
	l = 35;
	r = 440;
	x = 10; -- where should the text be
	y = -50; -- where should the text be
	b1x = 105; 	-- Blood 1
	b1y = -70;  	-- Blood 1
	b1d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	b1l = 300; -- which length
	b2x = 105; 	-- Blood 2
	b2y = -90;  	-- Blood 2
	b2d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	b2l = 300; -- which length
	u1x = 105; 	-- Unholy 1
	u1y = -110;		-- Unholy 1
	u1d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	u1l = 300; -- which length
	u2x = 105;	-- Unholy 2
	u2y = -130;		-- Unholy 2
	u2d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	u2l = 300; -- which length
	f1x = 105;	-- Frost 1
	f1y = -150;		-- Frost 1
	f1d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	f1l = 300; -- which length
	f2x = 105;	-- Frost 2
	f2y = -170;		-- Frost 2
	f2d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	f2l = 300; -- which length
  scrollWidth = 360; -- how far do the runes have to travel ?   scrollWidth = 300; -- how far do the runes have to travel ? 
};
RHsword[3] = {
	name = "No Sword",
	main = "",
	overlay = "",
	proc = "",
	l = 0;
	r = 1;
	x = 10; -- where should the text be
	y = -50; -- where should the text be
	b1x = 0; 	-- Blood 1
	b1y = 0;  	-- Blood 1
	b1d = '4'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	b1l = 50; -- which length
	b2x = 24; 	-- Blood 2
	b2y = 0;  	-- Blood 2
	b2d = '4'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	b2l = 50; -- which length
	u1x = 96; 	-- Unholy 1
	u1y = 0;		-- Unholy 1
	u1d = '4'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	u1l = 50; -- which length
	u2x = 120;	-- Unholy 2
	u2y = 0;		-- Unholy 2
	u2d = '4'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	u2l = 50; -- which length
	f1x = 48;	-- Frost 1
	f1y = 0;		-- Frost 1
	f1d = '4'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	f1l = 50; -- which length
	f2x = 72;	-- Frost 2
	f2y = 0;		-- Frost 2
	f2d = '4'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	f2l = 50; -- which length
  scrollWidth = 360; -- how far do the runes have to travel ? 	scrollWidth = 100; -- how far do the runes have to travel ? 

};
RHsword[4] = {
	name = "Corrupted Ashbringer", -- whats it called ? 
	main = "Interface\\AddOns\\RuneHero\\textures\\ashbringer", -- what does it look like ? 
	overlay = "Interface\\AddOns\\RuneHero\\textures\\ashbringer-statusbar", -- how does it change ? 
	proc = "Interface\\AddOns\\RuneHero\\textures\\ashbringer-proc", -- Glow on special proc ? 
	l = 181; -- how many pixels across is no power 
	r = 331; -- from l - how many pixel = full power
	x = 210; -- where should the text be
	y = -180; -- where should the text be
	b1x = 70; 	-- Blood 1
	b1y = -108;  	-- Blood 1
	b1d = '3'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	b1l = 100; -- which length
	b2x = 70; 	-- Blood 2
	b2y = -132;  	-- Blood 2
	b2d = '4'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	b2l = 100; -- which length
	u1x = 130; 	-- Unholy 1
	u1y = -108;		-- Unholy 1
	u1d = '3'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	u1l = 100; -- which length
	u2x = 130;	-- Unholy 2
	u2y = -132;		-- Unholy 2
	u2d = '4'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	u2l = 100; -- which length
	f1x = 100;	-- Frost 1
	f1y = -108;		-- Frost 1
	f1d = '3'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	f1l = 100; -- which length
	f2x = 100;	-- Frost 2
	f2y = -132;		-- Frost 2
	f2d = '4'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	f2l = 100; -- which length
  scrollWidth = 360; -- how far do the runes have to travel ? 
};
RHsword[5] = {
	name = "Blood Knight", -- whats it called ? 
	main = "Interface\\AddOns\\RuneHero\\textures\\bloodknight", -- what does it look like ? 
	overlay = "Interface\\AddOns\\RuneHero\\textures\\bloodknight-statusbar", -- how does it change ? 
	proc = "Interface\\AddOns\\RuneHero\\textures\\bloodknight-proc", -- Glow on special proc ? 
	l = 160; -- how many pixels across is no power 
	r = 314; -- from l - how many pixel = full power
	x = 10; -- where should the text be
	y = -50; -- where should the text be
	b1x = 257; 	-- Blood 1
	b1y = -120;  	-- Blood 1
	b1d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	b1l = 0; -- which length
	b2x = 284; 	-- Blood 2
	b2y = -120;  	-- Blood 2
	b2d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	b2l = 0; -- which length
	u1x = 356; 	-- Unholy 1
	u1y = -120;		-- Unholy 1
	u1d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	u1l = 0; -- which length
	u2x = 370;	-- Unholy 2
	u2y = -120;		-- Unholy 2
	u2d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	u2l = 0; -- which length
	f1x = 312;	-- Frost 1
	f1y = -120;		-- Frost 1
	f1d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	f1l = 0; -- which length
	f2x = 335;	-- Frost 2
	f2y = -120;		-- Frost 2
	f2d = '1'; -- which direction ? 1 = right, 2 = left, 3 = up, 4 = down
	f2l = 0; -- which length
  scrollWidth = 360; -- how far do the runes have to travel ? 
};

-- add swords here 

RHRunes[1] = {
	name = "Standard Wow",
	blood1 = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood",
	blood2 = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood",
	frost1 = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Frost",
	frost2 = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Frost",
	unholy1 = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Unholy",
	unholy2 = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Unholy",
	death1 = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death",
	death2 = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death",
	death3 = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death",
	death4 = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death",
	death5 = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death",
	death6 = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death",
	ring = "Interface\\AddOns\\RuneHero\\textures\\Ring-test.tga",
	rings = false,
}

RHRunes[2] = {
	name = "RuneHero v1.0.0",
	blood1 = "Interface\\AddOns\\RuneHero\\textures\\Bloodv1.tga",
	blood2 = "Interface\\AddOns\\RuneHero\\textures\\Bloodv1.tga",
	frost1 = "Interface\\AddOns\\RuneHero\\textures\\Frostv1.tga",
	frost2 = "Interface\\AddOns\\RuneHero\\textures\\Frostv1.tga",
	unholy1 = "Interface\\AddOns\\RuneHero\\textures\\Unholyv1.tga",
	unholy2 = "Interface\\AddOns\\RuneHero\\textures\\Unholyv1.tga",
	death1 = "Interface\\AddOns\\RuneHero\\textures\\Deathv1.tga",
	death2 = "Interface\\AddOns\\RuneHero\\textures\\Deathv1.tga",
	death3 = "Interface\\AddOns\\RuneHero\\textures\\Deathv1.tga",
	death4 = "Interface\\AddOns\\RuneHero\\textures\\Deathv1.tga",
	death5 = "Interface\\AddOns\\RuneHero\\textures\\Deathv1.tga",
	death6 = "Interface\\AddOns\\RuneHero\\textures\\Deathv1.tga",
	ring = "Interface\\AddOns\\RuneHero\\textures\\Ring-test.tga",
	rings = false,
}

RHRunes[3] = {
	name = "Blood Knight Blade",
	blood1 = "Interface\\AddOns\\RuneHero\\textures\\bkblood1.tga",
	blood2 = "Interface\\AddOns\\RuneHero\\textures\\bkblood2.tga",
	frost1 = "Interface\\AddOns\\RuneHero\\textures\\bkfrost1.tga",
	frost2 = "Interface\\AddOns\\RuneHero\\textures\\bkfrost2.tga",
	unholy1 = "Interface\\AddOns\\RuneHero\\textures\\bkunholy1.tga",
	unholy2 = "Interface\\AddOns\\RuneHero\\textures\\bkunholy2.tga",
	death1 = "Interface\\AddOns\\RuneHero\\textures\\bkdeath1.tga",
	death2 = "Interface\\AddOns\\RuneHero\\textures\\bkdeath2.tga",
	death3 = "Interface\\AddOns\\RuneHero\\textures\\bkdeath3.tga",
	death4 = "Interface\\AddOns\\RuneHero\\textures\\bkdeath4.tga",
	death5 = "Interface\\AddOns\\RuneHero\\textures\\bkdeath5.tga",
	death6 = "Interface\\AddOns\\RuneHero\\textures\\bkdeath6.tga",
	ring = "",
	rings = false,
}