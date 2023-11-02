local playerId = UnitGUID("player")

local playerBest = {
  -- список подземелий и лучших результатов игрока
} 

local playerTotal = {
  -- общее количество пройденных подземелий по уровням
}

local raidProgress = {
  -- прогресс рейда
}

local scoreTiers = {
  -- пороговые значения счетчика для определения цвета
}

local dungeonInfo = {
  -- информация о всех подземельях
}

local classColors = {
  -- цвета классов 
}

local ROLE_ICONS = {
  -- иконки ролей
}

local STAR_ICON = "" -- иконка звезды

-- Функции

local function getPlayerBestKey(dungeonId)
  -- возвращает лучший результат игрока в подземелье
end

local function getPlayerTotalCount(tier)
  -- возвращает общее кол-во подземелий пройденных игроком в таймер по уровню
end

local function getDungeonInfo(key)
  -- возвращает информацию о подземелье по ключу
end

local function getDungeonNameWithStars(key)
  -- возвращает название подземелья с иконками звезд в зависимости от уровня ключа 
end

local function getRoleIcon(role)
  -- возвращает иконку роли
end

local function getClassColor(class)
  -- возвращает цвет класса
end

local function getRaidProgress()
  -- возвращает прогресс рейда
end

local function findClosestTier(score)
  -- находит ближайший пороговый уровень для отображения цвета счетчика 
end

-- Отображение информации в подсказке

local function addPlayerBestLines()
  -- добавляет строки с лучшими ключами игрока
end

local function addPlayerTotalLines()
  -- добавляет строки с общим кол-вом подземелий в таймер
end 

local function addRaidProgressLines()
  -- добавляет строки с прогрессом рейда
end

local function addScoreLines(scores)
  -- добавляет строки со счетчиками
end

local function addNoInfoLine()
  -- добавляет строку с сообщением "Нет информации"
end

-- Основная логика

local function refreshTooltip(unit)

  local playerInfo = getPlayerInfo(unit)
  
  if playerInfo then
  
    GameTooltip:AddLine(" ")
    
    addPlayerBestLines()    
    addPlayerTotalLines()
    addRaidProgressLines()
    
    if #playerInfo.scores > 0 then
    
      addScoreLines(playerInfo.scores)
      
    else
    
      addNoInfoLine()
    
    end

  else

    addNoInfoLine()
  
  end
  
end

-- Инициализация

GameTooltip:HookScript("OnTooltipSetUnit", function()

  refreshTooltip(unit)
  
end)