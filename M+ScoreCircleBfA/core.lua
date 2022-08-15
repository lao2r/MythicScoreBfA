isUpdateNeeded = ((tonumber(string.format("%s", (time(dateTbl))))) - mythicLastUpdatedTime)
needToUpdate = ""

if (isUpdateNeeded > (86400 * 2)) then
    needToUpdate = string.format("|cfffff200[|r|cffff8000M+ScoreCircleBfA|r|cfffff200]:|r|cffbf40cdБазы сильно устарели! Требуется обновление! Загрузите последнюю версию|r")
    print(needToUpdate)
end
if (isUpdateNeeded > 90000 and isUpdateNeeded < 86400 * 2) then
    needToUpdate = string.format("|cfffff200[|r|cffff8000M+ScoreCircleBfA|r|cfffff200]:|r|cffbf40cdВышло обновление! Загрузите последнюю версию|r")
    print(needToUpdate)
end

function getLastUpdateTime()
    return mythicLastUpdatedTime
end

function getCharacterIdByName(name)
    return library[name]
end

function getMythicScore(hero_ID)
    return characters[hero_ID]
end

local playerId = getCharacterIdByName(UnitName("player"))[1]
local playerInfo = getMythicScore(playerId)
local playerBest =
{
    [502] = { level = 0, dungeon_en = "Atal'dazar", dungeon_ru = "Атал'дазар", chest = 0 },
    [507] = { level = 0, dungeon_en = "The Underrot", dungeon_ru = "Подгнилье", chest = 0 },
    [504] = { level = 0, dungeon_en = "Temple of Sethraliss", dungeon_ru = "Храм Сетралисс", chest = 0 },
    [510] = { level = 0, dungeon_en = "The MOTHERLODE!!", dungeon_ru = "ЗОЛОТАЯ ЖИЛА!!!", chest = 0 },
    [514] = { level = 0, dungeon_en = "Kings' Rest", dungeon_ru = "Гробница королей", chest = 0 },
    [661] = { level = 0, dungeon_en = "Kings' Rest", dungeon_ru = "Гробница королей", chest = 0 },
    [518] = { level = 0, dungeon_en = "Freehold", dungeon_ru = "Вольная гавань", chest = 0 },
    [522] = { level = 0, dungeon_en = "Shrine of the Storm", dungeon_ru = "Святилище Штормов", chest = 0 },
    [526] = { level = 0, dungeon_en = "Tol Dagor", dungeon_ru = "Тол Дагор", chest = 0 },
    [530] = { level = 0, dungeon_en = "Waycrest Manor", dungeon_ru = "Усадьба Уейкрестов", chest = 0 },
    [534] = { level = 0, dungeon_en = "Siege of Boralus", dungeon_ru = "Осада Боралуса", chest = 0,
        side = "Версия для Орды" },
    [659] = { level = 0, dungeon_en = "Siege of Boralus", dungeon_ru = "Осада Боралуса", chest = 0,
        side = "Версия для Альянса" },
    [679] = { level = 0, dungeon_en = "Mechagon Junkyard", dungeon_ru = "Операция Мехагон - свалка",
        chest = 0 },
    [683] = { level = 0, dungeon_en = "Mechagon Workshop", dungeon_ru = "Операция Мехагон - мастерская",
        chest = 0 },
}

for k, v in pairs(playerBest) do
    for _, key in pairs(playerInfo.key) do
        if string.match(key:sub(3), v.dungeon_en) == v.dungeon_en then
            playerBest[k].level = key:sub(0, 2)
            if string.match(key:sub(12, 30), "+" .. "%d") ~= nil then
                playerBest[k].chest = string.match(key:sub(12, 30), "%d")
            end
        end
    end
end

function findClosest(r, n)
    local min = n[1].score
    local subMin = math.abs(n[1].score - r)
    local color = n[1].color
    for i = 1, table.getn(n) do
        local temp = math.abs(n[i].score - r)
        if temp <= subMin then
            subMin = temp
            min = n[i].score
            color = n[i].color
        end
    end
    return color[1]
