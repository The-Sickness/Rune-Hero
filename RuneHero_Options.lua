local addonName, RH = ...;

-- Initialize Interface options panel
function RH.RuneHero_LoadOptions()
    local frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    local category, layout = Settings.RegisterCanvasLayoutCategory(frame, "RuneHero")

    local titleString = frame:CreateFontString("titleFrame")
    titleString:SetFontObject("GameFontNormalLarge")
    titleString:SetText("RuneHero")
    titleString:SetPoint("TOPLEFT", 10, -15)

    -- Lock/Unlock checkbox
    local lockButton = CreateFrame("CheckButton", "lockButton", frame, "UICheckButtonTemplate")
    lockButton:SetPoint("BOTTOMLEFT", titleString, 0, -40)
    lockButton:SetScript("OnClick", function()
        RuneHero_Lock(lockButton:GetChecked())
    end)
    lockButton:SetChecked(true)
    _G["lockButtonText"]:SetText("Lock RuneHero")

    -- Dropdown menu for runeblade selection
    local runebladeSelector = CreateFrame("Frame", "runebladeSelector", frame, "UIDropDownMenuTemplate")
    runebladeSelector:SetPoint("BOTTOMLEFT", lockButton, 0, -40)
    runebladeSelector.text = _G["runebladeSelector".."Text"]
    runebladeSelector.text:SetText(RuneHero_Saved.runebladeSelectorTitle)
    local info = {}
    runebladeSelector.initialize = function(self, level) 
        if not level then return end
        wipe(info)
        if level == 1 then
            local options = {
                {text = "Runeblade", value = "runeblade"},
                {text = "Frostmourne", value = "runeblade2"},
                {text = "Blood Knight", value = "bloodknight"},
                {text = "Ashbringer", value = "ashbringer"}
            }
            for _, option in ipairs(options) do
                info.text = option.text
                info.checked = option.text == RuneHero_Saved.runebladeSelectorTitle
                info.func = function()
                    RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\" .. option.value)
                    RuneStatusBar:SetTexture("Interface\\AddOns\\RuneHero\\textures\\" .. option.value .. "-statusbar")
                    RuneHero_Saved.blade = option.value
                    RuneHero_Saved.runebladeSelectorTitle = option.text
                    runebladeSelector.text:SetText(RuneHero_Saved.runebladeSelectorTitle)
                end
                UIDropDownMenu_AddButton(info, level)
            end
        end
    end

    -- Size slider
    local sizeSlider = CreateFrame("Slider", "sizeSlider", frame, "OptionsSliderTemplate")
    sizeSlider:SetPoint("BOTTOMLEFT", runebladeSelector, 0, -40)
    sizeSlider.textLow = _G["sizeSlider".."Low"]
    sizeSlider.textHigh = _G["sizeSlider".."High"]
    sizeSlider.text = _G["sizeSlider".."Text"]
    sizeSlider.textLow:SetText("1")
    sizeSlider.textHigh:SetText("10")
    sizeSlider.text:SetText("Scale")
    sizeSlider:SetMinMaxValues(1, 10)
    sizeSlider:SetValueStep(1)
    sizeSlider:SetObeyStepOnDrag(true)
    sizeSlider:SetValue(RuneHero_Saved.scale * 4)

    -- Edit box under the size slider
    local editbox = CreateFrame("EditBox", "$parentEditBox", sizeSlider, "InputBoxTemplate")
    editbox:SetSize(50, 30)
    editbox:SetPoint("CENTER", sizeSlider, "CENTER", 0, -20)
    editbox:SetText(tostring(RuneHero_Saved.scale * 4))
    editbox:SetAutoFocus(false)

    sizeSlider:SetScript("OnValueChanged", function(self, value)
        RuneHero_Resize(value)
        editbox:SetText(tostring(value))
    end)

    editbox:SetScript("OnEnterPressed", function(self)
        local val = tonumber(self:GetText())
        if val and val >= 1 and val <= 10 then
            sizeSlider:SetValue(val)
        end
        self:ClearFocus()
    end)

    -- Adding anchor points
    layout:AddAnchorPoint("TOPLEFT", 10, -10)
    layout:AddAnchorPoint("BOTTOMRIGHT", -10, 10)

    -- Required functions for frame
    frame.OnCommit = function()
        -- Implementation for saving settings
    end

    frame.OnDefault = function()
        -- Implementation for resetting to default settings
    end

    frame.OnRefresh = function()
        -- Implementation for refreshing the settings
    end

    -- Register the category
    Settings.RegisterAddOnCategory(category)
end

-- Function to lock/unlock the UI elements
function RuneHero_Lock(locked)
    if locked then
        RuneFrameC:SetClampedToScreen(true)
        DEFAULT_CHAT_FRAME:AddMessage("RuneHero locked.")
    else
        RuneFrameC:SetClampedToScreen(true)
        DEFAULT_CHAT_FRAME:AddMessage("RuneHero unlocked. Click on the top rune icon to drag.")
    end
end

function RuneHero_Resize(scaleParam)
    if scaleParam == nil then
        scaleParam = -1
    else
        scaleParam = scaleParam / 7
    end
    if scaleParam <= 10 / 7 and scaleParam >= 1 / 7 then
        local rawleft = (RuneFrameC:GetLeft() + RuneFrameC:GetWidth() * .5) * RuneFrameC:GetScale()
        local rawbottom = (RuneFrameC:GetBottom() + RuneFrameC:GetHeight() * .5) * RuneFrameC:GetScale()
        local postleft = (rawleft - scaleParam * RuneFrameC:GetWidth() * .5) * (1 / scaleParam)
        local postbottom = (rawbottom - scaleParam * RuneFrameC:GetHeight() * .5) * (1 / scaleParam)

        RuneFrameC:ClearAllPoints()
        RuneFrameC:SetScale(scaleParam)
        RuneFrameC:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", postleft, postbottom)

        RuneHero_Saved.anchor = "BOTTOMLEFT"
        RuneHero_Saved.parent = "UIParent"
        RuneHero_Saved.rel = "BOTTOMLEFT"
        RuneHero_Saved.x = postleft
        RuneHero_Saved.y = postbottom
        RuneHero_Saved.scale = scaleParam
       
    else
        DEFAULT_CHAT_FRAME:AddMessage("RuneHero: Size must be between 1-10 (Default: 4).")
    end
end

-- Ensure the slash command triggers the options panel
SLASH_RUNEHERO1 = "/runehero"
SLASH_RUNEHERO2 = "/rh"
SlashCmdList["RUNEHERO"] = function()
    Settings.OpenToCategory("RuneHero")
end
