isUpdateNeeded = ((tonumber(string.format("%s", (time(dateTbl))))) - mythicLastUpdatedTime)
needToUpdate = ""
remind = "|cfffff200[|r|cffff8000M+ScoreCircleBfA|r|cfffff200]:|r|cffbf40cd31.12.2022 поддержка и обновление аддона будут прекращены!|r"

print(remind)
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

local show = true
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

local NWC = {
	[1] = {
		14078, -- [1]
		14079, -- [2]
		14080, -- [3]
		14082, -- [4]
	}, -- [1]
	[2] = {
		14089, -- [1]
		14091, -- [2]
		14093, -- [3]
		14094, -- [4]
	}, -- [2]
	[3] = {
		14095, -- [1]
		14096, -- [2]
		14097, -- [3]
		14098, -- [4]
	}, -- [3]
	[4] = {
		14101, -- [1]
		14102, -- [2]
		14104, -- [3]
		14105, -- [4]
	}, -- [4]
	[5] = {
		14107, -- [1]
		14108, -- [2]
		14109, -- [3]
		14110, -- [4]
	}, -- [5]
	[6] = {
		14111, -- [1]
		14112, -- [2]
		14114, -- [3]
		14115, -- [4]
	}, -- [6]
	[7] = {
		14117, -- [1]
		14118, -- [2]
		14119, -- [3]
		14120, -- [4]
	}, -- [7]
	[8] = {
		14207, -- [1]
		14208, -- [2]
		14210, -- [3]
		14211, -- [4]
	}, -- [8]
	[9] = {
		14123, -- [1]
		14124, -- [2]
		14125, -- [3]
		14126, -- [4]
	}, -- [9]
	[10] = {
		14127, -- [1]
		14128, -- [2]
		14129, -- [3]
		14130, -- [4]
	}, -- [10]
	[11] = {
		14131, -- [1]
		14132, -- [2]
		14133, -- [3]
		14134, -- [4]
	}, -- [11]
	[12] = {
		14135, -- [1]
		14136, -- [2]
		14137, -- [3]
		14138, -- [4]
	}, -- [12]
}

local LFR = { unitName = " ", raid = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0 , [6] = 0, [7] = 0, [8] = 0, [9] = 0, [10] = 0, [11] = 0, [12] = 0 } }

local N = { unitName = " ", raid = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0 , [6] = 0, [7] = 0, [8] = 0, [9] = 0, [10] = 0, [11] = 0, [12] = 0 } }

local H = { unitName = " ", raid = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0 , [6] = 0, [7] = 0, [8] = 0, [9] = 0, [10] = 0, [11] = 0, [12] = 0 } }

local M = { unitName = " ", raid = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0 , [6] = 0, [7] = 0, [8] = 0, [9] = 0, [10] = 0, [11] = 0, [12] = 0 } }


local lfr = 0
local normal = 0
local heroic = 0
local mythic = 0

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

STAR_ICON = "|TInterface\\AddOns\\M+ScoreCircleBfA\\icons\\st:8:8:0:0:0:0:0:0:0:0|t"


AppendToGameTooltipMixin = {}

------------------------------------------------------------------------------------------------------------------------
local addInfoFrame = CreateFrame("GameTooltip", "addInfoFrame")