end

local classColors = {
    ["Paladin"] = { "|cfff48cba%s|r" },
    ["Mage"] = { "|cff68ccef%s|r" },
    ["Monk"] = { "|cff00ffba%s|r" },
    ["Warrior"] = { "|cffc69b6d%s|r" },
    ["Hunter"] = { "|cffaad372%s|r" },
    ["Demon Hunter"] = { "|cffa330c9%s|r" },
    ["Druid"] = { "|cffff7c0a%s|r" },
    ["Warlock"] = { "|cff9382c9%s|r" },
    ["Shaman"] = { "|cff2359ff%s|r" },
    ["Death Knight"] = { "|cffc41e3b%s|r" },
    ["Priest"] = { "|cfff0ebe0%s|r" },
    ["Rogue"] = { "|cfffff468%s|r" }
}

ROLE_ICONS = {
    ["DPS"] = {
        full = "|TInterface\\AddOns\\M+ScoreCircleBfA\\icons\\roles:14:14:0:0:64:64:0:18:0:18|t"
    },
    ["HEALER"] = {
        full = "|TInterface\\AddOns\\M+ScoreCircleBfA\\icons\\roles:14:14:0:0:64:64:19:37:0:18|t"
    },
    ["TANK"] = {
        full = "|TInterface\\AddOns\\M+ScoreCircleBfA\\icons\\roles:14:14:0:0:64:64:38:56:0:18|t"
    }
}

AppendToGameTooltipMixin = {}

------------------------------------------------------------------------------------------------------------------------
local addInfoFrame = CreateFrame("GameTooltip","addInfoFrame")

addInfoFrame:SetScript("OnEvent",function(self, event, arg, ...)
    local unitName, unit = GameTooltip:GetUnit()
  if (event == "MODIFIER_STATE_CHANGED" and IsShiftKeyDown()) then
  if arg == "LSHIFT" then
    GameTooltip:SetUnit(unit)
  end
end
if (event == "MODIFIER_STATE_CHANGED" and IsShiftKeyDown() == false) then
    if (UnitIsPlayer(unit)) then
        GameTooltip:SetUnit(unit)
    end
    GameTooltip:Show()
end
end)

addInfoFrame:RegisterEvent("MODIFIER_STATE_CHANGED")
------------------------------------------------------------------------------------------------------------------------

function AppendToGameTooltipMixin:CheckMythicScore(check)

    local unitName, unit = GameTooltip:GetUnit()
    local summary = ""

    if UnitIsPlayer(unit) then
        local _prep = getCharacterIdByName(unitName)

        if _prep ~= nil then
            local _info = getMythicScore(_prep[1])

            if table.getn(_info.score) > 0 then
                if table.getn(_info.score) == 1 then
                    summary = string.format(_info.score[1]:gsub('%d', ''):gsub('%s', '') ..
                        findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), _info.score[1]) ..
                        string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                    self:AddRegion(summary, _info, _prep)
                end

                if table.getn(_info.score) == 2 then
                    summary = string.format(ROLE_ICONS[string.match(_info.score[1], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers),
                        string.match(_info.score[1], '%S+$')) ..
                        string.format("\nЛучший за сезон: |cff00a000%s|r", _info.bestKey:sub(0, 2)) ..
                        string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                    self:AddRegion(summary, _info, _prep)
                end

                if table.getn(_info.score) == 3 then
                    summary = string.format(ROLE_ICONS[string.match(_info.score[1], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers),
                        string.match(_info.score[1], '%S+$')) ..
                        string.format(" " ..
                            ROLE_ICONS[string.match(_info.score[2], "%u*")].full ..
                            findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers),
                            string.match(_info.score[2], '%S+$')) ..
                        string.format("\nЛучший за сезон: |cff00a000%s|r", _info.bestKey:sub(0, 2)) ..
                        string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                    self:AddRegion(summary, _info, _prep)
                end

                if table.getn(_info.score) == 4 then
                    summary = string.format(ROLE_ICONS[string.match(_info.score[1], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers),
                        string.match(_info.score[1], '%S+$')) ..
                        string.format(" " ..
                            ROLE_ICONS[string.match(_info.score[2], "%u*")].full ..
                            findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers),
                            string.match(_info.score[2], '%S+$')) ..
                        string.format(" " ..
                            ROLE_ICONS[string.match(_info.score[3], "%u*")].full ..
                            findClosest(tonumber(string.match(_info.score[3], '%S+$')), scoreTiers),
                            string.match(_info.score[3], '%S+$')) ..
                        string.format("\nЛучший за сезон: |cff00a000%s|r", _info.bestKey:sub(0, 2)) ..
                        string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                    self:AddRegion(summary, _info, _prep)
                end
            end
            if table.getn(_info.score) == 0 then
                self:AddRegion(string.format("|cffffffff%s|r", "No info"))
            end
        end
        if _prep == nil then
            self:AddRegion(string.format("|cffffffff%s|r", "No info"))
        end
    end
end

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
    AppendToGameTooltipMixin:CheckMythicScore()
end)

