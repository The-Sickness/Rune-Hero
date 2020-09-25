local addonName, RH = ... ;

local runePowerStatusBar;
local runePowerStatusBarDark;
local runePowerStatusBarText;

local offset = 15;
local start = -85;

local runeY = {
	[1] = start,
	[2] = start-offset,
	[3] = start-offset*2,
	[4] = start-offset*3,
	[5] = start-offset*4,
	[6] = start-offset*5
}

RuneHero_Saved = {
	anchor = "BOTTOM",
	parent = "UIParent",
	rel = "BOTTOM",
	x = 0;
	y = 135;
	scale = 7;
	runeX = 65;
	scrollWidth = 260;
	blade = "runeblade";
	runebladeSelectorTitle = "Runeblade";
};

function RunePower_Event ()
end

function RuneButtonC_OnLoad (self)
	RuneFrameC_AddRune(RuneFrameC, self);
	
	self.rune = getglobal(self:GetName().."Rune");
	self.border = getglobal(self:GetName().."Border");
	self.texture = getglobal(self:GetName().."BorderTexture");
	self.bg = getglobal(self:GetName().."BG");

	self.border = getglobal(self:GetName().."Border");

	RuneButtonC_Update(self);

	self:SetScript("OnUpdate", RuneButtonC_OnUpdate);

	self:SetFrameLevel( self:GetFrameLevel() + 2*self:GetID() );
	self.border:SetFrameLevel( self:GetFrameLevel() + 1 );
end

function RuneButtonC_OnUpdate (self, elapsed)

	local start, duration, r = GetRuneCooldown(self:GetID());

	if (r) then
		self:SetPoint("TOPLEFT", "RuneFrameC", "TOPLEFT", RuneHero_Saved.runeX, runeY[self:GetID()]);
	else
		local remain = -1;
		if (duration ~= nil and start ~= nil) then
			remain = (duration - GetTime() + start) / duration;
		end
		
		if ( remain < 0) then 
			self:SetPoint("TOPLEFT", "RuneFrameC", "TOPLEFT", RuneHero_Saved.runeX, runeY[self:GetID()] );
		elseif ( remain > 1) then
			self:SetPoint("TOPLEFT", "RuneFrameC", "TOPLEFT", RuneHero_Saved.runeX + RuneHero_Saved.scrollWidth, runeY[self:GetID()] );
		else
			self:SetPoint("TOPLEFT", "RuneFrameC", "TOPLEFT", RuneHero_Saved.runeX + remain*RuneHero_Saved.scrollWidth, runeY[self:GetID()] );
		end
	end
end

function RuneButtonC_Update (self, rune)

	
	-- Disable rune frame if not a death knight.
	local _, class = UnitClass("player");
	
	if ( class ~= "DEATHKNIGHT" ) then
		self:Hide();
	end

	self.rune:SetTexture("Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Chromatic-On.tga" );
	self.rune:SetVertexColor(1,1,1);

	self.texture:SetTexture("Interface\\CHARACTERFRAME\\TotemBorder");
	self.texture:SetDesaturated(true);

	self.rune:SetWidth(20);
	self.rune:SetHeight(20);

	self.bg:SetWidth(20);	
	self.bg:SetHeight(20);

	self.border:SetWidth(39);
	self.border:SetHeight(39);	
	
end

function RuneFrameC_OnLoad (self)

	-- Disable rune frame if not a death knight.
	local _, class = UnitClass("player");
	
	if ( class ~= "DEATHKNIGHT" ) then
		self:Hide();
	end

	if (RuneHero_Saved.scrollWidth < 0) then
		RuneHero_Saved.scrollWidth = 260;
	end

	self:SetFrameLevel(1);
	
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	--self:RegisterEvent("RUNE_TYPE_UPDATE");
	--self:RegisterEvent("RUNE_REGEN_UPDATE");
	self:RegisterEvent("COMBAT_LOG_EVENT");
	self:RegisterEvent("ADDON_LOADED");

	self:SetScript("OnEvent", RuneFrameC_OnEvent);
	self:SetScript("OnUpdate", RuneFrameC_OnUpdate);
	
	self.runes = {};

end