addInfoFrame:SetScript("OnEvent", function(self, event, arg, ...)
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
addInfoFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

------------------------------------------------------------------------------------------------------------------------

function AppendToGameTooltipMixin:CheckMythicScore(check)
    local unitName, unit = GameTooltip:GetUnit()
    SetAchievementComparisonUnit(unit)
    local summary = ""
    local raidProgress = ""
    local l = getKilledBossesCount(LFR.raid)
    local n = getKilledBossesCount(N.raid)
    local h = getKilledBossesCount(H.raid)
    local m = getKilledBossesCount(M.raid)
    local currentRaidBest = ""

        if (l > 0) then
            raidProgress = "|cff55dc62ПР |r" .. l .."/12"
            currentRaidBest = "LFR"
        end
        if (n > 0) then
            raidProgress = "|cff4687c5О |r" .. n .."/12"
            currentRaidBest = "N"
        end
        if (h > 0) then
            raidProgress = "|cff695ee4Г |r" .. h .."/12"
            currentRaidBest = "H"
        end
        if (m > 0) then
            raidProgress = "|cffe1588eЭ |r" .. m .."/12"
            currentRaidBest = "M"
        end

        if(LFR.unitName ~= unitName) then
            raidProgress = "Подождите..."
            show = true
        end
 
    if UnitIsPlayer(unit) then
        local _prep = getCharacterIdByName(unitName)

        if _prep ~= nil then
            local _info = getMythicScore(_prep[1])

            if table.getn(_info.score) > 0 then

                local dungeonName = _info.bestKey:sub(3)
                if (string.match(dungeonName, "(+0)")) then
                    dungeonName = string.format("|cffA0A0A4%s|r", _info.bestKey:sub(3))
                end
                if (string.match(dungeonName, "(+1)")) then
                    dungeonName = string.format("|cffffffff%s|r",
                        _info.bestKey:sub(3, _info.bestKey:len() - 4) .. STAR_ICON)
                end
                if (string.match(dungeonName, "(+2)")) then
                    dungeonName = string.format("|cffffffff%s|r",
                        _info.bestKey:sub(3, _info.bestKey:len() - 4) .. STAR_ICON .. STAR_ICON)
                end
                if (string.match(dungeonName, "(+3)")) then
                    dungeonName = string.format("|cffffffff%s|r",
                        _info.bestKey:sub(3, _info.bestKey:len() - 4) .. STAR_ICON .. STAR_ICON .. STAR_ICON)
                end

                local playerRecord =
                string.format("\nЛучший за сезон: |cff00a000%s|r", _info.bestKey:sub(0, 2)) .. dungeonName

                summary = string.format(ROLE_ICONS[string.match(_info.score[1], "%u*")].full ..
                    findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers),
                    string.match(_info.score[1], '%S+$'))

                if table.getn(_info.score) > 2 then
                    summary = summary ..
                        string.format(" " ..
                            ROLE_ICONS[string.match(_info.score[2], "%u*")].full ..
                            findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers),
                            string.match(_info.score[2], '%S+$'))
                end

                if table.getn(_info.score) > 3 then
                    summary = summary ..
                        string.format(" " ..
                            ROLE_ICONS[string.match(_info.score[3], "%u*")].full ..
                            findClosest(tonumber(string.match(_info.score[3], '%S+$')), scoreTiers),
                            string.match(_info.score[3], '%S+$'))
                end
                self:AddRegion(summary .. playerRecord, _info, _prep, raidProgress, currentRaidBest)
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

-------------------------------------------------------------------
GameTooltip:HookScript("OnTooltipSetUnit", function(self)
    ClearAchievementComparisonUnit()
    AppendToGameTooltipMixin:CheckMythicScore()
    -- setDefaultKilledRaidBossesValue()
end)

function OnLeave_T(self)
    GameTooltip:ClearLines()
    GameTooltip:Hide()
end

function getKilledBossesCount(mode) 
    count = 0
    for k, v in pairs(mode) do
        if v ~= 0 then
        count = count + 1
        end
    end
    return count
end

