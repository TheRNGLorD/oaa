LinkLuaModifier("modifier_magma_boss_volcano", "abilities/boss/magma_boss/magma_boss_volcano.lua", LUA_MODIFIER_MOTION_VERTICAL) --knockup from torrent
LinkLuaModifier("modifier_magma_boss_volcano_thinker", "abilities/boss/magma_boss/magma_boss_volcano.lua", LUA_MODIFIER_MOTION_NONE) --applied to volcano units to create magma pools
LinkLuaModifier("modifier_magma_boss_volcano_thinker_child", "abilities/boss/magma_boss/magma_boss_volcano.lua", LUA_MODIFIER_MOTION_NONE) --applied to volcano units to make them invulnerable and pop in
LinkLuaModifier("modifier_magma_boss_volcano_burning_effect", "abilities/boss/magma_boss/magma_boss_volcano.lua", LUA_MODIFIER_MOTION_NONE) --particles-only modifier for standing in magma

magma_boss_volcano = class(AbilityBaseClass)

function magma_boss_volcano:Precache(context)
  PrecacheResource("particle", "particles/magma_boss/boss_magma_mage_volcano_burning.vpcf", context)
  PrecacheResource("particle", "particles/magma_boss/boss_magma_mage_volcano_indicator1.vpcf", context)
  PrecacheResource("particle", "particles/magma_boss/boss_magma_mage_volcano_embers.vpcf", context)
  PrecacheResource("particle", "particles/magma_boss/boss_magma_mage_volcano1.vpcf", context)
  PrecacheResource("particle", "particles/magma_boss/magma_center.vpcf", context)
  PrecacheResource("particle", "particles/magma_boss/magma.vpcf", context)
  PrecacheResource("soundfile", "soundevents/bosses/magma_boss.vsndevts", context)
end

function magma_boss_volcano:OnOwnerDied()
  local caster = self:GetCaster()
  local team = caster:GetTeamNumber()
  self:KillAllVolcanos(team)
end

function magma_boss_volcano:OnSpellStart()
  local hCaster = self:GetCaster()
  local mainTarget = self:GetCursorPosition()
  local vTargetPositions = {}
  if not mainTarget then
    return
  end
  if self.target_points then
    for _, target in pairs(self.target_points) do
      if target then
        table.insert(vTargetPositions, target)
      end
    end
  else
    table.insert(vTargetPositions, mainTarget)
  end

  for _, vLoc in ipairs(vTargetPositions) do
    local hUnit = CreateUnitByName("npc_dota_magma_boss_volcano", vLoc, false, hCaster, hCaster, hCaster:GetTeamNumber())
    hUnit:AddNewModifier(hCaster, self, "modifier_magma_boss_volcano_thinker", {duration = self:GetSpecialValueFor("totem_duration_max")})
    hUnit:SetModelScale(0.01)
    local nMaxHealth = self:GetSpecialValueFor("totem_health")
    hUnit:SetBaseMaxHealth(nMaxHealth)
    hUnit:SetMaxHealth(nMaxHealth)
    hUnit:SetHealth(nMaxHealth)
    if not self.zVolcanoName then
      self.zVolcanoName = hUnit:GetName()
    end
  end
end

--------------------------------------------------------------------------------

function magma_boss_volcano:KillAllVolcanos(team) --kill all volcanos created by this ability's caster
  if IsServer() then
    local volcanos = Entities:FindAllByName(self.zVolcanoName)
    local zModName = "modifier_magma_boss_volcano_thinker"
    for _, volcano in pairs(volcanos) do
      if volcano:HasModifier(zModName) and volcano:GetTeamNumber() == team then
        volcano:ForceKill(false)
      end
    end
  end
end

function magma_boss_volcano:FindClosestMagmaPool() --returns the location (Vector) of the closest magma (edge of a magma pool)
  if IsServer() then
    local volcanos = Entities:FindAllByName(self.zVolcanoName)
    local zModName = "modifier_magma_boss_volcano_thinker"
    local hClosestVolcano
    local nClosestEdgeDistance = math.huge
    for _, volcano in pairs(volcanos) do
      if volcano:HasModifier(zModName) and (volcano:GetTeamNumber() == self:GetCaster():GetTeamNumber()) then
        local EdgeDistance = (self:GetOwner():GetOrigin() - volcano:GetOrigin()):Length2D() - volcano:FindModifierByName(zModName):GetMagmaRadius()
        if EdgeDistance < nClosestEdgeDistance then
          nClosestEdgeDistance = EdgeDistance
          hClosestVolcano = volcano
        end
      end
    end
    local vEdgeLoc
    if hClosestVolcano then
      vEdgeLoc = self:GetOwner():GetAbsOrigin() + (hClosestVolcano:GetAbsOrigin()-self:GetOwner():GetAbsOrigin()):Normalized()*nClosestEdgeDistance
      DebugDrawLine(self:GetOwner():GetOrigin(),vEdgeLoc,0,255,255,true,10)
    end
    return vEdgeLoc
  end
