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

local function F()

    local _unitName = UnitName("mouseover")
    local tooltip = GameTooltip

    if tooltip:IsShown() then
        local _prep = getCharacterIdByName(_unitName)
        if _prep ~= nil then
        local _info = getMythicScore(_prep[1])
        
        if table.getn(_info.score) > 0 then
            if table.getn(_info.score) == 1 then
                
                tooltip:AddLine(string.format("M+ Score: " .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), _info.score[1]) .. 
                string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3))))
            end
            if table.getn(_info.score) == 2 then
                tooltip:AddLine(string.format("M+ Score: " .. _info.score[1]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) .. 
                                string.format(" " .. _info.score[2]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers), string.match(_info.score[2], '%S+$')) 
                                .. 
                                string.format("\nBest run: |cff00a000%s|r", _info.bestKey:sub(0,2)) ..  
                                string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                            )
                tooltip:Show()
            end
            if table.getn(_info.score) == 3 then
                tooltip:AddLine(string.format("M+ Score: " .. _info.score[1]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) .. 
                                string.format(" " .. _info.score[2]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers), string.match(_info.score[2], '%S+$')) ..
                                string.format(" " .. _info.score[3]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[3], '%S+$')), scoreTiers),string.match(_info.score[3], '%S+$')) 
                                .. 
                                string.format("\nBest run: |cff00a000%s|r", _info.bestKey:sub(0,2)) ..  
                                string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                            )
                tooltip:Show()
            end
            if table.getn(_info.score) == 4 then
                tooltip:AddLine(string.format("M+ Score: " .. _info.score[1]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) .. 
                                string.format(" " .. _info.score[2]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers), string.match(_info.score[2], '%S+$')) ..
                                string.format(" " .. _info.score[3]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[3], '%S+$')), scoreTiers), string.match(_info.score[3], '%S+$')) ..
                                string.format(" " .. _info.score[4]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[4], '%S+$')), scoreTiers), string.match(_info.score[4], '%S+$')) 
                                .. 
                                string.format("\nBest run: |cff00a000%s|r", _info.bestKey:sub(0,2)) ..  
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

local _, LFGRegion = ...

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

            if table.getn(_info.score) > 0 then
                if table.getn(_info.score) == 1 then
                    self:AddRegion(string.format(_info.score[1]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) ..
                                   string.format("\nBest run: |cff00a000%s|r", _info.bestKey:sub(0,2)) .. 
                                   string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3))))
                end
                if table.getn(_info.score) == 2 then
                    self:AddRegion(string.format(_info.score[1]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) .. 
                    string.format(" " .. _info.score[2]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers), string.match(_info.score[2], '%S+$'))
                    .. 
                    string.format("\nBest run: |cff00a000%s|r", _info.bestKey:sub(0,2)) .. 
                    string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                 )
                end
                if table.getn(_info.score) == 3 then
                    self:AddRegion(string.format(_info.score[1]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) .. 
                                   string.format(" " .. _info.score[2]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers), string.match(_info.score[2], '%S+$')) ..
                                   string.format(" " .. _info.score[3]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[3], '%S+$')), scoreTiers), string.match(_info.score[3], '%S+$')) 
                                   .. 
                                   string.format("\nBest run: |cff00a000%s|r", _info.bestKey:sub(0,2)) .. 
                                   string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3)))
                                )
                end
                if table.getn(_info.score) == 4 then
                    self:AddRegion(string.format(_info.score[1]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[1], '%S+$')), scoreTiers), string.match(_info.score[1], '%S+$')) .. 
                                   tring.format(" " .. _info.score[2]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[2], '%S+$')), scoreTiers), string.match(_info.score[2], '%S+$')) ..
                                   tring.format(" " .. _info.score[3]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[3], '%S+$')), scoreTiers), string.match(_info.score[3], '%S+$')) ..
                                   tring.format(" " .. _info.score[4]:gsub('%d',''):gsub('%s','') .. findClosest(tonumber(string.match(_info.score[4], '%S+$')), scoreTiers), string.match(_info.score[4], '%S+$')) .. 
                                   string.format("\nBest run: |cff00a000%s|r", _info.bestKey:sub(0,2)) .. 
                                   string.format(string.format("|cffffffff%s|r", _info.bestKey:sub(3))))
                end
            end
            -- if table.getn(_info.score) == 0 then
            --     self:AddRegion(string.format("|cffffffff%s|r", "No info"))
            -- end
    end
        if _prep == nil then
                self:AddRegion(string.format("|cffffffff%s|r", "No info"))
        end

end

function LFGRegionMixin:AddRegion(_info)
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(string.format("M+ Score: %s", _info))
    GameTooltip:Show()
end