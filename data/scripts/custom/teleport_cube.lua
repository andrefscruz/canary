local supremeCube = Action()

local config = {
    vip = {
        pricePerLevel = 25, -- Preço por nível para VIPs
        cooldown = 30, -- Cooldown em segundos para VIPs
        maxPrice = 5000, -- Preço máximo para VIPs
    },
    nonVip = {
        pricePerLevel = 50, -- Preço por nível para não VIPs
        cooldown = 60, -- Cooldown em segundos para não VIPs
        maxPrice = 10000, -- Preço máximo para não VIPs
    },
    storage = 9008,
    minLevelForCharge = 100, -- Nível mínimo para começar a cobrar
    towns = {
        ["Temple Cities"] = {
            { name = "Thais", teleport = Position(32369, 32241, 7) },
            { name = "Carlin", teleport = Position(32360, 31782, 7) },
            { name = "Venore", teleport = Position(32957, 32076, 7) },
            { name = "Ab'Dendriel", teleport = Position(32732, 31634, 7) },
            { name = "Port Hope", teleport = Position(32594, 32745, 7) },
            { name = "Ankrahmun", teleport = Position(33194, 32853, 8) },
            { name = "Darashia", teleport = Position(33213, 32454, 1) },
            { name = "Krailos", teleport = Position(33657, 31665, 8) },
            { name = "Kazordoon", teleport = Position(32649, 31925, 11) },
            { name = "Svargrond", teleport = Position(32212, 31132, 7) },
            { name = "Farmine", teleport = Position(33023, 31521, 11) },
        },
        ["Others"] = {
            { name = "Adventure's Hall", teleport = Position(32200, 32296, 7) },
            { name = "Online Trainer Room", teleport = Position(32190, 32297, 6) },
            { name = "Roullet Hall", teleport = Position(31919, 32397, 4) },
        },
    }
}

local function supremeCubeMessage(player, effect, message)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
    player:getPosition():sendMagicEffect(effect)
end

local function calculateCost(player)
    local level = player:getLevel()
    if level < config.minLevelForCharge then
        return 0 -- Sem custo para jogadores abaixo do nível mínimo
    end

    local isVip = player:isVip()
    local pricePerLevel = isVip and config.vip.pricePerLevel or config.nonVip.pricePerLevel
    local maxPrice = isVip and config.vip.maxPrice or config.nonVip.maxPrice
    return math.min(pricePerLevel * level, maxPrice)
end

local function handleTeleport(player, town, price, cooldown)
    if player:getMoney() + player:getBankBalance() < price then
        supremeCubeMessage(player, CONST_ME_POFF, "You don't have enough money. You need " .. price .. " gold.")
        return false
    end

    if player:getStorageValue(config.storage) > os.time() then
        local remainingTime = player:getStorageValue(config.storage) - os.time()
        supremeCubeMessage(player, CONST_ME_POFF, "You can use it again in: " .. remainingTime .. " seconds.")
        return false
    end

    player:teleportTo(town.teleport, true)
    player:removeMoneyBank(price)
    player:setStorageValue(config.storage, os.time() + cooldown)
    supremeCubeMessage(player, CONST_ME_TELEPORT, "Welcome to " .. town.name .. "! You were charged " .. price .. " gold.")
    return true
end

local function showTownListModal(player, category, price, cooldown)
    local townWindow = ModalWindow({
        title = "Select a City",
        message = "Choose a city to teleport to - Price: " .. price .. " gold.",
    })

    for _, town in ipairs(config.towns[category]) do
        townWindow:addChoice(town.name, function(player, button, choice)
            if button.name == "Select" then
                handleTeleport(player, town, price, cooldown)
            end
            return true
        end)
    end

    -- townWindow:addButton("Back", function(player, button, choice)
    --     if button.name == "Back" then
    --         showCategoryModal(player)
    --     end
    --     return true
    -- end)

    townWindow:addButton("Select")
    townWindow:addButton("Close")
    townWindow:setDefaultEnterButton(0)
    townWindow:setDefaultEscapeButton(1)
    townWindow:sendToPlayer(player)
end

local function showCategoryModal(player)
    local price = calculateCost(player)
    local isVip = player:isVip()
    local cooldown = isVip and config.vip.cooldown or config.nonVip.cooldown

    local categoryWindow = ModalWindow({
        title = "Select a Category",
        message = "Choose a category of cities:",
    })

    for category, _ in pairs(config.towns) do
        categoryWindow:addChoice(category, function(player, button, choice)
            if button.name == "Select" then
                showTownListModal(player, choice.text, price, cooldown)
            end
            return true
        end)
    end

    categoryWindow:addButton("Select")
    categoryWindow:addButton("Close")
    categoryWindow:setDefaultEnterButton(0)
    categoryWindow:setDefaultEscapeButton(1)
    categoryWindow:sendToPlayer(player)
end

function supremeCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local inPz = player:getTile():hasFlag(TILESTATE_PROTECTIONZONE)
    local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)

    if not inPz and inFight then
        supremeCubeMessage(player, CONST_ME_POFF, "You can't use this when you're in a fight.")
        return false
    end

    showCategoryModal(player)
    return true
end

supremeCube:id(37111)
supremeCube:register()
