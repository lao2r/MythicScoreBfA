function getCharacterIdByName(name)
    return library[name]
end

function getMythicScore(hero_ID)
    return characters[hero_ID]
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

ROLE_ICONS = {
    dps = {
        full = "|TInterface\\AddOns\\M+ScoreCircleBfA\\icons\\roles:14:14:0:0:64:64:0:18:0:18|t",
        partial = "|TInterface\\AddOns\\M+ScoreCircleBfA\\icons\\roles:14:14:0:0:64:64:0:18:36:54|t"
    },
    healer = {
        full = "|TInterface\\AddOns\\M+ScoreCircleBfA\\icons\\roles:14:14:0:0:64:64:19:37:0:18|t",
        partial = "|TInterface\\AddOns\\M+ScoreCircleBfA\\icons\\roles:14:14:0:0:64:64:19:37:36:54|t"
    },
    tank = {
        full = "|TInterface\\AddOns\\M+ScoreCircleBfA\\icons\\roles:14:14:0:0:64:64:38:56:0:18|t",
        partial	= "|TInterface\\AddOns\\M+ScoreCircleBfA\\icons\\roles:14:14:0:0:64:64:38:56:36:54|t"
    }
}

local function F()

    local _unitName = UnitName("mouseover")
    local tooltip = GameTooltip

    if tooltip:IsShown() then
        local _prep = getCharacterIdByName(_unitName)
        if _prep ~= nil then
        local _info = getMythicScore(_prep[1])
        local _role, _role2, _role3

        if table.getn(_info.score) > 0 then
            if table.getn(_info.score) == 1 then
                tooltip:AddLine(string.format("M+ Score: " .. _info.score[1]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), _info.score[1]) .. 
                string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3))))
            end
            if table.getn(_info.score) == 2 then
                if (string.match(_info.score[1], "DPS")) then
                    _role = ROLE_ICONS.dps.full
                end
                if (string.match(_info.score[1], "TANK")) then
                    _role = ROLE_ICONS.tank.full
                end
                if (string.match(_info.score[1], "HEALER")) then
                    _role = ROLE_ICONS.healer.full
                end
                tooltip:AddLine(string.format("M+ Score: " .. _role .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) .. 
                                -- string.format(" " .. _info.score[2]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers), string.match(_info.score[2], '%S+$')) 
                                -- .. 
                                string.format("\nЛучший за сезон: |cff00a000%s|r", _info.bestKey:sub(0,2)) ..  
                                string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                            )
                                           
                tooltip:Show()
            end
            if table.getn(_info.score) == 3 then
                if (string.match(_info.score[1], "DPS")) then
                    _role = ROLE_ICONS.dps.full
                end
                if (string.match(_info.score[1], "TANK")) then
                    _role = ROLE_ICONS.tank.full
                end
                if (string.match(_info.score[1], "HEALER")) then
                    _role = ROLE_ICONS.healer.full
                end 
                if (string.match(_info.score[2], "DPS")) then
                    _role2 = ROLE_ICONS.dps.full
                end
                if (string.match(_info.score[2], "TANK")) then
                    _role2 = ROLE_ICONS.tank.full
                end
                if (string.match(_info.score[2], "HEALER")) then
                    _role2 = ROLE_ICONS.healer.full
                end 
                tooltip:AddLine(string.format("M+ Score: " .. _role .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) .. 
                                string.format(" " .. _role2 .. findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers), string.match(_info.score[2], '%S+$')) ..
                                -- string.format(" " .. _info.score[3]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[3], '%S+$')), scoreTiers),string.match(_info.score[3], '%S+$')) 
                                -- .. 
                                string.format("\nЛучший за сезон: |cff00a000%s|r", _info.bestKey:sub(0,2)) ..  
                                string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                            )
                tooltip:Show()
            end
            if table.getn(_info.score) == 4 then
                if (string.match(_info.score[1], "DPS")) then
                    _role = ROLE_ICONS.dps.full
                end
                if (string.match(_info.score[1], "TANK")) then
                    _role = ROLE_ICONS.tank.full
                end
                if (string.match(_info.score[1], "HEALER")) then
                    _role = ROLE_ICONS.healer.full
                end 
                if (string.match(_info.score[2], "DPS")) then
                    _role2 = ROLE_ICONS.dps.full
                end
                if (string.match(_info.score[2], "TANK")) then
                    _role2 = ROLE_ICONS.tank.full
                end
                if (string.match(_info.score[2], "HEALER")) then
                    _role2 = ROLE_ICONS.healer.full
                end 
                if (string.match(_info.score[3], "DPS")) then
                    _role3 = ROLE_ICONS.dps.full
                end
                if (string.match(_info.score[3], "TANK")) then
                    _role3 = ROLE_ICONS.tank.full
                end
                if (string.match(_info.score[3], "HEALER")) then
                    _role3 = ROLE_ICONS.healer.full
                end 
                tooltip:AddLine(string.format("M+ Score: " .. _role .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) .. 
                                string.format(" " .. _role2 .. findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers), string.match(_info.score[2], '%S+$')) ..
                                string.format(" " .. _role3 .. findClosest(tonumber(string.match(_info.score[3], '%S+$')), scoreTiers), string.match(_info.score[3], '%S+$')) ..
                                -- string.format(" " .. _info.score[4]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[4], '%S+$')), scoreTiers), string.match(_info.score[4], '%S+$')) 
                                -- .. 
                                string.format("\nЛучший за сезон: |cff00a000%s|r", _info.bestKey:sub(0,2)) ..  
                                string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3))))
                tooltip:Show()
            end
        end
        if table.getn(_info.score) == (0 or nil) then
            if UnitIsPlayer("mouseover") then
            tooltip:AddLine(string.format("M+ Score: |cffffffff%s|r", "No info"))
            tooltip:Show()
            end
        end
    end
        if _prep == nil then
            if UnitIsPlayer("mouseover") then
            tooltip:AddLine(string.format("M+ Score: |cffffffff%s|r", "No info"))
            tooltip:Show()
            end
        end
    end

