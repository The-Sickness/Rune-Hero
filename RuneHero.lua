local addonName, RH = ...;

local runePowerStatusBar;
local runePowerStatusBarText;

local offset = 15;
local start = -85;

local runeY = {
    [1] = start,
    [2] = start - offset,
    [3] = start - offset * 2,
    [4] = start - offset * 3,
    [5] = start - offset * 4,
    [6] = start - offset * 5
}

RuneHero_Saved = {
    anchor = "BOTTOM",
    parent = "UIParent",
    rel = "BOTTOM",
    x = 0,
    y = 135,
    scale = 7,
    runeX = 65,
    scrollWidth = 360,
};

function RunePower_Event()
end

function RuneButtonC_OnLoad(self)
    RuneFrameC_AddRune(RuneFrameC, self);
    self:SetScript("OnUpdate", RuneButtonC_OnUpdate);
    self:SetFrameLevel(self:GetFrameLevel() + 2 * self:GetID());
end

function RuneButtonC_OnUpdate(self, elapsed)
    if InCombatLockdown() then return end -- Do nothing if in combat

    local start, duration, runeReady = GetRuneCooldown(self:GetID());

    if runeReady then
        self:SetAlpha(1);
        self:SetPoint("TOPLEFT", "RuneFrameC", "TOPLEFT", RuneHero_Saved.runeX, runeY[self:GetID()]);
    else
        local remaining = duration - (GetTime() - start);
        if remaining < 0 then
            remaining = 0
        end
        local position = RuneHero_Saved.runeX + ((duration - remaining) / duration) * RuneHero_Saved.scrollWidth;

        self:SetAlpha(.5);
        self:SetPoint("TOPLEFT", "RuneFrameC", "TOPLEFT", position, runeY[self:GetID()]);
    end
end

function RuneButtonC_Update(self)
    local _, class = UnitClass("player");

    if class ~= "DEATHKNIGHT" then
        self:Hide();
        return;
    end
end

function RuneFrameC_OnLoad(self)
    local _, class = UnitClass("player");

    if class ~= "DEATHKNIGHT" then
        self:Hide();
    end

    if RuneHero_Saved.scrollWidth < 0 then
        RuneHero_Saved.scrollWidth = 360;
    end

    self:SetFrameLevel(1);

    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("COMBAT_LOG_EVENT");
    self:RegisterEvent("ADDON_LOADED");
    self:RegisterEvent("PLAYER_REGEN_ENABLED");
    self:RegisterEvent("PLAYER_REGEN_DISABLED");
    self:RegisterEvent("RUNE_POWER_UPDATE");

    self:SetScript("OnEvent", RuneFrameC_OnEvent);
    self:SetScript("OnUpdate", RuneFrameC_OnUpdate);

    self.runes = {};
end

function RuneFrameC_OnUpdate(self, elapsed)
    if not runePowerStatusBar then
        return
    end

    local power = UnitPower("player")
    runePowerStatusBar:SetWidth(power * 5.12)
    RuneStatusBar:SetTexCoord(0, power * 0.01, 0, 1)

    if power > 0 then
        runePowerStatusBarText:SetText(power)
    else
        runePowerStatusBarText:SetText(nil)
    end
end

function RuneFrameC_OnEvent(self, event, ...)
    if event == "COMBAT_LOG_EVENT" then
        local _, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, spellName = ...
        if sourceGUID == UnitGUID("player") then
            if spellId == 47541 then
                if subevent == "SPELL_AURA_APPLIED" then
                    RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade-proc")
                elseif subevent == "SPELL_AURA_REMOVED" then
                    RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade")
                end
            elseif spellId == 43265 then
                if subevent == "SPELL_AURA_APPLIED" then
                    RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade-proc")
                elseif subevent == "SPELL_AURA_REMOVED" then
                    RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade")
                end
            elseif spellName == "Death Trance" and sourceName == UnitName("player") then
                if subevent == "SPELL_AURA_APPLIED" then
                    RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade-proc")
                elseif subevent == "SPELL_AURA_REMOVED" then
                    RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade")
                end
            elseif spellName == "Killing Machine" and sourceName == UnitName("player") then
                if subevent == "SPELL_AURA_APPLIED" then
                    RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade-proc")
                elseif subevent == "SPELL_AURA_REMOVED" then
                    RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade")
                end
            end
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        RuneFrameC:Show()
        for rune in next, self.runes do
            RuneButtonC_Update(self.runes[rune])
        end
        RunePower_Event()
    elseif event == "RUNE_TYPE_UPDATE" then
        for rune in next, self.runes do
            RuneButtonC_Update(self.runes[rune])
        end
    elseif event == "RUNE_POWER_UPDATE" then
        for i = 1, 6 do
            RuneButtonC_OnUpdate(_G["RuneButtonIndividual"..i.."C"])
        end
        RunePower_Event()
    elseif event == "RUNE_REGEN_UPDATE" then
        RunePower_Event()
    elseif event == "ADDON_LOADED" then
        local addonName = select(1, ...)
        if addonName ~= "RuneHero" then return end

        RuneHero_LoadDefaults()
        RuneHero_SetLevels()

        RH.RuneHero_LoadOptions(self)

        if RuneHero_Saved.scrollWidth == nil or RuneHero_Saved.scrollWidth < 0 then
            RuneHero_Saved.scrollWidth = 360
        end

        RuneFrameC:ClearAllPoints()
        RuneFrameC:SetPoint(RuneHero_Saved.anchor, RuneHero_Saved.parent, RuneHero_Saved.rel, RuneHero_Saved.x, RuneHero_Saved.y)
        RuneFrameC:SetScale(RuneHero_Saved.scale)
        RuneHero_ButtonScale(RuneHero_Saved.scale)

        RuneBlade:SetTexture("Interface\\AddOns\\RuneHero\\textures\\" .. RuneHero_Saved.blade)

        runePowerStatusBar = CreateFrame("Frame", "RuneBladeStatusBar", RuneFrameC)
        runePowerStatusBar:CreateTexture("RuneStatusBar")
        runePowerStatusBar:SetPoint("LEFT", RuneFrameC, "LEFT")
        runePowerStatusBar:SetPoint("TOPLEFT", RuneFrameC, "TOPLEFT")
        runePowerStatusBar:SetFrameLevel(2)
        RuneStatusBar:SetAllPoints()
        RuneStatusBar:SetTexture("Interface\\AddOns\\RuneHero\\textures\\" .. RuneHero_Saved.blade .. "-statusbar.tga")

        runePowerStatusBarText = CreateFrame("StatusBar", nil, UIParent):CreateFontString("RuneBladeStatusBarText", 'OVERLAY')
        runePowerStatusBarText:ClearAllPoints()
        runePowerStatusBarText:SetFontObject(WorldMapTextFont)
        runePowerStatusBarText:SetTextColor(.6, .9, 1)
        runePowerStatusBarText:SetPoint("TOP", RuneBlade, "TOP")
        runePowerStatusBarText:SetJustifyH("CENTER")
        runePowerStatusBarText:SetWidth(90)
        runePowerStatusBarText:SetHeight(40)

    elseif event == "PLAYER_REGEN_ENABLED" then
        RuneFrameC:Show()
    elseif event == "PLAYER_REGEN_DISABLED" then
        RuneFrameC:Show()
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
    for i = 1, 6 do
        _G["RuneButtonIndividual"..i.."C"]:SetScale(scale);
    end
