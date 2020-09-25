local addonName, RH = ... ;

--local rhOptions = {}; -- RuneHero main interface options panel

-- Initialize Interface options panel
function RH.RuneHero_LoadOptions (self)

	RH.rhOptions = CreateFrame( "Frame", "rhOptions", UIParent );
	rhOptions.name = "RuneHero";
	InterfaceOptions_AddCategory( rhOptions );
	
	-- Create the title text inside the frame
	local titleString = rhOptions:CreateFontString("titleFrame");
	titleString:SetFontObject("GameFontNormalLarge");
	titleString:SetText("RuneHero");
	titleString:SetPoint("TOPLEFT", 10, -15);
	
	-- Button to lock/unlock runehero
	local lockButton = CreateFrame( "CheckButton", "lockButton", rhOptions, "OptionsCheckButtonTemplate");
	lockButton.text = _G["lockButton".."Text"];
	lockButton.text:SetText("Lock RuneHero");
	lockButton:SetPoint("BOTTOMLEFT", titleString, 0, -40);
	lockButton:SetScript("OnClick", RuneHero_Lock );
	lockButton:SetChecked(true);
	
	-- Drop down menu to select runeblade graphic
	local runebladeSelector = CreateFrame( "Frame", "runebladeSelector", rhOptions, "UIDropDownMenuTemplate");
	runebladeSelector:SetPoint("BOTTOMLEFT", lockButton, 0, -40);
	runebladeSelector.text = _G["runebladeSelector".."Text"];
	runebladeSelector.text:SetText( RuneHero_Saved.runebladeSelectorTitle );
	local info = {};
	runebladeSelector.initialize = function(self, level) 
		if not level then return end
		wipe (info);
		if level == 1 then
			info.text = "Runeblade";
			info.checked = "Runeblade" == RuneHero_Saved.runebladeSelectorTitle, true;
			info.func = function()
				RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade");
				RuneStatusBar:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade-statusbar");
				RuneHero_Saved.blade = 'runeblade';
				RuneHero_Saved.runebladeSelectorTitle = "Runeblade";
				runebladeSelector.text:SetText( RuneHero_Saved.runebladeSelectorTitle );
			end
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Frostmourne";
			info.checked = "Frostmourne" == RuneHero_Saved.runebladeSelectorTitle, true;
			info.func = function()
				RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade2");
				RuneStatusBar:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade2-statusbar");
				RuneHero_Saved.blade = 'runeblade2';
				RuneHero_Saved.runebladeSelectorTitle = "Frostmourne";
				runebladeSelector.text:SetText( RuneHero_Saved.runebladeSelectorTitle );
			end
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Blood Knight";
			info.checked = "Blood Knight" == RuneHero_Saved.runebladeSelectorTitle, true;
			info.func = function()
				RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\bloodknight");
				RuneStatusBar:SetTexture("Interface\\AddOns\\RuneHero\\textures\\bloodknight-statusbar");
				RuneHero_Saved.blade = 'bloodknight';
				RuneHero_Saved.runebladeSelectorTitle = "Blood Knight";
				runebladeSelector.text:SetText( RuneHero_Saved.runebladeSelectorTitle );
			end
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Ashbringer";
			info.checked = "Ashbringer" == RuneHero_Saved.runebladeSelectorTitle, true;
			info.func = function()
				RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\ashbringer");
				RuneStatusBar:SetTexture("Interface\\AddOns\\RuneHero\\textures\\ashbringer-statusbar");
				RuneHero_Saved.blade = 'ashbringer';
				RuneHero_Saved.runebladeSelectorTitle = "Ashbringer";
				runebladeSelector.text:SetText( RuneHero_Saved.runebladeSelectorTitle );
			end
			UIDropDownMenu_AddButton(info, level);
		end
	end
	
	
	-- Sliding bar for runeblade size
	local sizeSlider = CreateFrame( "Slider", "sizeSlider", rhOptions, "OptionsSliderTemplate");
	-- Edit box underneath the size slider
	local editbox = CreateFrame("EditBox", "$parentEditBox", sizeSlider, "InputBoxTemplate")
	sizeSlider:SetPoint("BOTTOMLEFT", runebladeSelector, 0, -40);
	sizeSlider.textLow = _G["sizeSlider".."Low"];
	sizeSlider.textHigh = _G["sizeSlider".."High"];
	sizeSlider.text = _G["sizeSlider".."Text"];
	sizeSlider.textLow:SetText( "1" );
	sizeSlider.textHigh:SetText( "10" );
	sizeSlider.text:SetText( "Scale" );
	sizeSlider:SetMinMaxValues(1,10);
	sizeSlider:SetValueStep( 1 );
	sizeSlider:SetObeyStepOnDrag( true );
	sizeSlider:SetValue( RuneHero_Saved.scale * 7 );
	editbox:SetSize(50,30)
    editbox:ClearAllPoints()
    editbox:SetPoint("CENTER", sizeSlider, "CENTER", 0, -20)
    editbox:SetText( tostring(RuneHero_Saved.scale * 7) )
    editbox:SetAutoFocus(false)
	sizeSlider:SetScript("OnValueChanged", function(self, value)
		RuneHero_Resize(value);
		editbox:SetText(value);
	end);	
	editbox:SetScript("OnEnterPressed", function(self)
      local val = self:GetText()
      if tonumber(val) then
		if tonumber(val) >= 1 then if tonumber(val) <= 10 then
			self:GetParent():SetValue(val) end
		end
      end
    end)
	
end

function RuneHero_Lock()
	if (lockButton:GetChecked()) then
	RuneButtonIndividual1C:SetMovable(false);
	RuneButtonIndividual1C:RegisterForDrag(nil);
	RuneButtonIndividual1C:SetScript('OnDragStart', nil );
	RuneFrameC:SetClampedToScreen(true);
	DEFAULT_CHAT_FRAME:AddMessage(" RuneHero locked.");
	else
	RuneButtonIndividual1C:SetMovable(true);
	RuneButtonIndividual1C:RegisterForDrag('LeftButton');
	RuneButtonIndividual1C:SetScript('OnDragStart', RuneFrameC_OnDragStart );
	RuneButtonIndividual1C:SetScript('OnDragStop', RuneFrameC_OnDragStop );
	RuneFrameC:SetClampedToScreen(true);
	DEFAULT_CHAT_FRAME:AddMessage(" RuneHero unlocked. Click on the top rune icon to drag.");
	end
end

function RuneHero_Unlock()
	RuneButtonIndividual1C:SetMovable(true);
	RuneButtonIndividual1C:RegisterForDrag('LeftButton');
	RuneButtonIndividual1C:SetScript('OnDragStart', RuneFrameC_OnDragStart );
	RuneButtonIndividual1C:SetScript('OnDragStop', RuneFrameC_OnDragStop );
	RuneFrameC:SetClampedToScreen(true);
	DEFAULT_CHAT_FRAME:AddMessage(" RuneHero unlocked. Click on the top rune icon to drag.");
end

function RuneHero_Resize(scaleParam)
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
end
