local config = {
    actionId = 18562, -- on lever
    lever = {
        left = 2772,
        right = 2773
    },
    playItem = {
        itemId = 49608, -- item required to pull lever
        count = 1
    },
    rouletteOptions = {
        rareItemChance_broadcastThreshold = 500,
        ignoredItems = {1617}, -- if you have tables/counters/other items on the roulette tiles, add them here
        winEffects = {CONST_ANI_FIRE, CONST_ME_SOUND_YELLOW, CONST_ME_SOUND_PURPLE, CONST_ME_SOUND_BLUE, CONST_ME_SOUND_WHITE}, -- first effect needs to be distance effect
        effectDelay = 333,
        spinTime = {min = 8, max = 12}, -- seconds
        spinSlowdownRamping = 5,
        rouletteStorage = 48550 -- required storage to avoid player abuse (if they logout/die before roulette finishes.. they can spin again for free)
    },
    prizePool = {
        {itemId = 49628, count = {1, 1},   chance = 7500}, -- special sparkles (blue)
        {itemId = 49632, count = {1, 1},   chance = 7500}, -- divine sparkles (blue)
        {itemId = 49636, count = {1, 1},   chance = 7500}, -- mystic sparkles (blue)
        {itemId = 49616, count = {1, 1},    chance = 7500 }, -- bless scroll 
        {itemId = 49604, count = {1, 1},    chance = 7500 }, -- rubini backpack
        {itemId = 49606, count = {1, 1},    chance = 7500 }, -- eskeletinho backpack
        {itemId = 49605, count = {1, 1},    chance = 7500 }, -- guildbank backpack
        {itemId = 49614, count = {1, 1},    chance = 6000 }, -- ratmiral chest
        {itemId = 49610, count = {1, 1},    chance = 5000 }, -- cobra chest
        {itemId = 49611, count = {1, 1},    chance = 5000 }, -- drume chest
        {itemId = 49612, count = {1, 1},    chance = 5000 }, -- timira chest
        {itemId = 49607, count = {1, 1},    chance = 5000 }, -- mystic bag
        {itemId = 49609, count = {1, 1},    chance = 4000 }, -- oberon chest
        {itemId = 49869, count = {1, 1},    chance = 4000  },  -- vip scroll
        {itemId = 49756, count = {1, 1},    chance = 4000  },  -- vip scroll
        {itemId = 49622, count = {1, 1},   chance = 1000 }, -- Rubini dummy 
        {itemId = 49641, count = {1, 1}, chance = 1000 } -- nephilin wings
    },
    roulettePositions = {
        Position(31916, 32391, 4),
        Position(31917, 32391, 4),
        Position(31918, 32391, 4),
        Position(31919, 32391, 4), -- position 4 in this list is hard-coded to be the reward location, which is the item given to the player
        Position(31920, 32391, 4),
        Position(31921, 32391, 4),
        Position(31922, 32391, 4),
    }
}

local function sendDiscordLog(player, item, count)
    local message = ":game_die: **" .. player:getName() .. "** won **" .. count .. "x " .. ItemType(item):getName() .. "** from the EK Roulette!"
    Webhook.sendMessage(message, announcementChannels["log-roullets"]) -- Certifique-se de que "roulette-logs" é o canal correto.
end

local function addVipDaysToPlayer(player, days)
    if not configManager.getBoolean(configKeys.VIP_SYSTEM_ENABLED) then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "VIP System is not enabled.")
        return false
    end

    player:addPremiumDays(days)
    player:onAddVip(days)
    player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You received " .. days .. " VIP day(s)!")
    return true
end

local chancedItems = {} -- used for broadcast. don't edit

local function resetLever(position)
    local lever = Tile(position):getItemById(config.lever.right)
    lever:transform(config.lever.left)
end

local function updateRoulette(newItemInfo)
    local positions = config.roulettePositions
    for i = #positions, 1, -1 do
        local item = Tile(positions[i]):getTopVisibleThing()
        if item and item:getId() ~= Tile(positions[i]):getGround():getId() and not table.contains(config.rouletteOptions.ignoredItems, item:getId()) then
            if i ~= 7 then
                item:moveTo(positions[i + 1])
            else
                item:remove()
            end
        end
    end
    if ItemType(newItemInfo.itemId):getCharges() then
        local item = Game.createItem(newItemInfo.itemId, 1, positions[1])
        item:setAttribute("charges", newItemInfo.count)
    else
        Game.createItem(newItemInfo.itemId, newItemInfo.count, positions[1])
    end
end

local function clearRoulette(newItemInfo)
    local positions = config.roulettePositions
    for i = #positions, 1, -1 do
        local item = Tile(positions[i]):getTopVisibleThing()
        if item and item:getId() ~= Tile(positions[i]):getGround():getId() and not table.contains(config.rouletteOptions.ignoredItems, item:getId()) then
            item:remove()
        end
        if newItemInfo == nil then
            positions[i]:sendMagicEffect(CONST_ME_POFF)
        else
            if ItemType(newItemInfo.itemId):getCharges() then
                local item = Game.createItem(newItemInfo.itemId, 1, positions[i])
                item:setAttribute("charges", newItemInfo.count)
            else
                Game.createItem(newItemInfo.itemId, newItemInfo.count, positions[i])
            end
        end
    end
end