function RuneFrameC_OnUpdate(self)

	local power = UnitPower("player");
	--local maxPower = UnitPowerMax("player");
	--local tempPower;

	runePowerStatusBar:SetWidth(power * 5.12)
	--if ( maxPower == 100 ) then
		RuneStatusBar:SetTexCoord(0, power*.01, 0, 1);
	--else - trying to figure out how to adjust RP status bar based on max RP
	--	tempPower = power * (100/maxPower) 
	--	RuneStatusBar:SetTexCoord(0, tempPower*.01, 0, 1);
	--end

	-- Hide RP number indicator if there's no RP
	if ( power > 0) then
		runePowerStatusBarText:SetText( power );
	else
		runePowerStatusBarText:SetText( nil );
	end

end

-- The event detector
function RuneFrameC_OnEvent (self, event, ...)

	-- Proc detector - old procs; needs to be updated
	if ( event == "COMBAT_LOG_EVENT" ) then
		if (arg10 == "Death Trance" and arg7 == UnitName("player"))    then
			if ( arg2 == "SPELL_AURA_APPLIED") then
				RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade-proc");
			elseif (arg2=="SPELL_AURA_REMOVED") then
				RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade");
			end
            elseif (arg10 == "Killing Machine" and arg7 == UnitName("player"))    then
			if ( arg2 == "SPELL_AURA_APPLIED") then
				RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade-proc");
			elseif (arg2=="SPELL_AURA_REMOVED") then
				RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade");
			end
		end

	-- Fires when the player enters the world, enters/leaves an instance, respawns at a GY, possibly at any loading screen as well
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		for rune in next, self.runes do
			RuneButtonC_Update(self.runes[rune], rune);
		end
		RunePower_Event();

	-- Fires when a rune changes to/from a Death rune
	elseif ( event == "RUNE_TYPE_UPDATE" ) then
		for rune in next, self.runes do
			RuneButtonC_Update(self.runes[rune], rune);
		end

	-- Fires when the runic power changes
	elseif ( event == "RUNE_POWER_UPDATE" ) then
		RunePower_Event();

	-- Fires when the rune regen time changes
	elseif ( event == "RUNE_REGEN_UPDATE" ) then
		RunePower_Event();

	-- Fires when RuneHero and the saved variables are loaded
	elseif ( event == "ADDON_LOADED"  ) then
	
		local addonName = select(1, ...)
		if ( addonName ~= "RuneHero") then return end
	
		RuneHero_LoadDefaults();
		RuneHero_SetLevels();
		
		-- Load the RuneHero interface options panel
		RH.RuneHero_LoadOptions(self);

		if (RuneHero_Saved.scrollWidth == nil or RuneHero_Saved.scrollWidth < 0) then
			RuneHero_Saved.scrollWidth = 260;
		end

		RuneFrameC:ClearAllPoints();
		RuneFrameC:SetPoint(RuneHero_Saved.anchor, RuneHero_Saved.parent,RuneHero_Saved.rel,RuneHero_Saved.x,RuneHero_Saved.y);
		RuneFrameC:SetScale(RuneHero_Saved.scale);
		RuneHero_ButtonScale(RuneHero_Saved.scale);
		
		RuneBlade:SetTexture( strconcat("Interface\\AddOns\\RuneHero\\textures\\", RuneHero_Saved.blade) );
		
		runePowerStatusBar = CreateFrame("Frame", "RuneBladeStatusBar", RuneFrameC);
		runePowerStatusBar:CreateTexture("RuneStatusBar");
		runePowerStatusBar:SetPoint("LEFT", RuneFrameC, "LEFT");
		runePowerStatusBar:SetPoint("TOPLEFT", RuneFrameC, "TOPLEFT");
		runePowerStatusBar:SetFrameLevel(2);
		RuneStatusBar:SetAllPoints();
		RuneStatusBar:SetTexture( strconcat("Interface\\AddOns\\RuneHero\\textures\\", RuneHero_Saved.blade, "-statusbar.tga") );
		
		runePowerStatusBarText = CreateFrame("StatusBar", nil, UIParent):CreateFontString("RuneBladeStatusBarText", 'OVERLAY');
		runePowerStatusBarText:ClearAllPoints();
		runePowerStatusBarText:SetFontObject( WorldMapTextFont );
		runePowerStatusBarText:SetTextColor(.6,.9,1);
		runePowerStatusBarText:SetPoint("TOP", RuneBlade, "TOP");
		runePowerStatusBarText:SetJustifyH("CENTER");
		runePowerStatusBarText:SetWidth(90);
		runePowerStatusBarText:SetHeight(40);
		
		DEFAULT_CHAT_FRAME:AddMessage("RuneHero activated! Type '/runehero' to reposition the bar.");
	
	end
end


