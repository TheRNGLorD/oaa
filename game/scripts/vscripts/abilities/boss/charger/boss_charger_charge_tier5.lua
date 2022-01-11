LinkLuaModifier("modifier_boss_charger_charge_tier5", "abilities/boss/charger/boss_charger_charge_tier5.lua", LUA_MODIFIER_MOTION_NONE) --- BATHS HEAVY IMPORTED
LinkLuaModifier("modifier_boss_charger_pillar_debuff", "abilities/boss/charger/modifier_boss_charger_pillar_debuff.lua", LUA_MODIFIER_MOTION_NONE) --- PARTH WEVY IMPARTAYT
LinkLuaModifier("modifier_boss_charger_hero_pillar_debuff", "abilities/boss/charger/modifier_boss_charger_hero_pillar_debuff.lua", LUA_MODIFIER_MOTION_NONE) --- PITH YEVY IMPARTIAL
LinkLuaModifier("modifier_boss_charger_trampling", "abilities/boss/charger/modifier_boss_charger_trampling.lua", LUA_MODIFIER_MOTION_NONE) --- MARTH FAIRY IPARTY
LinkLuaModifier("modifier_boss_charger_glanced", "abilities/boss/charger/boss_charger_charge.lua", LUA_MODIFIER_MOTION_NONE)

boss_charger_charge_tier5 = class(AbilityBaseClass)

function boss_charger_charge_tier5:OnSpellStart()
  self:GetCaster():EmitSound("Boss_Charger.Charge.Begin")
end

function boss_charger_charge_tier5:OnChannelFinish(interrupted) --You misspelled "Interrupted"
  local caster = self:GetCaster()
  if interrupted then
    self:StartCooldown(self:GetSpecialValueFor("cooldown") / 2)
    caster:StopSound("Boss_Charger.Charge.Begin")
    return
  end
  self:StartCooldown(self:GetSpecialValueFor("cooldown"))

  caster:AddNewModifier(caster, self, "modifier_boss_charger_charge_tier5", {
    duration = self:GetSpecialValueFor( "charge_duration" )
  })

  caster:EmitSound("Boss_Charger.Charge.Movement")

  return true
end

function boss_charger_charge_tier5:OnOwnerDied()
  self:GetCaster():StopSound("Boss_Charger.Charge.Movement")
end

---------------------------------------------------------------------------------------------------

modifier_boss_charger_charge_tier5 = class(ModifierBaseClass)

function modifier_boss_charger_charge_tier5:IsHidden()
  return false
end

