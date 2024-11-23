-- Define constants
local MESSAGE_EVENT_ADVANCE = MESSAGE_EVENT_ADVANCE or 18 -- Replace with the correct constant value if different

-- Initialize global variables
STALKED_PLAYERS = STALKED_PLAYERS or {}
STALKING_ACTIVE = STALKING_ACTIVE or false

-- Function to stalk a player
local function stalkPlayer(player, target)
    if player and not target then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Stalked player lost.')
        return false
    end

    if not player then
        return false
    end

    if not player:getPathTo(target:getPosition()) then
        player:teleportTo(target:getPosition())
    end

    if player:getFollowCreature() ~= target then
        player:setFollowCreature(target)
    end
    return true
end

-- Function to continuously stalk players
local function stalkPlayers()
    local stalkingActive = false
    for playerId, targetId in pairs(STALKED_PLAYERS) do
        local stalkSuccess = stalkPlayer(Player(playerId), Player(targetId))
        if not stalkSuccess then
            STALKED_PLAYERS[playerId] = nil
        end
        stalkingActive = stalkingActive or stalkSuccess
    end

    STALKING_ACTIVE = stalkingActive

    if STALKING_ACTIVE then
        addEvent(stalkPlayers, 500)
    end
end

-- Revscriptsys Event
local stalkAction = TalkAction("/spy")

function stalkAction.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    if param == 'stop' then
        if not STALKED_PLAYERS[player:getId()] then
            return false
        end

        local target = Player(STALKED_PLAYERS[player:getId()])
      
        STALKED_PLAYERS[player:getId()] = nil
        player:setFollowCreature(nil)

        if target then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You are no longer stalking ' .. target:getName() .. '.')
        end
        return false
    end

    local target = Player(param)
    if not target then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Player not found.')
        return false
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You are now stalking ' .. target:getName() .. '.')
    if not player:isInGhostMode() then
        player:setGhostMode(true)
    end

    STALKED_PLAYERS[player:getId()] = target:getId()

    if not STALKING_ACTIVE then
        STALKING_ACTIVE = true
        stalkPlayers()
    end

    return false
end

stalkAction:separator(" ")
stalkAction:groupType("god")
stalkAction:register()