function OnLeave_T(self)
    GameTooltip:ClearLines()
    GameTooltip:Hide()
end

function AppendToGameTooltipMixin:AddRegion(_score, _info, _prep)
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(string.format("M+ Score: %s", _score))

    bestTotalNum = "tier0";
        total = ""
    if (_prep ~= nill) then
        if (total_run[_prep[1]].tier1 > 0) then
            total = string.format("|cffffff00Ключи в таймер:|r |cff55dc62 +5-9|r - |cffffffff(%s)|r",
                total_run[_prep[1]].tier1)
                bestTotalNum = "tier1"
        end
        if (total_run[_prep[1]].tier2 > 0) then
            total = string.format("|cffffff00Ключи в таймер:|r |cff4687c5+10-14|r - |cffffffff(%s)|r",
                total_run[_prep[1]].tier2)
                bestTotalNum = "tier2"
        end
        if (total_run[_prep[1]].tier3 > 0) then
            total = string.format("|cffffff00Ключи в таймер:|r |cff695ee4+15-19|r - |cffffffff(%s)|r",
                total_run[_prep[1]].tier3)
                bestTotalNum = "tier3"
        end
        if (total_run[_prep[1]].tier4 > 0) then
            total = string.format("|cffffff00Ключи в таймер:|r |cffab38e6+20-24|r - |cffffffff(%s)|r",
                total_run[_prep[1]].tier4)
                bestTotalNum = "tier4"
        end
        if (total_run[_prep[1]].tier5 > 0) then
            total = string.format("|cffffff00Ключи в таймер:|r |cffe1588e+25-29|r - |cffffffff(%s)|r",
                total_run[_prep[1]].tier5)
                bestTotalNum = "tier5"
        end
        if (total_run[_prep[1]].tier6 > 0) then
            total = string.format("|cffffff00Ключи в таймер:|r |cfffb792e+30-34|r - |cffffffff(%s)|r",
                total_run[_prep[1]].tier6)
                bestTotalNum = "tier6"
        end
        GameTooltip:AddLine("------------------------------------")
        GameTooltip:AddLine(total, _, _, _, false)
    end

    if IsShiftKeyDown() and not UnitAffectingCombat("player") then
        if (table.getn(_info.key_ru) > 0) then
            total = ""
            if (_prep ~= nill) then
                if (total_run[_prep[1]].tier6 > 0 and bestTotalNum ~= "tier6") then
                    GameTooltip:AddLine(string.format("|cffffff00Ключи в таймер:|r |cfffb792e+30-34|r - |cffffffff(%s)|r",
                        total_run[_prep[1]].tier6), _, _, _, false)
                end
                if (total_run[_prep[1]].tier5 > 0 and bestTotalNum ~= "tier5") then
                    GameTooltip:AddLine(string.format("|cffffff00Ключи в таймер:|r |cffe1588e+25-29|r - |cffffffff(%s)|r",
                        total_run[_prep[1]].tier5), _, _, _, false)
                end
                if (total_run[_prep[1]].tier4 > 0 and bestTotalNum ~= "tier4") then
                    GameTooltip:AddLine(string.format("|cffffff00Ключи в таймер:|r |cffab38e6+20-24|r - |cffffffff(%s)|r",
                        total_run[_prep[1]].tier4), _, _, _, false)
                end
                if (total_run[_prep[1]].tier3 > 0 and bestTotalNum ~= "tier3") then
                    GameTooltip:AddLine(string.format("|cffffff00Ключи в таймер:|r |cff695ee4+15-19|r - |cffffffff(%s)|r",
                        total_run[_prep[1]].tier3), _, _, _, false)
                end
                if (total_run[_prep[1]].tier2 > 0 and bestTotalNum ~= "tier2") then
                    GameTooltip:AddLine(string.format("|cffffff00Ключи в таймер:|r |cff4687c5+10-14|r - |cffffffff(%s)|r",
                        total_run[_prep[1]].tier2), _, _, _, false)
                end
                if (total_run[_prep[1]].tier1 > 0 and bestTotalNum ~= "tier1") then
                    GameTooltip:AddLine(string.format("|cffffff00Ключи в таймер:|r |cff55dc62 +5-9|r - |cffffffff(%s)|r",
                        total_run[_prep[1]].tier1), _, _, _, false)
                end
            end
            GameTooltip:AddLine("\nЛучшие прохождения:")
            for _, key in ipairs(_info.key_ru) do
                GameTooltip:AddLine(string.format("|cff00a000%s|r", key:sub(0, 2)) ..
                    string.format(string.format("|cffffffff%s|r", key:sub(3))))
            end
        end
    end

    GameTooltip:Show()