function AppendToGameTooltipMixin:AddRegion(_score, _info, _prep, raidProgress, currentRaidBest)
    
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(string.format("M+ Score: %s", _score))

    local detailedRaidInfo = ""

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
                    GameTooltip:AddLine(string.format("|cffffff00Ключи в таймер:|r |cfffb792e+30-34|r - |cffffffff(%s)|r"
                        ,
                        total_run[_prep[1]].tier6), _, _, _, false)
                end
                if (total_run[_prep[1]].tier5 > 0 and bestTotalNum ~= "tier5") then
                    GameTooltip:AddLine(string.format("|cffffff00Ключи в таймер:|r |cffe1588e+25-29|r - |cffffffff(%s)|r"
                        ,
                        total_run[_prep[1]].tier5), _, _, _, false)
                end
                if (total_run[_prep[1]].tier4 > 0 and bestTotalNum ~= "tier4") then
                    GameTooltip:AddLine(string.format("|cffffff00Ключи в таймер:|r |cffab38e6+20-24|r - |cffffffff(%s)|r"
                        ,
                        total_run[_prep[1]].tier4), _, _, _, false)
                end
                if (total_run[_prep[1]].tier3 > 0 and bestTotalNum ~= "tier3") then
                    GameTooltip:AddLine(string.format("|cffffff00Ключи в таймер:|r |cff695ee4+15-19|r - |cffffffff(%s)|r"
                        ,
                        total_run[_prep[1]].tier3), _, _, _, false)
                end
                if (total_run[_prep[1]].tier2 > 0 and bestTotalNum ~= "tier2") then
                    GameTooltip:AddLine(string.format("|cffffff00Ключи в таймер:|r |cff4687c5+10-14|r - |cffffffff(%s)|r"
                        ,
                        total_run[_prep[1]].tier2), _, _, _, false)
                end
                if (total_run[_prep[1]].tier1 > 0 and bestTotalNum ~= "tier1") then
                    GameTooltip:AddLine(string.format("|cffffff00Ключи в таймер:|r |cff55dc62 +5-9|r - |cffffffff(%s)|r"
                        ,
                        total_run[_prep[1]].tier1), _, _, _, false)
                end
            end
            GameTooltip:AddLine("\nЛучшие прохождения:")
            for _, key in ipairs(_info.key_ru) do
                local dungeonName = key:sub(3)
                if (string.match(dungeonName, "(+0)") == nil) then
                    dungeonName = string.format("|cffA0A0A4%s|r", key:sub(3))
                end
                if (string.match(dungeonName, "1")) then
                    dungeonName = string.format("|cffffffff%s|r", key:sub(3, key:len() - 2) .. STAR_ICON)
                end
                if (string.match(dungeonName, "2")) then
                    dungeonName = string.format("|cffffffff%s|r", key:sub(3, key:len() - 2) .. STAR_ICON .. STAR_ICON)
                end
                if (string.match(dungeonName, "3")) then
                    dungeonName = string.format("|cffffffff%s|r",
                        key:sub(3, key:len() - 2) .. STAR_ICON .. STAR_ICON .. STAR_ICON)
                end
                GameTooltip:AddLine(string.format("|cff00a000%s|r", key:sub(0, 2)) ..
                    dungeonName)
            end
        end
    end
    if (raidProgress == "") then
        GameTooltip:AddLine("|cffffff00Ни'алота: |r No info")
    end
    if (raidProgress ~= "") then
        GameTooltip:AddLine("|cffffff00Ни'алота: |r"..raidProgress)
    if IsShiftKeyDown() and not UnitAffectingCombat("player") then
        if currentRaidBest == "LFR" then
            if (LFR.raid[1] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. LFR.raid[1]  .. " |cffffffffГневион|r\n" else detailedRaidInfo = detailedRaidInfo ..                 LFR.raid[1]  .. " |cffA0A0A4Гневион|r" .. "\n" end
            if (LFR.raid[2] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. LFR.raid[2]  .. " |cffffffffМаут|r\n" else detailedRaidInfo = detailedRaidInfo ..                    LFR.raid[2]  .. " |cffA0A0A4Маут|r" .. "\n" end
            if (LFR.raid[3] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. LFR.raid[3]  .. " |cffffffffПророк Скитра|r\n" else detailedRaidInfo = detailedRaidInfo ..           LFR.raid[3]  .. " |cffA0A0A4Пророк Скитра|r" .. "\n" end
            if (LFR.raid[4] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. LFR.raid[4]  .. " |cffffffffТемный инквизитор Занеш|r\n" else detailedRaidInfo = detailedRaidInfo .. LFR.raid[4]  .. " |cffA0A0A4Темный инквизитор Занеш|r" .. "\n" end
            if (LFR.raid[5] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. LFR.raid[5]  .. " |cffffffffКоллективный разум|r\n" else detailedRaidInfo = detailedRaidInfo ..      LFR.raid[5]  .. " |cffA0A0A4Коллективный разум|r" .. "\n" end
            if (LFR.raid[6] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. LFR.raid[6]  .. " |cffffffffШад'хар ненасытный|r\n" else detailedRaidInfo = detailedRaidInfo ..      LFR.raid[6]  .. " |cffA0A0A4Шад'хар ненасытный|r" .. "\n" end
            if (LFR.raid[7] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. LFR.raid[7]  .. " |cffffffffДест'агат|r\n" else detailedRaidInfo = detailedRaidInfo ..               LFR.raid[7]  .. " |cffA0A0A4Дест'агат|r" .. "\n" end
            if (LFR.raid[8] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. LFR.raid[8]  .. " |cffffffffИл'гинот|r\n" else detailedRaidInfo = detailedRaidInfo ..                LFR.raid[8]  .. " |cffA0A0A4Ил'гинот|r" .. "\n" end
            if (LFR.raid[9] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. LFR.raid[9]  .. " |cffffffffВексиона|r\n" else detailedRaidInfo = detailedRaidInfo ..                LFR.raid[9]  .. " |cffA0A0A4Вексиона|r" .. "\n" end
            if (LFR.raid[10] ~= 0) then detailedRaidInfo = detailedRaidInfo .. LFR.raid[10] .. " |cffffffffРа-ден|r\n" else detailedRaidInfo = detailedRaidInfo ..                  LFR.raid[10] .. " |cffA0A0A4Ра-ден|r" .. "\n" end
            if (LFR.raid[11] ~= 0) then detailedRaidInfo = detailedRaidInfo .. LFR.raid[11] .. " |cffffffffПанцырь Н'зота|r\n" else detailedRaidInfo = detailedRaidInfo ..          LFR.raid[11] .. " |cffA0A0A4Панцырь Н'зота|r" .. "\n" end
            if (LFR.raid[12] ~= 0) then detailedRaidInfo = detailedRaidInfo .. LFR.raid[12] .. " |cffffffffН'зот заразитель|r\n" else detailedRaidInfo = detailedRaidInfo ..        LFR.raid[12] .. " |cffA0A0A4Н'зот заразитель|r" end
        end 
        if currentRaidBest == "N" then 
            if (N.raid[1] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. N.raid[1]  .. " |cffffffffГневион|r\n" else detailedRaidInfo = detailedRaidInfo ..                 N.raid[1]  .. " |cffA0A0A4Гневион|r" .. "\n" end
            if (N.raid[2] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. N.raid[2]  .. " |cffffffffМаут|r\n" else detailedRaidInfo = detailedRaidInfo ..                    N.raid[2]  .. " |cffA0A0A4Маут|r" .. "\n" end
            if (N.raid[3] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. N.raid[3]  .. " |cffffffffПророк Скитра|r\n" else detailedRaidInfo = detailedRaidInfo ..           N.raid[3]  .. " |cffA0A0A4Пророк Скитра|r" .. "\n" end
            if (N.raid[4] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. N.raid[4]  .. " |cffffffffТемный инквизитор Занеш|r\n" else detailedRaidInfo = detailedRaidInfo .. N.raid[4]  .. " |cffA0A0A4Темный инквизитор Занеш|r" .. "\n" end
            if (N.raid[5] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. N.raid[5]  .. " |cffffffffКоллективный разум|r\n" else detailedRaidInfo = detailedRaidInfo ..      N.raid[5]  .. " |cffA0A0A4Коллективный разум|r" .. "\n" end
            if (N.raid[6] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. N.raid[6]  .. " |cffffffffШад'хар ненасытный|r\n" else detailedRaidInfo = detailedRaidInfo ..      N.raid[6]  .. " |cffA0A0A4Шад'хар ненасытный|r" .. "\n" end
            if (N.raid[7] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. N.raid[7]  .. " |cffffffffДест'агат|r\n" else detailedRaidInfo = detailedRaidInfo ..               N.raid[7]  .. " |cffA0A0A4Дест'агат|r" .. "\n" end
            if (N.raid[8] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. N.raid[8]  .. " |cffffffffИл'гинот|r\n" else detailedRaidInfo = detailedRaidInfo ..                N.raid[8]  .. " |cffA0A0A4Ил'гинот|r" .. "\n" end
            if (N.raid[9] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. N.raid[9]  .. " |cffffffffВексиона|r\n" else detailedRaidInfo = detailedRaidInfo ..                N.raid[9]  .. " |cffA0A0A4Вексиона|r" .. "\n" end
            if (N.raid[10] ~= 0) then detailedRaidInfo = detailedRaidInfo .. N.raid[10] .. " |cffffffffРа-ден|r\n" else detailedRaidInfo = detailedRaidInfo ..                  N.raid[10] .. " |cffA0A0A4Ра-ден|r" .. "\n" end
            if (N.raid[11] ~= 0) then detailedRaidInfo = detailedRaidInfo .. N.raid[11] .. " |cffffffffПанцырь Н'зота|r\n" else detailedRaidInfo = detailedRaidInfo ..          N.raid[11] .. " |cffA0A0A4Панцырь Н'зота|r" .. "\n" end
            if (N.raid[12] ~= 0) then detailedRaidInfo = detailedRaidInfo .. N.raid[12] .. " |cffffffffН'зот заразитель|r\n" else detailedRaidInfo = detailedRaidInfo ..        N.raid[12] .. " |cffA0A0A4Н'зот заразитель|r" end
        end
        if currentRaidBest == "H" then
            if (H.raid[1] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. H.raid[1]  .. " |cffffffffГневион|r\n" else detailedRaidInfo = detailedRaidInfo ..                 H.raid[1]  .. " |cffA0A0A4Гневион|r" .. "\n" end
            if (H.raid[2] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. H.raid[2]  .. " |cffffffffМаут|r\n" else detailedRaidInfo = detailedRaidInfo ..                    H.raid[2]  .. " |cffA0A0A4Маут|r" .. "\n" end
            if (H.raid[3] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. H.raid[3]  .. " |cffffffffПророк Скитра|r\n" else detailedRaidInfo = detailedRaidInfo ..           H.raid[3]  .. " |cffA0A0A4Пророк Скитра|r" .. "\n" end
            if (H.raid[4] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. H.raid[4]  .. " |cffffffffТемный инквизитор Занеш|r\n" else detailedRaidInfo = detailedRaidInfo .. H.raid[4]  .. " |cffA0A0A4Темный инквизитор Занеш|r" .. "\n" end
            if (H.raid[5] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. H.raid[5]  .. " |cffffffffКоллективный разум|r\n" else detailedRaidInfo = detailedRaidInfo ..      H.raid[5]  .. " |cffA0A0A4Коллективный разум|r" .. "\n" end
            if (H.raid[6] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. H.raid[6]  .. " |cffffffffШад'хар ненасытный|r\n" else detailedRaidInfo = detailedRaidInfo ..      H.raid[6]  .. " |cffA0A0A4Шад'хар ненасытный|r" .. "\n" end
            if (H.raid[7] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. H.raid[7]  .. " |cffffffffДест'агат|r\n" else detailedRaidInfo = detailedRaidInfo ..               H.raid[7]  .. " |cffA0A0A4Дест'агат|r" .. "\n" end
            if (H.raid[8] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. H.raid[8]  .. " |cffffffffИл'гинот|r\n" else detailedRaidInfo = detailedRaidInfo ..                H.raid[8]  .. " |cffA0A0A4Ил'гинот|r" .. "\n" end
            if (H.raid[9] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. H.raid[9]  .. " |cffffffffВексиона|r\n" else detailedRaidInfo = detailedRaidInfo ..                H.raid[9]  .. " |cffA0A0A4Вексиона|r" .. "\n" end
            if (H.raid[10] ~= 0) then detailedRaidInfo = detailedRaidInfo .. H.raid[10] .. " |cffffffffРа-ден|r\n" else detailedRaidInfo = detailedRaidInfo ..                  H.raid[10] .. " |cffA0A0A4Ра-ден|r" .. "\n" end
            if (H.raid[11] ~= 0) then detailedRaidInfo = detailedRaidInfo .. H.raid[11] .. " |cffffffffПанцырь Н'зота|r\n" else detailedRaidInfo = detailedRaidInfo ..          H.raid[11] .. " |cffA0A0A4Панцырь Н'зота|r" .. "\n" end
            if (H.raid[12] ~= 0) then detailedRaidInfo = detailedRaidInfo .. H.raid[12] .. " |cffffffffН'зот заразитель|r\n" else detailedRaidInfo = detailedRaidInfo ..        H.raid[12] .. " |cffA0A0A4Н'зот заразитель|r" end
        end
        if currentRaidBest == "M" then
            if (M.raid[1] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. M.raid[1]  .. " |cffffffffГневион|r\n" else detailedRaidInfo = detailedRaidInfo ..                 M.raid[1]  .. " |cffA0A0A4Гневион|r" .. "\n" end
            if (M.raid[2] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. M.raid[2]  .. " |cffffffffМаут|r\n" else detailedRaidInfo = detailedRaidInfo ..                    M.raid[2]  .. " |cffA0A0A4Маут|r" .. "\n" end
            if (M.raid[3] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. M.raid[3]  .. " |cffffffffПророк Скитра|r\n" else detailedRaidInfo = detailedRaidInfo ..           M.raid[3]  .. " |cffA0A0A4Пророк Скитра|r" .. "\n" end
            if (M.raid[4] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. M.raid[4]  .. " |cffffffffТемный инквизитор Занеш|r\n" else detailedRaidInfo = detailedRaidInfo .. M.raid[4]  .. " |cffA0A0A4Темный инквизитор Занеш|r" .. "\n" end
            if (M.raid[5] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. M.raid[5]  .. " |cffffffffКоллективный разум|r\n" else detailedRaidInfo = detailedRaidInfo ..      M.raid[5]  .. " |cffA0A0A4Коллективный разум|r" .. "\n" end
            if (M.raid[6] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. M.raid[6]  .. " |cffffffffШад'хар ненасытный|r\n" else detailedRaidInfo = detailedRaidInfo ..      M.raid[6]  .. " |cffA0A0A4Шад'хар ненасытный|r" .. "\n" end
            if (M.raid[7] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. M.raid[7]  .. " |cffffffffДест'агат|r\n" else detailedRaidInfo = detailedRaidInfo ..               M.raid[7]  .. " |cffA0A0A4Дест'агат|r" .. "\n" end
            if (M.raid[8] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. M.raid[8]  .. " |cffffffffИл'гинот|r\n" else detailedRaidInfo = detailedRaidInfo ..                M.raid[8]  .. " |cffA0A0A4Ил'гинот|r" .. "\n" end
            if (M.raid[9] ~= 0)  then detailedRaidInfo = detailedRaidInfo .. M.raid[9]  .. " |cffffffffВексиона|r\n" else detailedRaidInfo = detailedRaidInfo ..                M.raid[9]  .. " |cffA0A0A4Вексиона|r" .. "\n" end
            if (M.raid[10] ~= 0) then detailedRaidInfo = detailedRaidInfo .. M.raid[10] .. " |cffffffffРа-ден|r\n" else detailedRaidInfo = detailedRaidInfo ..                  M.raid[10] .. " |cffA0A0A4Ра-ден|r" .. "\n" end
            if (M.raid[11] ~= 0) then detailedRaidInfo = detailedRaidInfo .. M.raid[11] .. " |cffffffffПанцырь Н'зота|r\n" else detailedRaidInfo = detailedRaidInfo ..          M.raid[11] .. " |cffA0A0A4Панцырь Н'зота|r" .. "\n" end
            if (M.raid[12] ~= 0) then detailedRaidInfo = detailedRaidInfo .. M.raid[12] .. " |cffffffffН'зот заразитель|r\n" else detailedRaidInfo = detailedRaidInfo ..        M.raid[12] .. " |cffA0A0A4Н'зот заразитель|r" end
        end
        GameTooltip:AddLine("|cffffff00Побеждённые боссы:|r\n" .. detailedRaidInfo)
    end
end
    setDefaultKilledRaidBossesValue()
    ClearAchievementComparisonUnit()
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

        local dungeonName = _info.bestKey:sub(3)
        if (string.match(dungeonName, "(+0)") == nil) then
            dungeonName = string.format("|cffA0A0A4%s|r", _info.bestKey:sub(3))
        end
        if (string.match(dungeonName, "(+1)")) then
            dungeonName = string.format("|cffffffff%s|r", _info.bestKey:sub(3, _info.bestKey:len() - 4) .. STAR_ICON)
        end
        if (string.match(dungeonName, "(+2)")) then
            dungeonName = string.format("|cffffffff%s|r",
                _info.bestKey:sub(3, _info.bestKey:len() - 4) .. STAR_ICON .. STAR_ICON)
        end
        if (string.match(dungeonName, "(+3)")) then
            dungeonName = string.format("|cffffffff%s|r",
                _info.bestKey:sub(3, _info.bestKey:len() - 4) .. STAR_ICON .. STAR_ICON .. STAR_ICON)
        end

        local leaderRecord = string.format("\nРекорд лидера группы:\n" .. "|cff00a000%s|r",
            _info.bestKey:sub(0, 2)) .. dungeonName

        if table.getn(_info.score) > 0 then
            summary = string.format(ROLE_ICONS[string.match(_info.score[1], "%u*")].full ..
                findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers),
                string.match(_info.score[1], '%S+$'))
            if table.getn(_info.score) == 3 then
                summary = summary ..
                    string.format(" " ..
                        ROLE_ICONS[string.match(_info.score[2], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers),
                        string.match(_info.score[2], '%S+$'))
            end
            if table.getn(_info.score) > 3 then
                summary = summary ..
                    string.format(" " ..
                        ROLE_ICONS[string.match(_info.score[3], "%u*")].full ..
                        findClosest(tonumber(string.match(_info.score[3], '%S+$')), scoreTiers),
                        string.match(_info.score[3], '%S+$'))
            end
            self:AddRegion((summary .. leaderRecord), _info, activityID, _prep)
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
                local dungeonName = key:sub(3)
                if (string.match(dungeonName, "+") == nil) then
                    dungeonName = string.format("|cffA0A0A4%s|r", key:sub(3))
                end
                if (string.match(dungeonName, "+") == "+") then
                    if (string.match(dungeonName, "1")) then
                        dungeonName = string.format("|cffffffff%s|r", key:sub(3, key:len() - 2) .. STAR_ICON)
                    end
                    if (string.match(dungeonName, "2")) then
                        dungeonName = string.format("|cffffffff%s|r", key:sub(3, key:len() - 2) .. STAR_ICON .. STAR_ICON)
                    end
                    if (string.match(dungeonName, "3")) then
                        dungeonName = string.format("|cffffffff%s|r",
                            key:sub(3, key:len() - 2) .. STAR_ICON .. STAR_ICON .. STAR_ICON)
                    end
                end
                GameTooltip:AddLine(string.format("|cff00a000%s|r", key:sub(0, 2)) ..
                    dungeonName)
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
            total = string.format("|cffffff00Ключи в таймер:|r |cffe1588e+25-29|r - |cffffffff(%s)|r",
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

        local stars = " "

        if (currentChest == 0) then
            stars = "(+0)"
        end
        if (currentChest == "1") then
            stars = stars .. STAR_ICON
        end
        if (currentChest == "2") then
            stars = stars .. STAR_ICON .. STAR_ICON
        end
        if (currentChest == "3") then
            stars = stars .. STAR_ICON .. STAR_ICON .. STAR_ICON
        end
        GameTooltip:AddLine(string.format("\n----------------------------------\nВаш рекорд в текущем подземелье:\n|cff42aaff%s|r "
            , currentLevel) ..
            string.format("|cffc5d0e6%s|r ", currentBest) .. stars)
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

    local unitName = unitName
    local summary  = ""

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


--Временно отключено из-за конфликтов с выпадающим меню
-- UnitPopupButtons["MM"] = { text = "|cffff8000Прогресс M+Score|r",
--     --dist = 0
-- };
-- table.insert(UnitPopupMenus["FRIEND"], #(UnitPopupMenus["FRIEND"]) - 1, "MM");
-- table.insert(UnitPopupMenus["GUILD"], #(UnitPopupMenus["GUILD"]) - 1, "MM");

-- hooksecurefunc("UnitPopup_OnClick", function(self)
--     local dropdownFrame = UIDROPDOWNMENU_INIT_MENU
--     local button = self.value
--     if button == "MM" then
--         printMythicScoreInfo(dropdownFrame.name)
--     end
-- end)
-- { Wration = 0, Maut = 0, Skitra = 0, Zanesh = 0, Hivemind =0 , Shadhar = 0, Drestagath = 0, Ilgynoth = 0, Vexiona = 0, Raden = 0, Carapace = 0, Nzoth = 0 }

charCheck = CreateFrame("Frame", "charCheck")
charCheck:RegisterEvent("INSPECT_ACHIEVEMENT_READY")

charCheck:SetScript("OnEvent", function(self, event, ...)
    local unitName, unit = GameTooltip:GetUnit()
    
    setDefaultKilledRaidBossesValue()

    LFR.unitName = unitName
    N.unitName = unitName
    H.unitName = unitName
    M.unitName = unitName

    for k, v in pairs(NWC) do
        lfr = GetComparisonStatistic(v[1])
        normal = GetComparisonStatistic(v[2])
        heroic = GetComparisonStatistic(v[3])
        mythic = GetComparisonStatistic(v[4])
        if (lfr ~= "--") then
            LFR.raid[k] = lfr
        end
        if (normal ~= "--") then
            N.raid[k] = normal
        end
        if (heroic ~= "--") then
            H.raid[k] = heroic
        end
        if (mythic ~= "--") then
            M.raid[k] = mythic
        end
    end
    if show == true then 
    getRaidProgress(self, event, ...)
    show = false
    end
end);

function getRaidProgress(self, event, ...) 
    local unitName, unit = GameTooltip:GetUnit()
    if GameTooltip:IsShown() then 
    GameTooltip:SetUnit(unit)
    show = false
    end
end

function setDefaultKilledRaidBossesValue()
    LFR.unitName = " "
    N.unitName = " "
    H.unitName = " "
    M.unitName = " "

    for k, v in pairs(NWC) do
            LFR.raid[k] = 0
            N.raid[k] = 0
            H.raid[k] = 0
            M.raid[k] = 0
    end
end