end

function magma_boss_volcano:GetNumVolcanos()
  if IsServer() then
    local volcanos = Entities:FindAllByName(self.zVolcanoName)
    local NumVolcanos = 0
    if #volcanos > 0 then
      local zModName = "modifier_magma_boss_volcano_thinker"
      for _, volcano in pairs(volcanos) do
        if volcano and volcano:HasModifier(zModName) and (volcano:FindModifierByName(zModName):GetCaster():GetTeamNumber() == self:GetCaster():GetTeamNumber()) then
          NumVolcanos = NumVolcanos + 1
        end
      end
    end
    return NumVolcanos
  end
end

---------------------------------------------------------------------------------------------------

modifier_magma_boss_volcano = class(ModifierBaseClass)

GRAVITY_DECEL = 800

function modifier_magma_boss_volcano:IsHidden()
  return true
end

function modifier_magma_boss_volcano:IsStunDebuff()
  return true
end

function modifier_magma_boss_volcano:IsDebuff()
  return true
end

function modifier_magma_boss_volcano:IsPurgable()
  return false
end

function modifier_magma_boss_volcano:IsPurgeException()
  return true
end

function modifier_magma_boss_volcano:RemoveOnDeath()
  return true
end

function modifier_magma_boss_volcano:GetEffectName()
  return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_magma_boss_volcano:GetEffectAttachType()
  return PATTACH_OVERHEAD_FOLLOW
end

function modifier_magma_boss_volcano:DeclareFunctions()
  local funcs = {
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
  }
  return funcs
end

function modifier_magma_boss_volcano:GetOverrideAnimation()
  return ACT_DOTA_FLAIL
end

function modifier_magma_boss_volcano:OnCreated( kv )
  if IsServer() then
    --set speed so that the rise/fall will match the knockup duration
    self.speed = kv.duration*GRAVITY_DECEL/2
    if self:ApplyVerticalMotionController() == false then
      self:Destroy()
    end
  end
end

function modifier_magma_boss_volcano:OnRefresh( kv )
  if IsServer() then
    local hParent = self:GetParent()
    hParent:RemoveVerticalMotionController(self)
    self.speed = kv.duration*GRAVITY_DECEL/2
    if self:ApplyVerticalMotionController() == false then
      self:Destroy()
    end
  end
end

function modifier_magma_boss_volcano:OnDestroy()
  if IsServer() then
    local hParent = self:GetParent()
    hParent:RemoveVerticalMotionController(self)
  end
end

function modifier_magma_boss_volcano:UpdateVerticalMotion( me, dt )
  if IsServer() then
    local parent = self:GetParent()
    local iVectLength = self.speed*dt
    self.speed = self.speed - GRAVITY_DECEL*dt
    local vVect = iVectLength*Vector(0,0,1)
    parent:SetOrigin(parent:GetOrigin()+vVect)
  end
end

function modifier_magma_boss_volcano:OnVerticalMotionInterrupted()
  self:Destroy()
end

function modifier_magma_boss_volcano:CheckState()
  local state = {
    [MODIFIER_STATE_STUNNED] = true
  }
  return state
end

---------------------------------------------------------------------------------------------------

modifier_magma_boss_volcano_burning_effect = class(ModifierBaseClass)

function modifier_magma_boss_volcano_burning_effect:IsHidden()
  return true
end

function modifier_magma_boss_volcano_burning_effect:IsDebuff()
  return true
end

function modifier_magma_boss_volcano_burning_effect:IsPurgable()
  return false
end

function modifier_magma_boss_volcano_burning_effect:RemoveOnDeath()
  return true
end