end


LFGRegionMixin = {}

function LFGRegionMixin:OnLoad()
    self:Initialize()
end

function LFGRegionMixin:Initialize()
    local function SetSearchEntryTooltip(_, resultID)
        local info = C_LFGList.GetSearchResultInfo(resultID)
        if (info.leaderName) then
            self:CheckMythicScore(info.leaderName, info.activityID)
        end
    end

    hooksecurefunc("LFGListUtil_SetSearchEntryTooltip", SetSearchEntryTooltip)
end

function LFGRegionMixin:CheckMythicScore(leaderName, activityID)

    local summary = ""
    if (getCharacterIdByName(leaderName) ~= nil) then
        local _prep = getCharacterIdByName(leaderName)

        local _info = getMythicScore(_prep[1])
        if table.getn(_info.score) > 0 then
            if table.getn(_info.score) == 1 then
                summary = string.format(_info.score[1]:gsub('%d', ''):gsub('%s', '') ..
                    findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers),
                    string.match(_info.score[1], '%S+$')) ..
                    string.format("\nРекорд лидера группы:\n" .. "|cff00a000%s|r",
                        _info.bestKey:sub(0, 2)) ..
                    string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                self:AddRegion(summary, _info, activityID, _prep)
            end
            if table.getn(_info.score) == 2 then
                summary = string.format(ROLE_ICONS[string.match(_info.score[1], "%u*")].full ..
                    findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers),
                    string.match(_info.score[1], '%S+$')) ..
                    string.format("\nРекорд лидера группы:\n" .. "|cff00a000%s|r",
                        _info.bestKey:sub(0, 2)) ..
                    string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                self:AddRegion(summary, _info, activityID, _prep)
            end
            if table.getn(_info.score) == 3 then
                summary = string.format(ROLE_ICONS[string.match(_info.score[1], "%u*")].full ..
                    findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers),
                    string.match(_info.score[1], '%S+$')) ..
                    string.format(" " ..
                        ROLE_ICONS[string.match(_info.score[2], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers),
                        string.match(_info.score[2], '%S+$')) ..
                    string.format("\nРекорд лидера группы:\n" .. "|cff00a000%s|r",
                        _info.bestKey:sub(0, 2)) ..
                    string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                self:AddRegion(summary, _info, activityID, _prep)
            end
            if table.getn(_info.score) > 3 then
                summary = string.format(ROLE_ICONS[string.match(_info.score[1], "%u*")].full ..
                    findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers),
                    string.match(_info.score[1], '%S+$')) ..
                    string.format(" " ..
                        ROLE_ICONS[string.match(_info.score[2], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers),
                        string.match(_info.score[2], '%S+$')) ..
                    string.format(" " ..
                        ROLE_ICONS[string.match(_info.score[3], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[3], '%S+$')), scoreTiers),
                        string.match(_info.score[3], '%S+$')) ..
                    string.format("\nРекорд лидера группы:\n" .. "|cff00a000%s|r",
                        _info.bestKey:sub(0, 2)) ..
                    string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                self:AddRegion(summary, _info, activityID, _prep)
            end
        end
        if table.getn(_info.score) == 0 then
            self:AddRegion(string.format("|cffffffff%s|r", "No info"), 1, activityID, _prep)
        end
    end
    if (getCharacterIdByName(leaderName) == nil) then
        self:AddRegion(string.format("|cffffffff%s|r", "No info"), 1, activityID, _prep)
    end