function RuneFrameC_AddRune(runeFrameC, rune)
	tinsert(runeFrameC.runes, rune);
end

function RuneFrameC_OnDragStart()
	RuneFrameC:StartMoving();
end

function RuneFrameC_OnDragStop()
	RuneHero_Saved.anchor = "BOTTOMLEFT";
	RuneHero_Saved.parent = "UIParent";
	RuneHero_Saved.rel = "BOTTOMLEFT";
	RuneHero_Saved.x = RuneFrameC:GetLeft();
	RuneHero_Saved.y = RuneFrameC:GetBottom();
	RuneFrameC:StopMovingOrSizing();

	RuneHero_SetLevels();
end

function RuneHero_ButtonScale(scale)
	RuneButtonIndividual1C:SetScale(scale);
	RuneButtonIndividual2C:SetScale(scale);
	RuneButtonIndividual3C:SetScale(scale);
	RuneButtonIndividual4C:SetScale(scale);
	RuneButtonIndividual5C:SetScale(scale);
	RuneButtonIndividual6C:SetScale(scale);
end

function RuneHero_SetLevels()

	RuneFrameC:SetFrameLevel(1);

	RuneFrameC.runes[1]:SetFrameLevel(20);
	RuneFrameC.runes[1]:SetFrameLevel(21);

	RuneFrameC.runes[2]:SetFrameLevel(30);
	RuneFrameC.runes[2]:SetFrameLevel(31);

	RuneFrameC.runes[3]:SetFrameLevel(40);
	RuneFrameC.runes[3]:SetFrameLevel(41);

	RuneFrameC.runes[4]:SetFrameLevel(50);
	RuneFrameC.runes[4]:SetFrameLevel(51);

	RuneFrameC.runes[5]:SetFrameLevel(60);
	RuneFrameC.runes[5]:SetFrameLevel(61);

	RuneFrameC.runes[6]:SetFrameLevel(70);
	RuneFrameC.runes[6]:SetFrameLevel(71);

end

function RuneHero_LoadDefaults() 

	if (RuneHero_Saved.anchor == nil) then
		RuneHero_Saved.anchor = "BOTTOM";
	end
	if (RuneHero_Saved.parent == nil) then
		RuneHero_Saved.parent = "UIParent";
	end
	if (RuneHero_Saved.rel == nil) then
		RuneHero_Saved.rel = "BOTTOM";
	end
	if (RuneHero_Saved.x == nil) then
		RuneHero_Saved.x = 0;
	end
	if (RuneHero_Saved.y == nil) then
		RuneHero_Saved.y = 135;
	end
	if (RuneHero_Saved.scale == nil) then
		RuneHero_Saved.scale = 1;
	end
	if (RuneHero_Saved.runeX == nil) then
		RuneHero_Saved.runeX = 65;
	end
	if (RuneHero_Saved.scrollWidth == nil) then
		RuneHero_Saved.scrollWidth = 260;
	end
	if (RuneHero_Saved.blade == nil) then
		RuneHero_Saved.blade = "runeblade";
	end
	
end


function RuneHero_SlashCommand(cmd)

