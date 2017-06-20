if PlayerConnection == nil then
  Debug.EnabledModules["player:connection"] = true
  DebugPrint("Creating PlayerConnection Object")
  PlayerConnection = class({})
end

function PlayerConnection:Init()
  Timers:CreateTimer(function()
    return self:Think()
  end)
  self.countdown = nil
end

function PlayerConnection:Think()
  local goodTeamPlayerCount = length(PlayerResource:GetConnectedTeamPlayerIDsForTeam(DOTA_TEAM_GOODGUYS))
  local badTeamPlayerCount = length(PlayerResource:GetConnectedTeamPlayerIDsForTeam(DOTA_TEAM_BADGUYS))

  local emptyTeam = nil
  local otherTeam = nil

  if goodTeamPlayerCount == 0 and badTeamPlayerCount == 0 then
    PointsManager:SetWinner(DOTA_TEAM_NEUTRALS)
  elseif goodTeamPlayerCount == 0 then
    emptyTeam = DOTA_TEAM_GOODGUYS
    otherTeam = DOTA_TEAM_BADGUYS
  elseif badTeamPlayerCount == 0 then
    emptyTeam = DOTA_TEAM_BADGUYS
    otherTeam = DOTA_TEAM_GOODGUYS
  end

  if not emptyTeam then
    self.countdown = nil
  elseif not self.countdown then
    self.countdown = GAME_ABANDON_TIME
    return 1
  end

  if self.countdown and self.countdown > 0 then
    -- TODO: Show Nice Message
    Notifications:TopToAll({
      text=self.countdown .. " seconds until " .. GetTeamName(emptyTeam) .. " will win",
      duration=1
    })
    self.countdown = self.countdown - 1
  elseif self.countdown == 0 then
    PointsManager:SetWinner(otherTeam)
    return -- don't loop again
  end

  return 1
end