end

function tableHasKey(table, key)
    return table[key] ~= nil
end

function LFGRegionMixin:AddRegion(_score, _info, activityID, _prep)
    local currentBest
    local currentLevel
    local currentChest

    if (tableHasKey(playerBest, activityID) == true) then
        currentBest = playerBest[activityID].dungeon_ru
        currentLevel = playerBest[activityID].level
        currentChest = playerBest[activityID].chest
    end

    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(string.format("M+ Score: %s", _score))
    GameTooltip:Show()
    if (_info ~= 1) then
        if (table.getn(_info.key_ru) > 0) then
            GameTooltip:AddLine("Лучшие прохождения лидера группы:")
            for _, key in ipairs(_info.key_ru) do
                GameTooltip:AddLine(string.format("|cff00a000%s|r", key:sub(0, 2)) ..
                    string.format(string.format("|cffffffff%s|r", key:sub(3))))
            end
        end
    end

    local total = ""

    if (_prep ~= nill) then
        GameTooltip:AddLine("----------------------------------")
        if (total_run[_prep[1]].tier1 > 0) then
            total = string.format("|cffffff00Ключи в таймер:|r |cff55dc62 +5-9|r - |cffffffff(%s)|r",
                total_run[_prep[1]].tier1)
                GameTooltip:AddLine(total, _, _, _, false)
        end
        if (total_run[_prep[1]].tier2 > 0) then
            total = string.format("|cffffff00Ключи в таймер:|r |cff4687c5+10-14|r - |cffffffff(%s)|r",
                total_run[_prep[1]].tier2)
                GameTooltip:AddLine(total, _, _, _, false)
        end
        if (total_run[_prep[1]].tier3 > 0) then
            total = string.format("|cffffff00Ключи в таймер:|r |cff695ee4+15-19|r - |cffffffff(%s)|r",
                total_run[_prep[1]].tier3)
                GameTooltip:AddLine(total, _, _, _, false)
        end
        if (total_run[_prep[1]].tier4 > 0) then
            total = string.format("|cffffff00Ключи в таймер:|r |cffab38e6+20-24|r - |cffffffff(%s)|r",
                total_run[_prep[1]].tier4)
                GameTooltip:AddLine(total, _, _, _, false)
        end
        if (total_run[_prep[1]].tier5 > 0) then
            total = string.format("|cffffff00Ключи в таймер:|r |cffe1588e+25-30|r - |cffffffff(%s)|r",
                total_run[_prep[1]].tier5)
                GameTooltip:AddLine(total, _, _, _, false)
        end
        if (total_run[_prep[1]].tier6 > 0) then
            total = string.format("|cffffff00Ключи в таймер:|r |cfffb792e+30-34|r - |cffffffff(%s)|r",
                total_run[_prep[1]].tier6)
                GameTooltip:AddLine(total, _, _, _, false)
        end
    end
    GameTooltip:Show()
    if (tableHasKey(playerBest, activityID) == true) then
        currentBest = playerBest[activityID].dungeon_ru
        currentLevel = playerBest[activityID].level
        currentChest = playerBest[activityID].chest
    GameTooltip:AddLine(string.format("\n----------------------------------\nВаш рекорд в текущем подземелье:\n|cff42aaff%s|r "
        , currentLevel) ..
        string.format("|cffc5d0e6%s|r ", currentBest) .. string.format("|cffffff00+%s|r ", currentChest))
    end
    GameTooltip:Show()