function modifier_magma_boss_volcano_burning_effect:OnCreated()
  if IsServer() then
    local parent = self:GetParent()
    local nFXIndex = ParticleManager:CreateParticle("particles/magma_boss/boss_magma_mage_volcano_burning.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:SetParticleControlEnt(nFXIndex, 0, parent, PATTACH_ABSORIGIN_FOLLOW, nil, parent:GetOrigin(), true)
    ParticleManager:SetParticleControl(nFXIndex, 2, Vector(2,0,0))
    self.nFXIndex = nFXIndex
  end
end

function modifier_magma_boss_volcano_burning_effect:OnDestroy()
  if IsServer() then
    if self.nFXIndex then
      ParticleManager:DestroyParticle(self.nFXIndex, false)
      ParticleManager:ReleaseParticleIndex(self.nFXIndex)
    end
  end
end

---------------------------------------------------------------------------------------------------

modifier_magma_boss_volcano_thinker = class (ModifierBaseClass)

function modifier_magma_boss_volcano_thinker:IsHidden()
  return true
end

function modifier_magma_boss_volcano_thinker:IsDebuff()
  return false
end

function modifier_magma_boss_volcano_thinker:IsPurgable()
  return false
end

function modifier_magma_boss_volcano_thinker:RemoveOnDeath()
  return true
end

function modifier_magma_boss_volcano_thinker:DeclareFunctions()
  local funcs = {
    MODIFIER_PROPERTY_DISABLE_HEALING,
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    MODIFIER_EVENT_ON_ATTACK_LANDED,
  }
  return funcs
end

function modifier_magma_boss_volcano_thinker:OnCreated()
  if IsServer() then
    local parent = self:GetParent()
    local hAbility = self:GetAbility()

    self.delay = hAbility:GetSpecialValueFor("torrent_delay")
    self.interval = hAbility:GetSpecialValueFor("magma_damage_interval")
    self.radius = hAbility:GetSpecialValueFor("torrent_aoe")
    self.torrent_damage = hAbility:GetSpecialValueFor("torrent_damage")
    self.damage_type = hAbility:GetAbilityDamageType() or DAMAGE_TYPE_MAGICAL
    self.stun_duration = hAbility:GetSpecialValueFor("torrent_stun_duration")
    self.totem_rising_duration = hAbility:GetSpecialValueFor("totem_rising_duration")
    self.damage_per_second = hAbility:GetSpecialValueFor("magma_damage_per_second")
    --self.heal_per_second = hAbility:GetSpecialValueFor("magma_heal_per_second")
    self.aoe_per_second = hAbility:GetSpecialValueFor("magma_spread_speed")
    self.magma_radius =  hAbility:GetSpecialValueFor("magma_initial_radius")
    self.max_radius = hAbility:GetSpecialValueFor("magma_radius_max")

    self.nFXIndex = ParticleManager:CreateParticle("particles/magma_boss/boss_magma_mage_volcano_indicator1.vpcf", PATTACH_WORLDORIGIN, parent)
    ParticleManager:SetParticleControl(self.nFXIndex, 0, parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(self.nFXIndex, 1, Vector(self.radius, self.delay, 0))
    self.nFXIndex2 = ParticleManager:CreateParticle("particles/magma_boss/boss_magma_mage_volcano_embers.vpcf", PATTACH_WORLDORIGIN, parent)
    ParticleManager:SetParticleControl(self.nFXIndex2, 2, parent:GetAbsOrigin())

    self.bErupted = false
    self:StartIntervalThink(self.delay)
  end
end

function modifier_magma_boss_volcano_thinker:OnDestroy()
  if IsServer() then
    if self.nFXIndex then
      ParticleManager:DestroyParticle(self.nFXIndex, false)
      ParticleManager:ReleaseParticleIndex(self.nFXIndex)
    end
    if self.nFXIndex2 then
      ParticleManager:DestroyParticle(self.nFXIndex2, false)
      ParticleManager:ReleaseParticleIndex(self.nFXIndex2)
    end
	if self.particle1 then
      ParticleManager:DestroyParticle(self.particle1, false)
      ParticleManager:ReleaseParticleIndex(self.particle1)
    end
	if self.particle2 then
      ParticleManager:DestroyParticle(self.particle2, false)
      ParticleManager:ReleaseParticleIndex(self.particle2)
    end
	if self.particle3 then
      ParticleManager:DestroyParticle(self.particle3, false)
      ParticleManager:ReleaseParticleIndex(self.particle3)
    end
	if self.particle4 then
      ParticleManager:DestroyParticle(self.particle4, false)
      ParticleManager:ReleaseParticleIndex(self.particle4)
    end
	if self.particle5 then
      ParticleManager:DestroyParticle(self.particle5, false)
      ParticleManager:ReleaseParticleIndex(self.particle5)
    end
    -- Instead of UTIL_Remove(self:GetParent())
    local parent = self:GetParent()
    if parent and not parent:IsNull() then
      parent:AddNoDraw()
      parent:ForceKill(false)
    end
  end
end

function modifier_magma_boss_volcano_thinker:OnIntervalThink()
  if self.bErupted == true then
    local aoe_per_interval = self.aoe_per_second*self.interval
    --local heal_per_interval = self.heal_per_second*self.interval
    local damage_per_interval = self.damage_per_second*self.interval

    local hParent = self:GetParent()
    local ability = self:GetAbility()
    local damage_table = {
        attacker = self:GetCaster(),
        damage = damage_per_interval,
        damage_type = self.damage_type,
        ability = ability,
    }
    local units = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), hParent, self.magma_radius, DOTA_UNIT_TARGET_TEAM_BOTH, bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC), DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

    for _, unit in pairs(units) do
      if unit and not unit:IsNull() then
        local unit_origin = unit:GetOrigin()
        local ground_origin = GetGroundPosition(unit_origin, unit)
        local unit_z = unit_origin.z
        local ground_z = ground_origin.z
        if not unit:HasFlyMovementCapability() and unit_z - ground_z < 10 then
          -- Heals allies, damages enemies only if touching the magma on the ground or underground
          if unit:GetTeamNumber() == hParent:GetTeamNumber() then
            --unit:Heal(heal_per_interval, ability)
          elseif not unit:HasModifier("modifier_magma_boss_volcano") then
            -- Visual Effect
            unit:AddNewModifier(damage_table.attacker, ability, "modifier_magma_boss_volcano_burning_effect", {duration = self.interval+0.1})
            -- Damage
            damage_table.victim = unit
            ApplyDamage(damage_table)
          end
        end
      end
    end

    self.magma_radius = math.min(self.magma_radius + math.sqrt(aoe_per_interval/math.pi), self.max_radius)

    -- Particles
	-- Remove the eruption
    if self.particle1 then
      ParticleManager:DestroyParticle(self.particle1, false)
      ParticleManager:ReleaseParticleIndex(self.particle1)
      self.particle1 = nil
    end
    -- Update other particles
	ParticleManager:SetParticleControl(self.particle2, 1, Vector(self.magma_radius, 0, 0))

    if self.magma_radius >= self.max_radius / 2 and not self.particle4 then
	  self.particle4 = ParticleManager:CreateParticle("particles/magma_boss/magma.vpcf", PATTACH_WORLDORIGIN, hParent)
      ParticleManager:SetParticleControl(self.particle4, 0, hParent:GetAbsOrigin())
	  ParticleManager:SetParticleControl(self.particle4, 4, Vector(self.magma_radius, 0, 0))
      ParticleManager:SetParticleControl(self.particle4, 2, Vector(self:GetRemainingTime(), 0, 0))
	end
    if self.magma_radius == self.max_radius and not self.particle5 then
	  self.particle5 = ParticleManager:CreateParticle("particles/magma_boss/magma.vpcf", PATTACH_WORLDORIGIN, hParent)
      ParticleManager:SetParticleControl(self.particle5, 0, hParent:GetAbsOrigin())
	  ParticleManager:SetParticleControl(self.particle5, 4, Vector(self.max_radius-50, 0, 0))
      ParticleManager:SetParticleControl(self.particle5, 2, Vector(self:GetRemainingTime(), 0, 0))
	end
  else
    self:MagmaErupt()
    self.bErupted = true
    self:StartIntervalThink(self.interval)
  end
