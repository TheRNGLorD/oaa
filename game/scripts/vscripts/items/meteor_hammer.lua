LinkLuaModifier("modifier_item_meteor_hammer_oaa_thinker", "items/meteor_hammer.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_meteor_hammer_oaa_dot", "items/meteor_hammer.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_meteor_hammer_oaa_stun", "items/meteor_hammer.lua", LUA_MODIFIER_MOTION_NONE)

item_meteor_hammer_1 = class(ItemBaseClass)
item_meteor_hammer_2 = item_meteor_hammer_1
item_meteor_hammer_3 = item_meteor_hammer_1
item_meteor_hammer_4 = item_meteor_hammer_1
item_meteor_hammer_5 = item_meteor_hammer_1

function item_meteor_hammer_1:GetAOERadius()
  return self:GetSpecialValueFor("impact_radius")
end

function item_meteor_hammer_1:GetIntrinsicModifierName()
  return "modifier_generic_bonus"
end

function item_meteor_hammer_1:OnSpellStart()
  local caster = self:GetCaster()
  local target_location = self:GetCursorPosition()
  local vision_duration = math.max(self:GetChannelTime() + self:GetSpecialValueFor("land_time") + self:GetSpecialValueFor("stun_duration"), 3.8)
  local radius = self:GetSpecialValueFor("impact_radius")

  caster:EmitSound("DOTA_Item.MeteorHammer.Channel")

  caster:StartGesture(ACT_DOTA_TELEPORT)

  self:CreateVisibilityNode(target_location, radius, vision_duration)

  --Particle that surrounds caster
  self.channel_particle_caster = ParticleManager:CreateParticle("particles/items4_fx/meteor_hammer_cast.vpcf", PATTACH_ABSORIGIN, caster)
  --Particle that surrounds meteor_hammer's aoe.
  self.channel_particle = ParticleManager:CreateParticleForTeam("particles/items4_fx/meteor_hammer_aoe.vpcf", PATTACH_CUSTOMORIGIN, caster, caster:GetTeam())
  ParticleManager:SetParticleControl(self.channel_particle, 0, target_location)
  ParticleManager:SetParticleControl(self.channel_particle, 1, Vector(radius, 0, 0))
end

function item_meteor_hammer_1:OnChannelFinish(bInterrupted)
  local caster = self:GetCaster()

  caster:FadeGesture(ACT_DOTA_TELEPORT)

  if not bInterrupted then
    caster:EmitSound("DOTA_Item.MeteorHammer.Cast")
    CreateModifierThinker(
      caster,
      self,
      "modifier_item_meteor_hammer_oaa_thinker",
      {duration = self:GetSpecialValueFor("land_time") + self:GetSpecialValueFor("stun_duration")},
      self:GetCursorPosition(),
      caster:GetTeamNumber(),
      false
    )
  else
    caster:StopSound("DOTA_Item.MeteorHammer.Channel")
    ParticleManager:DestroyParticle(self.channel_particle_caster, true)
    ParticleManager:DestroyParticle(self.channel_particle, true)
  end

  ParticleManager:ReleaseParticleIndex(self.channel_particle_caster)
  ParticleManager:ReleaseParticleIndex(self.channel_particle)
end

---------------------------------------------------------------------------------------------------

modifier_item_meteor_hammer_oaa_thinker = class(ModifierBaseClass)

function modifier_item_meteor_hammer_oaa_thinker:IsHidden()
  return true
end

function modifier_item_meteor_hammer_oaa_thinker:IsPurgable()
  return false
end

function modifier_item_meteor_hammer_oaa_thinker:OnCreated()
  if IsServer() then
    local ability = self:GetAbility()
    local parent = self:GetParent()
    -- item info from kv
    self.impact_radius = ability:GetSpecialValueFor("impact_radius")
    self.impact_damage = ability:GetSpecialValueFor("impact_damage")
    self.impact_damage_bosses = ability:GetSpecialValueFor("impact_damage_boss")

    self.land_time = ability:GetSpecialValueFor("land_time")
    self.burn_duration = ability:GetSpecialValueFor("burn_duration")
    self.stun_duration = ability:GetSpecialValueFor("stun_duration")
    --landtime should not be a negative number
    self:StartIntervalThink(self.land_time)

    local impact_particle = ParticleManager:CreateParticle("particles/items4_fx/meteor_hammer_spell.vpcf", PATTACH_WORLDORIGIN, nil)

    --Controls the metoer position to origin
    ParticleManager:SetParticleControl(impact_particle, 0, parent:GetOrigin() + Vector(0, 0, 1000))
    ParticleManager:SetParticleControl(impact_particle, 1, parent:GetOrigin())
    --Fade time of cetain particles
    ParticleManager:SetParticleControl(impact_particle, 2, Vector(self.land_time, 0, 0))
    ParticleManager:ReleaseParticleIndex(impact_particle)
  end
end

