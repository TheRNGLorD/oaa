--[[
  Author:
    Angel Arena Blackstars
    Chronophylos
  Credits:
    Angel Arena Blackstars
]]


-- this file needs to be cleaned up, the whole PLAYER_GOLD thing isn't needed at all
-- there's no good reason to track the data in two spots at once
--- done
-- it'd also be great to figure out how to only send down the data to the player who cares
--- why?

if Gold == nil then
  DebugPrint ( '[gold/gold] creating new Gold object' )
  _G.Gold = class({})
end

--[[local PLAYER_GOLD = {
  [0] = {},
  [1] = {},
  [2] = {},
  [3] = {},
  [4] = {},
  [5] = {},
  [6] = {},
  [7] = {},
  [8] = {},
  [9] = {}
}]]--

local GOLD_CAP = 50000

function Gold:Init()
  -- a table for every player
  PlayerTables:CreateTable("gold", {
    gold = {}
  }, {0,1,2,3,4,5,6,7,8,9})

    -- start think timer
  Timers:CreateTimer(0, Dynamic_Wrap(Gold, "Think"))
end

function Gold:UpdatePlayerGold(unitvar, newGold)
  local playerID = UnitVarToPlayerID(unitvar)
  if playerID and playerID > -1 then
    -- get full tree,
    --[[local allgold = PlayerTables:GetTableValue("gold", "gold")
    allgold[playerID] = PLAYER_GOLD[playerID].SavedGold

    PlayerTables:SetTableValue("gold", "gold", allgold)

    local player = PlayerResource:GetPlayer(playerID)
    CustomGameEventManager:Send_ServerToAllClients("aaa_update_gold", {
      gold = allgold
    })]]--
    local tableGold = PlayerTables:GetTableValue("gold", "gold")
    tableGold[playerID] = newGold
    PlayerTables:SetTableValue("gold", "gold", tableGold)
  end
end

--[[
  Author:
    Chronophylos
  Credits:
    Angel Arena Blackstar
  Description:
    Add Gold to all players via our custom Gold API
]]
function Gold:Think()
  for i = 0, 9 do
    if PlayerResource:IsValidPlayerID(i) then
      if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then

        local currentGold = Gold:GetGold(i)
        local currentDotaGold = PlayerResource:GetGold(i)

        local newGold = currentGold
        local newDotaGold = currentDotaGold

        if currentGold > GOLD_CAP then
          newGold = currentGold + currentDotaGold - GOLD_CAP
        else
          newGold = currentDotaGold
        end

        if newGold > GOLD_CAP then
          newDotaGold = GOLD_CAP
        else
          newDotaGold = newGold
        end

        if newGold ~= currentGold or newDotaGold ~= currentDotaGold then
          Gold:SetGold(i, newGold)
          PlayerResource:SetGold(i, newDotaGold, false)
        end
      end
    end
  end
  return 0.2
end


function Gold:ClearGold(unitvar)
  Gold:SetGold(unitvar, 0)
end

function Gold:SetGold(unitvar, gold)
  local playerID = UnitVarToPlayerID(unitvar)
  --PLAYER_GOLD[playerID].SavedGold = math.floor(gold)
  local newGold = math.floor(gold)
  Gold:UpdatePlayerGold(playerID, newGold)
end

function Gold:ModifyGold(unitvar, gold, bReliable, iReason)
  if gold > 0 then
    Gold:AddGold(unitvar, gold)
  elseif gold < 0 then
    Gold:RemoveGold(unitvar, -gold)
  end
end

function Gold:RemoveGold(unitvar, gold)
  local playerID = UnitVarToPlayerID(unitvar)
  --  PLAYER_GOLD[playerID].SavedGold = math.max((PLAYER_GOLD[playerID].SavedGold or 0) - math.ceil(gold), 0)
  local oldGold = PlayerTables:GetTableValue("gold", "gold")[playerID]
  local newGold = math.max((oldGold or 0) - math.ceil(gold), 0)
  Gold:UpdatePlayerGold(playerID, newGold)
end

function Gold:AddGold(unitvar, gold)
  --[[DebugPrint("[Gold] AddGold")
  DebugPrint("arg.unitvar: " .. unitvar)
  DebugPrint("arg.gold: " .. gold)
  DebugPrintTable(PLAYER_GOLD)]]
  local playerID = UnitVarToPlayerID(unitvar)
  --PLAYER_GOLD[playerID].SavedGold = (PLAYER_GOLD[playerID].SavedGold or 0) + math.floor(gold)
  local oldGold = PlayerTables:GetTableValue("gold", "gold")[playerID]
  local newGold = (oldGold or 0) + math.floor(gold)
  Gold:UpdatePlayerGold(playerID, newGold)
end

function Gold:AddGoldWithMessage(unit, gold, optPlayerID)
  local player = optPlayerID and PlayerResource:GetPlayer(optPlayerID) or PlayerResource:GetPlayer(UnitVarToPlayerID(unit))
  SendOverheadEventMessage(player, OVERHEAD_ALERT_GOLD, unit, math.floor(gold), player)
  Gold:AddGold(optPlayerID or unit, gold)
end

function Gold:GetGold(unitvar)
  local playerID = UnitVarToPlayerID(unitvar)
  local currentGold = PlayerTables:GetTableValue("gold", "gold")[playerID]
  --return math.floor(PLAYER_GOLD[playerID].SavedGold or 0)
  return math.floor(currentGold or 0)
end