end

local hooked = {}
local OnEnter
local OnLeave

local function HookApplicantButtons(buttons)
    for _, button in pairs(buttons) do
        if not hooked[button] then
            hooked[button] = true
            button:HookScript("OnEnter", OnEnter)
            button:HookScript("OnLeave", OnLeave)
        end
    end
end

function LFGApplicantInit()
    for i = 1, 14 do
        local button = _G["LFGListApplicationViewerScrollFrameButton" .. i]
        button:HookScript("OnEnter", OnEnter)
        button:HookScript("OnLeave", OnLeave)
    end
end

function clearTooltip(self)
    GameTooltip:ClearLines()
    GameTooltip:Hide()
end

function OnEnter(self)
    if self.applicantID and self.Members then
        HookApplicantButtons(self.Members)
    elseif self.memberIdx then
        local name, class, localizedClass, level, itemLevel, honorLevel, tank, healer, damage, assignedRole, relationship,
            pvpItemLevel = C_LFGList.GetApplicantMemberInfo(self:GetParent().applicantID, self.memberIdx)
        LFGRegionMixin:CheckMythicScore(name)
    end
end

function OnLeave(self)
    GameTooltip:ClearLines()
    GameTooltip:Hide()
end

do
    local f = _G.LFGListFrame.ApplicationViewer.UnempoweredCover
    f:EnableMouse(false)
    f:EnableMouseWheel(false)
    f:SetToplevel(false)
end

LFGApplicantInit()