end


function modifier_magma_boss_volcano_thinker:CheckState()
  local state = {
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
  }
  if self.bErupted == false then
    state[MODIFIER_STATE_NO_HEALTH_BAR] = true
    state[MODIFIER_STATE_UNSELECTABLE] = true
    state[MODIFIER_STATE_INVISIBLE] = true
    state[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true
  end
  return state
end

function modifier_magma_boss_volcano_thinker:MagmaErupt()
  local hParent = self:GetParent()
  local hCaster = self:GetCaster()
  local hAbility = self:GetAbility()
  local center = hParent:GetAbsOrigin()

  -- Remove the indicator
  if self.nFXIndex then
    ParticleManager:DestroyParticle(self.nFXIndex, false)
    ParticleManager:ReleaseParticleIndex(self.nFXIndex)
    self.nFXIndex = nil
  end

  -- Eruption particle
  self.particle1 = ParticleManager:CreateParticle("particles/magma_boss/boss_magma_mage_volcano1.vpcf", PATTACH_WORLDORIGIN, hParent)
  ParticleManager:SetParticleControl(self.particle1, 0, center)
  ParticleManager:SetParticleControl(self.particle1, 1, Vector(self.radius, 0, 0))

  -- Eruption sound
  EmitSoundOnLocationWithCaster(center, "Magma_Boss.VolcanoErupt", hCaster)

  hParent:AddNewModifier(hCaster, hAbility, "modifier_magma_boss_volcano_thinker_child", {duration = self.totem_rising_duration})

  local enemies = FindUnitsInRadius(hParent:GetTeamNumber(), center, hParent, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC), DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

  local damage_table = {
    attacker = hCaster,
    damage = self.torrent_damage,
    damage_type = self.damage_type,
    ability = hAbility,
  }

  for _, enemy in pairs(enemies) do
    if enemy and not enemy:IsNull() then
      -- Apply stun and motion controller
      enemy:AddNewModifier(hCaster, hAbility, "modifier_magma_boss_volcano", {duration = self.stun_duration})

      -- Apply damage
      damage_table.victim = enemy
      ApplyDamage(damage_table)
    end
  end

  local duration = hAbility:GetSpecialValueFor("totem_duration_max")

  -- Magma particles 
  self.particle2 = ParticleManager:CreateParticle("particles/magma_boss/boss_magma_mage_volcano_indicator1.vpcf", PATTACH_WORLDORIGIN, hParent)
  ParticleManager:SetParticleControl(self.particle2, 0, center)
  ParticleManager:SetParticleControl(self.particle2, 1, Vector(self.magma_radius, 0, 0))
  
  self.particle3 = ParticleManager:CreateParticle("particles/magma_boss/magma_center.vpcf", PATTACH_WORLDORIGIN, hParent)
  ParticleManager:SetParticleControl(self.particle3, 0, center)
  ParticleManager:SetParticleControl(self.particle3, 2, Vector(duration, 0, 0))

  -- Destroy trees
  GridNav:DestroyTreesAroundPoint(center, self.radius, false)
end

function modifier_magma_boss_volcano_thinker:OnAttackLanded(params)
  if IsServer() then
    local hParent = self:GetParent()
    if params.target == hParent then
      local hAttacker = params.attacker
      if hAttacker then
        local damage_dealt = 1
        if hAttacker:IsRealHero() then
          -- This is correct if HP is 32
          damage_dealt = 8
        end
        -- To prevent dead staying in memory (preventing SetHealth(0) or SetHealth(-value) )
        if hParent:GetHealth() - damage_dealt <= 0 then
          hParent:Kill(self:GetAbility(), hAttacker)
        else
          hParent:SetHealth(hParent:GetHealth() - damage_dealt)
        end
      end
    end
  end
end

function modifier_magma_boss_volcano_thinker:GetAbsoluteNoDamagePhysical()
  return 1
end

function modifier_magma_boss_volcano_thinker:GetAbsoluteNoDamageMagical()
  return 1
end

function modifier_magma_boss_volcano_thinker:GetAbsoluteNoDamagePure()
  return 1
end

function modifier_magma_boss_volcano_thinker:GetDisableHealing()
  return 1
end

function modifier_magma_boss_volcano_thinker:GetMagmaRadius()
  return self.magma_radius
end

---------------------------------------------------------------------------------------------------

modifier_magma_boss_volcano_thinker_child = class(ModifierBaseClass)

function modifier_magma_boss_volcano_thinker_child:IsHidden()
  return true
end

function modifier_magma_boss_volcano_thinker_child:IsDebuff()
  return false
end

function modifier_magma_boss_volcano_thinker_child:IsPurgable()
  return false
end

function modifier_magma_boss_volcano_thinker_child:RemoveOnDeath()
  return true
end

function modifier_magma_boss_volcano_thinker_child:OnCreated(kv)
  if IsServer() then
    self.duration = kv.duration
    self.end_model_scale = self:GetAbility():GetSpecialValueFor("totem_model_scale")
    self:StartIntervalThink(1/15)
  end
end

function modifier_magma_boss_volcano_thinker_child:OnIntervalThink()
  local scale = self.end_model_scale*(1-self:GetRemainingTime()/self.duration)
  self:GetParent():SetModelScale(scale)
end

function modifier_magma_boss_volcano_thinker_child:CheckState()
  local state = {
    [MODIFIER_STATE_UNSELECTABLE] = true,
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
  }
  return state
end