local function chanceNewReward()
    local newItemInfo = {itemId = 0, count = 0}
    local rewardTable = {}
    while #rewardTable < 1 do
        for i = 1, #config.prizePool do
            if config.prizePool[i].chance >= math.random(10000) then
                rewardTable[#rewardTable + 1] = i
            end
        end
    end
    local rand = math.random(#rewardTable)
    newItemInfo.itemId = config.prizePool[rewardTable[rand]].itemId
    newItemInfo.count = math.random(config.prizePool[rewardTable[rand]].count[1], config.prizePool[rewardTable[rand]].count[2])
    chancedItems[#chancedItems + 1] = config.prizePool[rewardTable[rand]].chance
    return newItemInfo
end

local function initiateReward(leverPosition, effectCounter)
    if effectCounter < #config.rouletteOptions.winEffects then
        effectCounter = effectCounter + 1
        if effectCounter == 1 then
            config.roulettePositions[1]:sendDistanceEffect(config.roulettePositions[4], config.rouletteOptions.winEffects[1])
            config.roulettePositions[7]:sendDistanceEffect(config.roulettePositions[4], config.rouletteOptions.winEffects[1])
        else
            for i = 1, #config.roulettePositions do
                config.roulettePositions[i]:sendMagicEffect(config.rouletteOptions.winEffects[effectCounter])
            end
        end
        if effectCounter == 2 then
            local item = Tile(config.roulettePositions[4]):getTopVisibleThing()
            local newItemInfo = {itemId = item:getId(), count = item:getCount()}
            clearRoulette(newItemInfo)
        end
        addEvent(initiateReward, config.rouletteOptions.effectDelay, leverPosition, effectCounter)
        return
    end
    resetLever(leverPosition)
end

local function rewardPlayer(playerId, leverPosition)
    local player = Player(playerId)
    if not player then
        return
    end

    local item = Tile(config.roulettePositions[4]):getTopVisibleThing()

    -- Verifica se o item é o Charm Scroll
    if item:getId() == 49756 then -- Substitua pelo ID do Charm Scroll
        local charmPoints = 500
        player:addCharmPoints(charmPoints)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You received " .. charmPoints .. " charm points!")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        Game.broadcastMessage("The player " .. player:getName() .. " has won " .. charmPoints .. " charm points from the roulette!", MESSAGE_EVENT_ADVANCE)
        sendDiscordLog(player, 49756, charmPoints)

    -- Verifica se o item é o VIP Scroll
    elseif item:getId() == 49869 then -- Substitua pelo ID do VIP Scroll
        local vipDays = 30
        addVipDaysToPlayer(player, vipDays)
        Game.broadcastMessage("The player " .. player:getName() .. " has won " .. vipDays .. " VIP days from the roulette!", MESSAGE_EVENT_ADVANCE)
        sendDiscordLog(player, 49869, vipDays)

    -- Recompensa normal (itens padrão)
    else
        if ItemType(item:getId()):getCharges() then
            local addedItem = player:addItem(item:getId(), 1, true)
            addedItem:setAttribute("charges", item:getCharges())
            sendDiscordLog(player, item:getId(), item:getCharges())
        else
            player:addItem(item:getId(), item:getCount(), true)
            sendDiscordLog(player, item:getId(), item:getCount())
        end

        if chancedItems[#chancedItems - 3] <= config.rouletteOptions.rareItemChance_broadcastThreshold then
            Game.broadcastMessage("The player " .. player:getName() .. " has won " .. item:getName() .. " from the roulette!", MESSAGE_EVENT_ADVANCE)
        end
    end

    player:setStorageValue(config.rouletteOptions.rouletteStorage, -1)
end



local function roulette(playerId, leverPosition, spinTimeRemaining, spinDelay)
    local player = Player(playerId)
    if not player then
        resetLever(leverPosition)
        return
    end
    local newItemInfo = chanceNewReward()
    updateRoulette(newItemInfo)
    if spinTimeRemaining > 0 then
        spinDelay = spinDelay + config.rouletteOptions.spinSlowdownRamping
        addEvent(roulette, spinDelay, playerId, leverPosition, spinTimeRemaining - (spinDelay - config.rouletteOptions.spinSlowdownRamping), spinDelay)
        return
    end
    initiateReward(leverPosition, 0)
    rewardPlayer(playerId, leverPosition)
end

local casinoRoulette = Action()

function casinoRoulette.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getId() == config.lever.right then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Casino Roulette is currently in progress. Please wait.")
        return true
    end
    if player:getItemCount(config.playItem.itemId) < config.playItem.count then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need " .. config.playItem.count .. "x " .. (ItemType(config.playItem.itemId):getName()) .. " to play the roulette.")
        return true
    end
    item:transform(config.lever.right)
    clearRoulette()
    chancedItems = {}
    player:removeItem(config.playItem.itemId, config.playItem.count)
    player:setStorageValue(config.rouletteOptions.rouletteStorage, 1)
    local spinTimeRemaining = math.random((config.rouletteOptions.spinTime.min * 1000), (config.rouletteOptions.spinTime.max * 1000))
    roulette(player:getId(), toPosition, spinTimeRemaining, 100)
    return true
end

casinoRoulette:aid(config.actionId)
casinoRoulette:register()

local disableMovingItemsToRoulettePositions = MoveEvent()

disableMovingItemsToRoulettePositions.onAddItem = function(moveitem, tileitem, position, item, count, fromPosition, toPosition)
    for _, k in ipairs(config.roulettePositions) do
        if toPosition == k then
            return false
        end
    end
    return true
end

disableMovingItemsToRoulettePositions:position(config.roulettePositions)
disableMovingItemsToRoulettePositions:register()
