local supremeBossCube = Action()

local config = {
    vip = {
        pricePerLevel = 25, -- Preço por nível para VIPs
        cooldown = 2, -- Cooldown em segundos para VIPs
        maxPrice = 25000, -- Preço máximo para VIPs
    },
    nonVip = {
        pricePerLevel = 50, -- Preço por nível para não VIPs
        cooldown = 60, -- Cooldown em segundos para não VIPs
        maxPrice = 40000, -- Preço máximo para não VIPs
    },
    storage = 9007,
    minLevelForCharge = 100, -- Nível mínimo para começar a cobrar
    towns = {
        ["Cults"] = {
            { name = "Essence Of Malice", teleport = Position(33095, 31950, 15) },
            { name = "The False God", teleport = Position(33164, 31895, 15) },
            { name = "The Sandking", teleport = Position(33509, 32230, 10) },
            { name = "The Souldespoiler", teleport = Position(33130, 31894, 15) },
            { name = "The Source Of Corruption", teleport = Position(33078, 31886, 15) },
            { name = "The Unarmored Voidborn", teleport = Position(33164, 31865, 15) },
            { name = "Ravenous Hunger", teleport = Position(33138, 31949, 15) },
        },
       ["Dream Courts"] = {
            { name = "The Nightmare Beast", teleport = Position(32212, 32073, 15) },
        },
       ["Dukes"] = {
            { name = "Count Vlarkorth", teleport = Position(33456, 31408, 13) },
            { name = "Duke Krule", teleport = Position(33456, 31497, 13) },
            { name = "Earl Osam", teleport = Position(33517, 31440, 13) },
            { name = "King Zelos", teleport = Position(33490, 31546, 13) },
            { name = "Lord Azaram", teleport = Position(33423, 31497, 13) },
            { name = "Sir Baeloc", teleport = Position(33426, 31408, 13) },
            { name = "Sir Nictros", teleport = Position(33426, 31408, 13) },
        },
       ["Feaster of Souls"] = {
            { name = "Brain Head", teleport = Position(31973, 32326, 10) },
            { name = "Brokul", teleport = Position(33522, 31468, 15) },
            { name = "Faceless Bane", teleport = Position(33637, 32559, 13) },
            { name = "Irgix the Flimsy", teleport = Position(33492, 31400, 8) },
            { name = "The Dread Maiden", teleport = Position(33746, 31506, 14) },
            { name = "The Fear Feaster", teleport = Position(33741, 31471, 14) },
            { name = "The Pale Worm", teleport = Position(33779, 31504, 14) },
            { name = "The Unwelcome", teleport = Position(33744, 31537, 14) },
            { name = "Unaz the Mean", teleport = Position(33566, 31477, 8) },
            { name = "Vok the Freakish", teleport = Position(33509, 31452, 9) },
        },
        ["Ferumbras"] = {
            { name = "Mazoran", teleport = Position(33593, 32651, 14) },
            { name = "Plagirath", teleport = Position(33229, 31496, 13) },
            { name = "Ragiaz", teleport = Position(33458, 32359, 13) },
            { name = "Razzagorn", teleport = Position(33382, 32455, 14) },
            { name = "Shulgrax", teleport = Position(33434, 32792, 13) },
            { name = "Tarbaz", teleport = Position(33421, 32851, 11) },
            { name = "Zamulosh", teleport = Position(33682, 32741, 11) },
        },
        ["Last Ferumbras"] = {
            { name = "Ferumbras' Ascendant", teleport = Position(33266, 31479, 14) },
        },
        ["First Dragon"] = {
            { name = "Gelidrazah the Frozen", teleport = Position(32278, 31367, 4) },
            { name = "Kalyassa", teleport = Position(33160, 31322, 5) },
            { name = "Tazhadur", teleport = Position(33232, 32276, 12) },
            { name = "Zorvorax", teleport = Position(33003, 31595, 11) },
        },
        ["Forgotten"] = {
            { name = "Lady Tenebris", teleport = Position(32902, 31630, 14) },
            { name = "Lloyd", teleport = Position(32759, 32875, 14) },
            { name = "Melting Frozen Horror", teleport = Position(32302, 31095, 14) },
            { name = "Soul of Dragonking Zytrarch", teleport = Position(33391, 31185, 10) },
            { name = "The Enraged Thorn Knight", teleport = Position(32657, 32884, 14) },
            { name = "The Time Guardian", teleport = Position(33010, 31667, 14) },
        },
        ["Galthen"] = {
            { name = "Ahau", teleport = Position(34036, 31716, 10) },
            { name = "Megasylvan Yselda", teleport = Position(32576, 32501, 12) },
            { name = "Mitmah Vanguard", teleport = Position(34050, 31434, 11) },
        },
        ["GOLD TOKEN"] = {
            { name = "Anomaly", teleport = Position(32243, 31248, 14) },
            { name = "Eradicator", teleport = Position(32337, 31288, 14) },
            { name = "Outburst", teleport = Position(32203, 31285, 14) },
            { name = "Realityquake", teleport = Position(32179, 31247, 14) },
            { name = "Rupture", teleport = Position(32307, 31250, 14) },
        },
        ["Issavi"] = {
            { name = "Amenef The Burning", teleport = Position(33819, 31775, 10) },
            { name = "Neferi The Spy", teleport = Position(33886, 31478, 6) },
            { name = "Sister Hetai", teleport = Position(33883, 31470, 9) },
        },
        ["Livraria"] = {
            { name = "Ghulosh", teleport = Position(32749, 32770, 10) },
            { name = "Gorzindel", teleport = Position(32749, 32746, 10) },
            { name = "Lokathmor", teleport = Position(32723, 32746, 10) },
            { name = "Mazzinor", teleport = Position(32723, 32770, 10) },
            { name = "The Scourge of Oblivion", teleport = Position(32677, 32738, 11) },
        },
         ["Asuras"] = {
            { name = "The Blazing Rose", teleport = nil },
            { name = "The Diamond Blossom", teleport = nil },
            { name = "The Flaming Orchid", teleport = Position(32948, 32679, 2) },
            { name = "The Lily Of Night", teleport = nil },
            { name = "The Moonlight Aster", teleport = Position(32960, 32679, 2) },
            { name = "The Winter Bloom", teleport = Position(32926, 32660, 8) },
        },
        ["Outros"] = {
            { name = "Urmahlullu the Weakened", teleport = Position(33920, 31623, 8) },
            { name = "Despor", teleport = Position(33261, 31059, 13) },
            { name = "Drume", teleport = Position(32458, 32507, 6) },
            { name = "Grand Master Oberon", teleport = Position(33364, 31341, 9) },
            { name = "Kusuma", teleport = Position(33712, 32774, 5) },
            { name = "Magma Bubble", teleport = Position(33669, 32931, 15) },
            { name = "The Primal Menace", teleport = Position(33555, 32752, 14) },
            { name = "Ratmiral Blackwhiskers", teleport = Position(33895, 31392, 15) },
            { name = "Scarlett Etzel", teleport = Position(33395, 32665, 6) },
            { name = "Gafir", teleport = Position(33393, 32674, 4) },
            { name = "Custodian", teleport = Position(33378, 32825, 8) },
            { name = "Guard Captain Quaid", teleport = Position(33394, 32659, 3) },
            { name = "Timira the Many-Headed", teleport = Position(33804, 32702, 8) },
            { name = "Kroazur", teleport = Position(33619, 32306, 9) },
        },
        ["Rotem Blood"] = {
            { name = "Chagorz", teleport = nil },
            { name = "Ichgahal", teleport = nil },
            { name = "Murcion", teleport = nil },
            { name = "Vemiath", teleport = nil },
        },
        ["Soulwar"] = {
            { name = "Goshnar's Cruelty", teleport = Position(33861, 31854, 6) },
            { name = "Goshnar's Greed", teleport = Position(33782, 31665, 14) },
            { name = "Goshnar's Hatred", teleport = Position(33780, 31601, 14) },
            { name = "Goshnar's Malice", teleport = Position(33685, 31599, 14) },
            { name = "Goshnar's Spite", teleport = Position(33781, 31634, 14) },
            { name = "Goshnar's Megalomania", teleport = Position(33682, 31634, 14) },
        },
        ["Warzone"] = {
            { name = "Abyssador", teleport = Position(33075, 31881, 12) },
            { name = "Ancient Spawn of Morgathla", teleport = nil },
            { name = "Deathstrike", teleport = Position(33101, 31909, 10) },
            { name = "Gnomevil", teleport = Position(33096, 31978, 11) },
            { name = "The Brainstealer", teleport = Position(32537, 31122, 15) },
        },
        ["Werelions"] = {
            { name = "Katex Blood Tongue", teleport = Position(33116, 32252, 12) },
            { name = "Srezz Yellow Eyes", teleport = Position(33131, 32250, 12) },
            { name = "Utua Stone Sting", teleport = Position(33123, 32263, 12) },
            { name = "Yirkas Blue Scales", teleport = Position(33123, 32237, 12) },
        },
        ["Werewolf"] = {
            { name = "Black Vixen", teleport = Position(33442, 32053, 9) },
            { name = "Bloodback", teleport = Position(33167, 31979, 8) },
            { name = "Darkfang", teleport = Position(33055, 31912, 9) },
            { name = "Shadowpelt", teleport = Position(33404, 32097, 9) },
            { name = "Sharpclaw", teleport = Position(33128, 31973, 9) },
        },
    }
}

local function supremeBossCubeMessage(player, effect, message)
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
        supremeBossCubeMessage(player, CONST_ME_POFF, "You don't have enough money. You need " .. price .. " gold.")
        return false
    end

    if player:getStorageValue(config.storage) > os.time() then
        local remainingTime = player:getStorageValue(config.storage) - os.time()
        supremeBossCubeMessage(player, CONST_ME_POFF, "You can use it again in: " .. remainingTime .. " seconds.")
        return false
    end

    player:teleportTo(town.teleport, true)
    player:removeMoneyBank(price)
    player:setStorageValue(config.storage, os.time() + cooldown)
    supremeBossCubeMessage(player, CONST_ME_TELEPORT, "Welcome to " .. town.name .. "! You were charged " .. price .. " gold.")
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

function supremeBossCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local inPz = player:getTile():hasFlag(TILESTATE_PROTECTIONZONE)
    local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)

    if not inPz and inFight then
        supremeBossCubeMessage(player, CONST_ME_POFF, "You can't use this when you're in a fight.")
        return false
    end

    showCategoryModal(player)
    return true
end

supremeBossCube:id(39707)
supremeBossCube:register()