function printMythicScoreInfo(unitName)

    local unitName   = unitName
    local summary    = ""

    local _prep = getCharacterIdByName(unitName)

    if _prep ~= nil then
        local _info = getMythicScore(_prep[1])
        local classColor = classColors[_info.class][1]
        local total = ""

        if (_prep ~= nill) then
            if (total_run[_prep[1]].tier1 > 0) then
                total = string.format("|cffffff00Ключи в таймер:|r |cff55dc62 +5-9|r - |cffffffff(%s)|r",
                    total_run[_prep[1]].tier1)
            end
            if (total_run[_prep[1]].tier2 > 0) then
                total = string.format("|cffffff00Ключи в таймер:|r |cff4687c5+10-14|r - |cffffffff(%s)|r",
                    total_run[_prep[1]].tier2)
            end
            if (total_run[_prep[1]].tier3 > 0) then
                total = string.format("|cffffff00Ключи в таймер:|r |cff695ee4+15-19|r - |cffffffff(%s)|r",
                    total_run[_prep[1]].tier3)
            end
            if (total_run[_prep[1]].tier4 > 0) then
                total = string.format("|cffffff00Ключи в таймер:|r |cffab38e6+20-24|r - |cffffffff(%s)|r",
                    total_run[_prep[1]].tier4)
            end
            if (total_run[_prep[1]].tier5 > 0) then
                total = string.format("|cffffff00Ключи в таймер:|r |cffe1588e+25-30|r - |cffffffff(%s)|r",
                    total_run[_prep[1]].tier5)
            end
            if (total_run[_prep[1]].tier6 > 0) then
                total = string.format("|cffffff00Ключи в таймер:|r |cfffb792e+30-34|r - |cffffffff(%s)|r",
                    total_run[_prep[1]].tier6)
            end
        end

        if table.getn(_info.score) > 0 then
            if table.getn(_info.score) == 1 then
                summary = string.format(classColor, unitName) ..
                    ": " .. string.format(_info.score[1]:gsub('%d', ''):gsub('%s', '') ..
                        findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), _info.score[1]) ..
                    string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                print("|cffffff00-------------------------------|r\n" .. summary .. "\n" .. total)
                print("|cffffff00-------------------------------|r")
            end

            if table.getn(_info.score) == 2 then
                summary = string.format(classColor, unitName) ..
                    ": " .. string.format(ROLE_ICONS[string.match(_info.score[1], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers),
                        string.match(_info.score[1], '%S+$')) ..
                    string.format("\n|cffffff00Рекорд сезона:|r |cff00a000%s|r", _info.bestKey:sub(0, 2)) ..
                    string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                print("|cffffff00-------------------------------|r\n" .. summary .. "\n" .. total)
                print("|cffffff00-------------------------------|r")
            end

            if table.getn(_info.score) == 3 then
                summary = string.format(classColor, unitName) ..
                    ": " .. string.format(ROLE_ICONS[string.match(_info.score[1], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers),
                        string.match(_info.score[1], '%S+$')) ..
                    string.format("" ..
                        ROLE_ICONS[string.match(_info.score[2], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers),
                        string.match(_info.score[2], '%S+$')) ..
                    string.format("\n|cffffff00Рекорд сезона:|r |cff00a000%s|r", _info.bestKey:sub(0, 2)) ..
                    string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                print("|cffffff00-------------------------------|r\n" .. summary .. "\n" .. total)
                print("|cffffff00-------------------------------|r")
            end

            if table.getn(_info.score) == 4 then
                summary = string.format(classColor, unitName) ..
                    ": " .. string.format(ROLE_ICONS[string.match(_info.score[1], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers),
                        string.match(_info.score[1], '%S+$')) ..
                    string.format("" ..
                        ROLE_ICONS[string.match(_info.score[2], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers),
                        string.match(_info.score[2], '%S+$')) ..
                    string.format("" ..
                        ROLE_ICONS[string.match(_info.score[3], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[3], '%S+$')), scoreTiers),
                        string.match(_info.score[3], '%S+$')) ..
                    string.format("\n|cffffff00Рекорд сезона:|r |cff00a000%s|r", _info.bestKey:sub(0, 2)) ..
                    string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                print("|cffffff00-------------------------------|r\n" .. summary .. "\n" .. total)
                print("|cffffff00-------------------------------|r")
            end
        end
        if table.getn(_info.score) == 0 then
            print(string.format("|cffffff00M+ Score:|r |cffffffff%s|r", "Нет информации о прогрессе"))
        end
    end
    if _prep == nil then
        print(string.format("|cffffff00M+ Score:|r |cffffffff%s|r", "Нет информации о прогрессе"))
    end
end

UnitPopupButtons["MM"] = { text = "|cffff8000Прогресс M+Score|r",
    --dist = 0
};
table.insert(UnitPopupMenus["FRIEND"], #(UnitPopupMenus["FRIEND"]) - 1, "MM");
table.insert(UnitPopupMenus["GUILD"], #(UnitPopupMenus["GUILD"]) - 1, "MM");

hooksecurefunc("UnitPopup_OnClick", function(self)
    local dropdownFrame = UIDROPDOWNMENU_INIT_MENU
    local button = self.value
    DropDownList1Button10:Hide()
    if button == "MM" then
        printMythicScoreInfo(dropdownFrame.name)
    end
end)
