modifier_spark_gpm = class(ModifierBaseClass)

function modifier_spark_gpm:OnCreated()
  self:StartIntervalThink(1)
end

modifier_spark_gpm.OnRefresh = modifier_spark_gpm.OnCreated

function getSparkLevel ()
  local gameTime = GameRules:GetGameTime()

  if gameTime > INITIAL_CAPTURE_POINT_DELAY + CAPTURE_INTERVAL + CAPTURE_INTERVAL + CAPTURE_INTERVAL then
    -- after second cap
    return 5
  elseif gameTime > INITIAL_CAPTURE_POINT_DELAY + CAPTURE_INTERVAL + CAPTURE_INTERVAL then
    -- after third cap
    return 4
  elseif gameTime > INITIAL_CAPTURE_POINT_DELAY + CAPTURE_INTERVAL then
    -- after second cap
    return 3
  elseif gameTime > INITIAL_CAPTURE_POINT_DELAY then
    -- after first cap
    return 2
  end

  return 1
end

function modifier_spark_gpm:GetTexture()
  local ability = self:GetAbility()
  if ability == nil then
    return self.BaseClass.GetTexture(self)
  end

  if ability:GetAbilityTextureName() then
    return ability:GetAbilityTextureName()
  end
  return ability:GetAbilityName()
end

if IsServer() then
  function modifier_spark_gpm:OnIntervalThink()
    if not PlayerResource then
      -- sometimes for no reason the player resource isn't there, usually only at the start of games in tools mode
      return
    end
    local caster = self:GetCaster()
    local gpmChart = {500, 2000, 3200, 5500, 9000}
    local gpm = gpmChart[getSparkLevel()]
    -- Don't give gold on illusions, Tempest Doubles, or Meepo clones, or during duels
    if caster:IsIllusion() or caster:IsTempestDouble() or caster:IsClone() or not Gold:IsGoldGenActive() then
      return
    end
    Gold:ModifyGold(caster:GetPlayerOwnerID(), gpm / 60, true, DOTA_ModifyGold_GameTick)
  end
end

function modifier_spark_gpm:IsHidden()
  return false
end

function modifier_spark_gpm:IsDebuff()
  return false
end

function modifier_spark_gpm:IsPurgable()
  return false
end

function modifier_spark_gpm:RemoveOnDeath()
  return false
end