end

function RuneHero_SetLevels()
    RuneFrameC:SetFrameLevel(1);
    for i = 1, 6 do
        RuneFrameC.runes[i]:SetFrameLevel(i * 10 + 1);
    end
end

function RuneHero_LoadDefaults()
    if RuneHero_Saved.anchor == nil then
        RuneHero_Saved.anchor = "BOTTOM";
    end
    if RuneHero_Saved.parent == nil then
        RuneHero_Saved.parent = "UIParent";
    end
    if RuneHero_Saved.rel == nil then
        RuneHero_Saved.rel = "BOTTOM";
    end
    if RuneHero_Saved.x == nil then
        RuneHero_Saved.x = 0;
    end
    if RuneHero_Saved.y == nil then
        RuneHero_Saved.y = 135;
    end
    if RuneHero_Saved.scale == nil then
        RuneHero_Saved.scale = 1;
    end
    if RuneHero_Saved.runeX == nil then
        RuneHero_Saved.runeX = 65;
    end
    if RuneHero_Saved.scrollWidth == nil then
        RuneHero_Saved.scrollWidth = 360;
    end
    if RuneHero_Saved.blade == nil then
        RuneHero_Saved.blade = "runeblade";
    end
end

function RuneHero_SlashCommand(cmd)
    InterfaceOptionsFrame_OpenToCategory(RH.rhOptions.name);
    InterfaceOptionsFrame_OpenToCategory(RH.rhOptions.name);
end

SLASH_RUNEHERO1 = "/runehero";
SLASH_RUNEHERO2 = "/rh";
SlashCmdList["RUNEHERO"] = RuneHero_SlashCommand;

-- Create the RuneFrameC frame
local RuneFrameC = CreateFrame("Frame", "RuneFrameC", UIParent)
RuneFrameC:SetSize(512, 256)
RuneFrameC:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 105)
RuneFrameC:SetFrameStrata("LOW")
RuneFrameC:EnableMouse(true)
RuneFrameC:SetMovable(true)
RuneFrameC:RegisterForDrag("LeftButton")
RuneFrameC:SetScript("OnDragStart", RuneFrameC_OnDragStart)
RuneFrameC:SetScript("OnDragStop", RuneFrameC_OnDragStop)
RuneFrameC:Show()

RuneFrameC.texture = RuneFrameC:CreateTexture("RuneBlade", "BACKGROUND")
RuneFrameC.texture:SetTexture("Interface\\AddOns\\RuneHero\\textures\\runeblade")
RuneFrameC.texture:SetAllPoints(RuneFrameC)

RuneFrameC:SetScript("OnLoad", RuneFrameC_OnLoad)

-- Create the RuneButtonIndividualTemplateC button
local function CreateRuneButton(name, parent, id)
    local button = CreateFrame("Button", name, parent, "SecureActionButtonTemplate")
    button:SetSize(18, 18)
    button:SetFrameStrata("MEDIUM")
    button:SetID(id)

    button:SetScript("OnLoad", RuneButtonC_OnLoad)
    button:Show()
    return button
end

for i = 1, 6 do
    local button = CreateRuneButton("RuneButtonIndividual"..i.."C", UIParent, i)
    _G["RuneButtonIndividual"..i.."C"] = button
end

-- Load the frame and buttons
RuneFrameC_OnLoad(RuneFrameC)
for i = 1, 6 do
    RuneButtonC_OnLoad(_G["RuneButtonIndividual"..i.."C"])
end