end

local frame = CreateFrame("frame");
frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
frame:SetScript("OnEvent", F)

LFGRegionMixin = {}

function LFGRegionMixin:OnLoad()
    self:Initialize()
end

function LFGRegionMixin:Initialize()
    local function SetSearchEntryTooltip(_, resultID)
        local info = C_LFGList.GetSearchResultInfo(resultID)
        if ( info.leaderName ) then
            self:CheckMythicScore(info.leaderName)
        end
    end

    hooksecurefunc("LFGListUtil_SetSearchEntryTooltip", SetSearchEntryTooltip)
end

function LFGRegionMixin:CheckMythicScore(leaderName)
    local _prep = getCharacterIdByName(leaderName)
    if _prep ~= nil then
    local _info = getMythicScore(_prep[1])
    local _role, _role2, _role3

            if table.getn(_info.score) > 0 then
                if table.getn(_info.score) == 1 then
                    self:AddRegion(string.format(_info.score[1]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) ..
                                   string.format("\nЛучший за сезон: |cff00a000%s|r", _info.bestKey:sub(0,2)) .. 
                                   string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3))), _info)
                end
                if table.getn(_info.score) == 2 then
                    if (string.match(_info.score[1], "DPS")) then
                        _role = ROLE_ICONS.dps.full
                    end
                    if (string.match(_info.score[1], "TANK")) then
                        _role = ROLE_ICONS.tank.full
                    end
                    if (string.match(_info.score[1], "HEALER")) then
                        _role = ROLE_ICONS.healer.full
                    end 
                    self:AddRegion(string.format(_role .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) .. 
                    -- string.format(" " .. _info.score[2]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers), string.match(_info.score[2], '%S+$')) .. 
                    string.format("\nЛучший за сезон: |cff00a000%s|r", "\n" .. _info.bestKey:sub(0,2)) .. 
                    string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3))), _info)

                end
                if table.getn(_info.score) == 3 then
                    if (string.match(_info.score[1], "DPS")) then
                        _role = ROLE_ICONS.dps.full
                    end
                    if (string.match(_info.score[1], "TANK")) then
                        _role = ROLE_ICONS.tank.full
                    end
                    if (string.match(_info.score[1], "HEALER")) then
                        _role = ROLE_ICONS.healer.full
                    end 
                    if (string.match(_info.score[2], "DPS")) then
                        _role2 = ROLE_ICONS.dps.full
                    end
                    if (string.match(_info.score[2], "TANK")) then
                        _role2 = ROLE_ICONS.tank.full
                    end
                    if (string.match(_info.score[2], "HEALER")) then
                        _role2 = ROLE_ICONS.healer.full
                    end 
                    self:AddRegion(string.format(_role .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) .. 
                                   string.format(" " .. _role2 .. findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers), string.match(_info.score[2], '%S+$')) ..
                                --    string.format(" " .. _info.score[3]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[3], '%S+$')), scoreTiers), string.match(_info.score[3], '%S+$')) .. 
                                   string.format("\nЛучший за сезон: |cff00a000%s|r", "\n" .. _info.bestKey:sub(0,2)) .. 
                                   string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3))), _info)
                end
                if table.getn(_info.score) == 4 then
                    if (string.match(_info.score[1], "DPS")) then
                        _role = ROLE_ICONS.dps.full
                    end
                    if (string.match(_info.score[1], "TANK")) then
                        _role = ROLE_ICONS.tank.full
                    end
                    if (string.match(_info.score[1], "HEALER")) then
                        _role = ROLE_ICONS.healer.full
                    end 
                    if (string.match(_info.score[2], "DPS")) then
                        _role2 = ROLE_ICONS.dps.full
                    end
                    if (string.match(_info.score[2], "TANK")) then
                        _role2 = ROLE_ICONS.tank.full
                    end
                    if (string.match(_info.score[2], "HEALER")) then
                        _role2 = ROLE_ICONS.healer.full
                    end 
                    if (string.match(_info.score[3], "DPS")) then
                        _role2 = ROLE_ICONS.dps.full
                    end
                    if (string.match(_info.score[3], "TANK")) then
                        _role2 = ROLE_ICONS.tank.full
                    end
                    if (string.match(_info.score[3], "HEALER")) then
                        _role2 = ROLE_ICONS.healer.full
                    end 
                    self:AddRegion(string.format(_role .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) .. 
                                   string.format(" " .. _role2 .. findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers), string.match(_info.score[2], '%S+$')) ..
                                   string.format(" " .. _role3 .. findClosest(tonumber(string.match(_info.score[3], '%S+$')), scoreTiers), string.match(_info.score[3], '%S+$')) ..
                                --    string.format(" " .. _info.score[4]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[4], '%S+$')), scoreTiers), string.match(_info.score[4], '%S+$')) .. 
                                   string.format("\nЛучший за сезон: |cff00a000%s|r", "\n" .. _info.bestKey:sub(0,2)) .. 
                                   string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3))), _info)
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

function LFGRegionMixin:AddRegion(_score, _info)
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(string.format("M+ Score: %s", _score))
    GameTooltip:Show()

    if (table.getn(_info.key_ru) > 0) then
        GameTooltip:AddLine("\nЛучшие прохождения:")
        for _, key in ipairs(_info.key_ru) do
            GameTooltip:AddLine(string.format("|cff00a000%s|r", key:sub(0,2)) ..  
            string.format(string.format("|cffffffff%s|r", key:sub(3))))
        end
    end
    GameTooltip:Show()
end
    