-- Called twice so that it actually opens to the right menu
-- Would only open to the main Options page with one call
InterfaceOptionsFrame_OpenToCategory(RH.rhOptions.name);
InterfaceOptionsFrame_OpenToCategory(RH.rhOptions.name);
--[[
	if( cmd == 'bottom' ) then
		RuneFrameC:ClearAllPoints();
		RuneFrameC:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 135/RuneFrameC:GetScale() );

		RuneHero_Saved.anchor = "BOTTOM";
		RuneHero_Saved.parent = "UIParent";
		RuneHero_Saved.rel = "BOTTOM";
		RuneHero_Saved.x = 0;
		RuneHero_Saved.y = 135/RuneFrameC:GetScale();

	elseif ( cmd == 'player' ) then
		RuneFrameC:ClearAllPoints();
		RuneFrameC:SetPoint("TOPLEFT", "PlayerFrame", "BOTTOMLEFT", 0 ,0);

		RuneHero_Saved.anchor = "TOPLEFT";
		RuneHero_Saved.parent = "PlayerFrame";
		RuneHero_Saved.rel = "BOTTOMLEFT";
		RuneHero_Saved.x = 0;
		RuneHero_Saved.y = 0;

	elseif (cmd == 'lock' ) then
		RuneButtonIndividual1C:SetMovable(false);
		RuneButtonIndividual1C:RegisterForDrag(nil);
		RuneButtonIndividual1C:SetScript('OnDragStart', nil );
		RuneFrameC:SetClampedToScreen(true);
		DEFAULT_CHAT_FRAME:AddMessage(" RuneHero locked.");

	elseif ( cmd == 'unlock' ) then
		RuneButtonIndividual1C:SetMovable(true);
		RuneButtonIndividual1C:RegisterForDrag('LeftButton');
		RuneButtonIndividual1C:SetScript('OnDragStart', RuneFrameC_OnDragStart );
		RuneButtonIndividual1C:SetScript('OnDragStop', RuneFrameC_OnDragStop );
		RuneFrameC:SetClampedToScreen(true);
		DEFAULT_CHAT_FRAME:AddMessage(" RuneHero unlocked. Click on the top rune icon to drag.");
		
	elseif ( cmd == 'bloodknight' ) then
		RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\bloodknight");
		RuneStatusBar:SetTexture("Interface\\AddOns\\RuneHero\\textures\\bloodknight-statusbar");
		RuneHero_Saved.blade = 'bloodknight';
		
	elseif ( cmd == 'runeblade' ) then
		RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade");
		RuneStatusBar:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade-statusbar");
		RuneHero_Saved.blade = 'runeblade';
	
	elseif ( cmd == 'ashbringer' ) then
		RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\ashbringer");
		RuneStatusBar:SetTexture("Interface\\AddOns\\RuneHero\\textures\\ashbringer-statusbar");
		RuneHero_Saved.blade = 'ashbringer';
		
	elseif ( cmd == 'runeblade2' ) then
		RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade2");
		RuneStatusBar:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade2-statusbar");
		RuneHero_Saved.blade = 'runeblade2';

	elseif (strsub(cmd,1,4) == 'size') then
		local scaleParam = tonumber(strsub(cmd,6));
		if ( scaleParam == nil ) then
			scaleParam = -1;
		else
			scaleParam = scaleParam/7;
		end
		if ( scaleParam <= 10/7 and scaleParam >= 1/7 ) then
			local rawleft =   (  RuneFrameC:GetLeft() + RuneFrameC:GetWidth() *.5)*RuneFrameC:GetScale();
			local rawbottom = (RuneFrameC:GetBottom() + RuneFrameC:GetHeight()*.5)*RuneFrameC:GetScale();
			local postleft =   (rawleft   - scaleParam*RuneFrameC:GetWidth() *.5)*(1/scaleParam);
			local postbottom = (rawbottom - scaleParam*RuneFrameC:GetHeight()*.5)*(1/scaleParam);

			RuneFrameC:ClearAllPoints();
			RuneFrameC:SetScale(scaleParam);
			RuneFrameC:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", postleft, postbottom);

			RuneHero_Saved.anchor = "BOTTOMLEFT";
			RuneHero_Saved.parent = "UIParent";
			RuneHero_Saved.rel = "BOTTOMLEFT";
			RuneHero_Saved.x = postleft;
			RuneHero_Saved.y = postbottom;
			RuneHero_Saved.scale = scaleParam;
			RuneHero_ButtonScale(scaleParam);
		else
			DEFAULT_CHAT_FRAME:AddMessage(" RuneHero: Size must be between 1-10 (Default: 7).");
		end
	elseif ( strsub(cmd,1,6) == 'offset') then
		local offset = tonumber(strsub(cmd,8));
		if (offset ~= nil) then
			RuneHero_Saved.runeX = offset;
		else 
			DEFAULT_CHAT_FRAME:AddMessage(" RuneHero: Offset must be a number.");
		end
	elseif ( strsub(cmd,1,5) == 'width') then
		local width = tonumber(strsub(cmd,7));
		if (width ~= nil) then
			RuneHero_Saved.scrollWidth = width;
		else 
			DEFAULT_CHAT_FRAME:AddMessage(" RuneHero: Width must be a number.");
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(" RuneHero Commands: 'bottom', 'player', 'lock', 'unlock', 'size <1-10>', 'width <#>', 'offset <#>' .");
		DEFAULT_CHAT_FRAME:AddMessage(" To change runeblades: 'runeblade', 'runeblade2', 'ashbringer', 'bloodknight'.");
	end	
	]]
end



-- Slash Command Support
SLASH_RUNEHERO1 = "/runehero";
SLASH_RUNEHERO2 = "/rh";
SlashCmdList["RUNEHERO"] = RuneHero_SlashCommand;