function modifier_boss_charger_charge_tier5:OnIntervalThink()
  if not IsServer() then
    return
  end

  local caster = self:GetCaster()

  if self.distance_traveled >= self.max_distance then
    return self:EndCharge()
  end

  local origin = caster:GetAbsOrigin()
  caster:SetAbsOrigin(origin + (self.direction * self.speed))
  self.distance_traveled = self.distance_traveled + (self.direction * self.speed):Length2D()

  local glance_candidates = FindUnitsInRadius(
    caster:GetTeamNumber(),
    caster:GetAbsOrigin(),
    nil,
    self.glancing_width,
    DOTA_UNIT_TARGET_TEAM_ENEMY,
    DOTA_UNIT_TARGET_ALL,
    DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
    FIND_CLOSEST,
    false
  )

  for _, v in pairs(glance_candidates) do
    if v and not v:IsNull() and not self.glanced[v:entindex()] then
      self.glanced[v:entindex()] = true

      -- Slow debuff
      if not v:IsMagicImmune() then
        v:AddNewModifier(caster, self:GetAbility(), "modifier_boss_charger_glanced", {duration = self.glancing_duration})
      end

      -- Damage
      ApplyDamage({
        victim = v,
        attacker = caster,
        damage = self.glancing_damage,
        damage_type = DAMAGE_TYPE_PHYSICAL,
        damage_flags = bit.bor(DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS, DOTA_DAMAGE_FLAG_BYPASSES_BLOCK),
        ability = self:GetAbility()
      })
    end
  end

  local units = FindUnitsInRadius(
    caster:GetTeamNumber(),
    caster:GetAbsOrigin(),
    nil,
    50,
    DOTA_UNIT_TARGET_TEAM_BOTH,
    DOTA_UNIT_TARGET_ALL,
    bit.bor(DOTA_UNIT_TARGET_FLAG_INVULNERABLE, DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD),
    FIND_CLOSEST,
    false
  )

  local function isTower (tower)
    return tower:GetUnitName() == "npc_dota_boss_charger_pillar"
  end

  local function isValidTarget (unit)
    if unit:GetTeam() == caster:GetTeam() then
      return false
    end
    if unit.IsRealHero == nil then
      return false
    end
    if (unit:IsInvulnerable() or unit:IsOutOfGame()) and not isTower(unit) then
      return false
    end
    return true
  end

  local towers = filter(isTower, iter(units))
  local targets = filter(isValidTarget, iter(units))

  if targets:length() > 0 then
    targets:each(function (target)
      if not target:IsRealHero() then
        target:Kill(self:GetAbility(), caster)
        return
      end
      if not target:HasModifier('modifier_boss_charger_trampling') then
        target:AddNewModifier(caster, self:GetAbility(), "modifier_boss_charger_trampling", {})
        table.insert(self.draggedHeroes, target)
        caster:EmitSound("Boss_Charger.Charge.HeroImpact")
      end
    end)
  end
  if towers:length() > 0 then
    -- we hit a tower!
    local tower = towers:head()
    tower:Kill(self:GetAbility(), caster)

    if #self.draggedHeroes > 0 then
      iter(self.draggedHeroes):each(function (hero)
        hero:AddNewModifier(caster, self:GetAbility(), "modifier_boss_charger_hero_pillar_debuff", {
          duration = self.hero_stun_duration
        })

        ApplyDamage({
          victim = hero,
          attacker = caster,
          damage = self.hero_pillar_damage,
          damage_type = DAMAGE_TYPE_PHYSICAL,
          damage_flags = bit.bor(DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS, DOTA_DAMAGE_FLAG_BYPASSES_BLOCK),
          ability = self:GetAbility()
        })
      end)
    else
      caster:AddNewModifier(caster, caster:FindAbilityByName("boss_charger_super_armor"), "modifier_boss_charger_pillar_debuff", {
        duration = self.debuff_duration
      })
    end

    caster:EmitSound("Boss_Charger.Charge.TowerImpact")
    return self:EndCharge()
  end
end

function modifier_boss_charger_charge_tier5:EndCharge()
  local caster = self:GetCaster()

  caster:InterruptMotionControllers(true)
  FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true)
  self:StartIntervalThink(-1)
  self:Destroy()
  return 0
end

function modifier_boss_charger_charge_tier5:OnCreated(keys)
  if not IsServer() then
    return
  end

  self.draggedHeroes = {}
  self.glanced = {}

  local ability = self:GetAbility()
  local cursorPosition = ability:GetCursorPosition()
  local caster = self:GetCaster()
  local origin = caster:GetAbsOrigin()
  local direction = (cursorPosition - origin):Normalized()

  direction.z = 0

  self.direction = direction
  self.speed = ability:GetSpecialValueFor( "speed" )
  self.distance_traveled = 0
  self.max_distance = ability:GetSpecialValueFor( "distance" )
  self.debuff_duration = ability:GetSpecialValueFor( "debuff_duration" )
  self.debuff_duration = ability:GetSpecialValueFor( "debuff_duration" )
  self.hero_stun_duration = ability:GetSpecialValueFor( "hero_stun_duration" )
  self.hero_pillar_damage = ability:GetSpecialValueFor( "hero_pillar_damage" )
  self.glancing_damage = ability:GetSpecialValueFor( "glancing_damage" )
  self.glancing_duration = ability:GetSpecialValueFor( "glancing_duration" )
  self.glancing_width = ability:GetSpecialValueFor( "glancing_width" )

  self:StartIntervalThink(0.01)
end
