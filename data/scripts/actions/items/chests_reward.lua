local rewardChests = {
    [49614] = { -- Ratimiral Chest
        { id = 35523, name = "Exotic Amulet", count = 1 },
        { id = 35517, name = "Bast legs", count = 1 },
        { id = 35516, name = "Exotic Legs", count = 1 },
        { id = 35518, name = "Jungle Bow", count = 1 },
        { id = 35514, name = "Jungle Fail", count = 1 },
        { id = 35524, name = "Jungle Quiver", count = 1 },
        { id = 35521, name = "Jungle Rod", count = 1 },
        { id = 35520, name = "make-do boots", count = 1 },
        { id = 35519, name = "makeshift boots", count = 1 }
    },
    [49610] = { -- Cobra Chest
        { id = 30396, name = "Cobra Axe", count = 1 },
        { id = 30395, name = "Cobra Club", count = 1 },
        { id = 30393, name = "Cobra Crossbow", count = 1 },
        { id = 30397, name = "Cobra Hood", count = 1 },
        { id = 30400, name = "Cobra Rod", count = 1 },
        { id = 30398, name = "Cobra Sword", count = 1 },
        { id = 30399, name = "Cobra Wand", count = 1 },
        { id = 31631, name = "Cobra Amulet", count = 1 }
    },
    [49611] = { -- Drume Chest
        { id = 34158, name = "Lion Amulet", count = 1 },
        { id = 34253, name = "Lion Axe", count = 1 },
        { id = 34254, name = "Lion Hammer", count = 1 },
        { id = 34150, name = "Lion Longbow", count = 1 },
        { id = 34155, name = "Lion Longsword", count = 1 },
        { id = 34157, name = "Lion Plate", count = 1 },
        { id = 34151, name = "Lion Rod", count = 1 },
        { id = 34253, name = "Lion Shield", count = 1 },
        { id = 34156, name = "Lion Spangenhelm", count = 1 },
        { id = 34153, name = "Lion Spellbook", count = 1 },
        { id = 34152, name = "Lion Wand", count = 1 }
    },
    [49613] = { -- Brainstealer Chest
        { id = 36664, name = "Eldritch Bow", count = 1 },
        { id = 36667, name = "Eldritch Breeches", count = 1 },
        { id = 36657, name = "Eldritch Claymore", count = 1 },
        { id = 36670, name = "Eldritch Cowl", count = 1 },
        { id = 36835, name = "Eldritch Crystal", count = 1 },
        { id = 36663, name = "Eldritch Cuirass", count = 1 },
        { id = 36672, name = "Eldritch Folio", count = 1 },
        { id = 36661, name = "Eldritch Greataxe", count = 1 },
        { id = 36671, name = "Eldritch Hood", count = 1 },
        { id = 36666, name = "Eldritch Quiver", count = 1 },
        { id = 36674, name = "Eldritch Rod", count = 1 },
        { id = 36656, name = "Eldritch Shield", count = 1 },
        { id = 36673, name = "Eldritch Tome", count = 1 },
        { id = 36668, name = "Eldritch Wand", count = 1 },
        { id = 36659, name = "Eldritch Warmace", count = 1 },
        { id = 36665, name = "Gilded Eldritch Bow", count = 1 },
        { id = 36658, name = "Gilded Eldritch Claymore", count = 1 },
        { id = 36662, name = "Gilded Eldritch Greataxe", count = 1 },
        { id = 36675, name = "Gilded Eldritch Rod", count = 1 },
        { id = 36669, name = "Gilded Eldritch Wand", count = 1 },
        { id = 36660, name = "Gilded Eldritch Warmace", count = 1 }
    },
    [49612] = { -- Timira Chest
        { id = 39165, name = "Midnight Tunic", count = 1 },
        { id = 39167, name = "Midnight Sarong", count = 1 },
        { id = 39155, name = "Naga Sword", count = 1 },
        { id = 39156, name = "Naga Axe", count = 1 },
        { id = 39157, name = "Naga Club", count = 1 },
        { id = 39162, name = "Naga Wand", count = 1 },
        { id = 39163, name = "Naga Rod", count = 1 },
        { id = 39159, name = "Naga Crossbow", count = 1 },
        { id = 39160, name = "Naga Quiver", count = 1 },
        { id = 39164, name = "Dawnfire Sherwani", count = 1 },
        { id = 39166, name = "Dawnfire Pantaloons", count = 1 },
        { id = 39233, name = "Enchanted Turtle Amulet", count = 1 },
        { id = 39161, name = "Feverbloom Boots", count = 1 },
        { id = 39158, name = "Frostflower Boots", count = 1 }
    },
    [49609] = { -- Oberon Chest
        { id = 28724, name = "Falcon Battleaxe", count = 1 },
        { id = 28723, name = "Falcon Longsword", count = 1 },
        { id = 28725, name = "Falcon Mace", count = 1 },
        { id = 28718, name = "Falcon Bow", count = 1 },
        { id = 28714, name = "Falcon Circlet", count = 1 },
        { id = 28715, name = "Falcon Coif", count = 1 },
        { id = 28716, name = "Falcon Rod", count = 1 },
        { id = 28717, name = "Falcon Wand", count = 1 },
        { id = 28720, name = "Falcon Greaves", count = 1 },
        { id = 28719, name = "Falcon Plate", count = 1 },
        { id = 28721, name = "Falcon Shield", count = 1 }
    }
}

local chestAction = Action()

local function sendDiscordLog(player, reward, chestName)
    local message = ":gift: **" .. player:getName() .. "** received **" .. reward.count .. "x " .. reward.name .. "** from the chest **" .. chestName .. "**!"
    Webhook.sendMessage(message, announcementChannels["log-chests"]) -- Certifique-se de que "log-chests" é o canal correto.
end

local condition = Condition(CONDITION_OUTFIT)
condition:setTicks(15000)

function chestAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local rewardList = rewardChests[item.itemid]
    if not rewardList then
        return false
    end

    local randomIndex = math.random(1, #rewardList)
    local reward = rewardList[randomIndex]

    if player:addItem(reward.id, reward.count or 1) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You opened the chest and received: " .. reward.count .. "x " .. reward.name .. ".")
        sendDiscordLog(player, reward, item:getName()) -- Envia o log para o Discord
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have enough space to receive the reward.")
        return false
    end

    condition:setOutfit({ lookTypeEx = reward.id })
	player:addCondition(condition)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
    item:remove(1) -- Remove o baú após o uso
    return true
end

-- Registrar os baús
for chestId in pairs(rewardChests) do
    chestAction:id(chestId)
end

chestAction:register()