function modifier_item_meteor_hammer_oaa_thinker:OnIntervalThink()
  local parent = self:GetParent() -- thinker
  local caster = self:GetCaster() -- item owner
  local ability = self:GetAbility() -- item
  local parent_loc = parent:GetAbsOrigin()

  -- Sound
  EmitSoundOnLocationWithCaster(parent_loc, "DOTA_Item.MeteorHammer.Impact", caster)

  -- Destroy trees
  GridNav:DestroyTreesAroundPoint(parent_loc, self.impact_radius, true)

  local enemies = FindUnitsInRadius(
    caster:GetTeamNumber(),
    parent_loc,
    nil,
    self.impact_radius,
    DOTA_UNIT_TARGET_TEAM_ENEMY,
    bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
    DOTA_UNIT_TARGET_FLAG_NONE,
    FIND_ANY_ORDER,
    false
  )

  for _, enemy in pairs(enemies) do
    if enemy and not enemy:IsNull() then
      -- Apply damage-over-time debuff (duration is not affected by status resistance)
      enemy:AddNewModifier(caster, ability, "modifier_item_meteor_hammer_oaa_dot", {duration = self.burn_duration})
      -- Apply stun debuff (duration is affected by status resistance)
      local stun_duration = enemy:GetValueChangedByStatusResistance(self.stun_duration)
      enemy:AddNewModifier(caster, ability, "modifier_item_meteor_hammer_oaa_stun", {duration = stun_duration})

      local damage_table = {
        victim = enemy,
        attacker = caster,
        damage = self.impact_damage,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = ability,
      }
      -- Is the enemy a boss?
      if enemy:IsOAABoss() then
        damage_table.damage = self.impact_damage_bosses
      end

      if enemy:IsAlive() then
        ApplyDamage(damage_table)
      end
    end
  end

  self:StartIntervalThink(-1)
  self:Destroy()
end

function modifier_item_meteor_hammer_oaa_thinker:OnDestroy()
  if not IsServer() then
    return
  end
  local parent = self:GetParent()
  if parent and not parent:IsNull() then
    parent:ForceKillOAA(false)
  end
end

---------------------------------------------------------------------------------------------------

modifier_item_meteor_hammer_oaa_dot = class(ModifierBaseClass)

function modifier_item_meteor_hammer_oaa_dot:IsHidden()
  return false
end

function modifier_item_meteor_hammer_oaa_dot:IsDebuff()
  return true
end

function modifier_item_meteor_hammer_oaa_dot:IsPurgable()
  return not self:GetParent():IsOAABoss()
end

function modifier_item_meteor_hammer_oaa_dot:OnCreated()
  local parent = self:GetParent()
  local ability = self:GetAbility()
  local movement_slow = ability:GetSpecialValueFor("move_speed_slow_pct")
  if IsServer() then
    local caster = self:GetCaster()

    self.burn_dps = ability:GetSpecialValueFor("burn_dps")
    self.burn_dps_boss = ability:GetSpecialValueFor("burn_dps_boss")
    self.burn_interval = ability:GetSpecialValueFor("burn_interval")

    self:OnIntervalThink()
    self:StartIntervalThink(self.burn_interval)
  end
  -- Move Speed Slow is reduced with Slow Resistance
  self.slow = movement_slow --parent:GetValueChangedBySlowResistance(movement_slow)
end

function modifier_item_meteor_hammer_oaa_dot:OnIntervalThink()
  if IsServer() then
    local enemy = self:GetParent()
    local caster = self:GetCaster()
    local ability = self:GetAbility()

    local damage_table = {
      victim = enemy,
      attacker = caster,
      damage = self.burn_dps * self.burn_interval,
      damage_type = DAMAGE_TYPE_MAGICAL,
      ability = ability,
    }

    if enemy:IsOAABoss() then
      damage_table.damage = self.burn_dps_boss * self.burn_interval
    end

    ApplyDamage(damage_table)
  end
end

function modifier_item_meteor_hammer_oaa_dot:DeclareFunctions()
  return {
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  }
end

function modifier_item_meteor_hammer_oaa_dot:GetModifierMoveSpeedBonus_Percentage()
  return 0 - math.abs(self.slow)
end

function modifier_item_meteor_hammer_oaa_dot:GetEffectName()
  return "particles/items4_fx/meteor_hammer_spell_debuff.vpcf"
end

function modifier_item_meteor_hammer_oaa_dot:GetTexture()
  return "item_meteor_hammer"
end

---------------------------------------------------------------------------------------------------

modifier_item_meteor_hammer_oaa_stun = class(ModifierBaseClass)

function modifier_item_meteor_hammer_oaa_stun:IsHidden()
  return false
end

function modifier_item_meteor_hammer_oaa_stun:IsDebuff()
  return true
end

function modifier_item_meteor_hammer_oaa_stun:IsStunDebuff()
  return true
end

function modifier_item_meteor_hammer_oaa_stun:IsPurgable()
  return not self:GetParent():IsOAABoss()
end

function modifier_item_meteor_hammer_oaa_stun:GetEffectName()
  return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_item_meteor_hammer_oaa_stun:GetEffectAttachType()
  return PATTACH_OVERHEAD_FOLLOW
end

function modifier_item_meteor_hammer_oaa_stun:DeclareFunctions()
  return {
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
  }
end

function modifier_item_meteor_hammer_oaa_stun:GetOverrideAnimation()
  return ACT_DOTA_DISABLED
end

function modifier_item_meteor_hammer_oaa_stun:CheckState()
  return {
    [MODIFIER_STATE_STUNNED] = true,
  }
end

function modifier_item_meteor_hammer_oaa_stun:GetTexture()
  return "item_meteor_hammer"
end
