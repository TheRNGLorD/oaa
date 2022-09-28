---
--- Created by Zarnotox.
--- DateTime: 03-Dec-17 21:32
---
item_dagger_of_moriah_1 = class(TransformationBaseClass)

LinkLuaModifier("modifier_item_dagger_of_moriah_passive", "items/dagger_of_moriah.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_dagger_of_moriah_frostbite", "items/dagger_of_moriah.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_dagger_of_moriah_sangromancy", "items/dagger_of_moriah.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_dagger_of_moriah_sangromancy_effect", "items/dagger_of_moriah.lua", LUA_MODIFIER_MOTION_NONE)

---------------------------------------------------------------------------------------------------

function item_dagger_of_moriah_1:GetIntrinsicModifierName()
  return "modifier_item_dagger_of_moriah_passive"
end

function item_dagger_of_moriah_1:GetTransformationModifierName()
  return "modifier_item_dagger_of_moriah_sangromancy"
end

item_dagger_of_moriah_2 = item_dagger_of_moriah_1

---------------------------------------------------------------------------------------------------

modifier_item_dagger_of_moriah_passive = class(ModifierBaseClass)

function modifier_item_dagger_of_moriah_passive:IsHidden()
  return true
end

function modifier_item_dagger_of_moriah_passive:IsDebuff()
  return false
end

function modifier_item_dagger_of_moriah_passive:IsPurgable()
  return false
end

function modifier_item_dagger_of_moriah_passive:GetAttributes()
  return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_dagger_of_moriah_passive:OnCreated()
  local parent = self:GetParent()
  local ability = self:GetAbility()
  if ability and not ability:IsNull() then
    self.stats = ability:GetSpecialValueFor("bonus_all_stats")
    self.hp_regen = ability:GetSpecialValueFor("bonus_health_regen")
    self.mp_regen = ability:GetSpecialValueFor("bonus_mana_regen")
    self.spell_amp = ability:GetSpecialValueFor("spell_amp_per_intellect")
  end

  if parent:IsRealHero() then
    self.int = parent:GetIntellect()
  end

  if IsServer() then
    if parent:IsRealHero() then
      parent:CalculateStatBonus(true)
    end
    -- Check only on the server
    if self:IsFirstItemInInventory() then
      self:SetStackCount(2)
    else
      self:SetStackCount(1)
    end
  end
  self:StartIntervalThink(0.3)
end

function modifier_item_dagger_of_moriah_passive:OnRefresh()
  local parent = self:GetParent()
  local ability = self:GetAbility()
  if ability and not ability:IsNull() then
    self.stats = ability:GetSpecialValueFor("bonus_all_stats")
    self.hp_regen = ability:GetSpecialValueFor("bonus_health_regen")
    self.mp_regen = ability:GetSpecialValueFor("bonus_mana_regen")
    self.spell_amp = ability:GetSpecialValueFor("spell_amp_per_intellect")
  end

  if parent:IsRealHero() then
    self.int = parent:GetIntellect()
  end

  if IsServer() then
    if parent:IsRealHero() then
      parent:CalculateStatBonus(true)
    end
    -- Check only on the server
    if self:IsFirstItemInInventory() then
      self:SetStackCount(2)
    else
      self:SetStackCount(1)
    end
  end
end

function modifier_item_dagger_of_moriah_passive:OnIntervalThink()
  if IsServer() then
    if self:IsFirstItemInInventory() then
      self:SetStackCount(2)
    else
      self:SetStackCount(1)
      return -- no need to continue on the server if not the first item
    end
  elseif self:GetStackCount() ~= 2 then
    return -- no need to continue on the client
  end

  local parent = self:GetParent()
  if parent:IsRealHero() then
    self.int = parent:GetIntellect()
  end

  if IsServer() and parent:IsRealHero() then
    parent:CalculateStatBonus(true)
  end
end

function modifier_item_dagger_of_moriah_passive:DeclareFunctions()
  return {
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
    MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    MODIFIER_EVENT_ON_TAKEDAMAGE,
  }
end

function modifier_item_dagger_of_moriah_passive:GetModifierBonusStats_Strength()
  return self.stats or self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_dagger_of_moriah_passive:GetModifierBonusStats_Agility()
  return self.stats or self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_dagger_of_moriah_passive:GetModifierBonusStats_Intellect()
  return self.stats or self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_dagger_of_moriah_passive:GetModifierConstantHealthRegen()
  return self.hp_regen or self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end

function modifier_item_dagger_of_moriah_passive:GetModifierConstantManaRegen()
  return self.mp_regen or self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_item_dagger_of_moriah_passive:GetModifierSpellAmplify_Percentage()
  if self:GetStackCount() == 2 then
    local spell_amp_per_int = self.spell_amp or self:GetAbility():GetSpecialValueFor("spell_amp_per_intellect")
    if self.int and spell_amp_per_int then
      return spell_amp_per_int * self.int
    end
  else
    return 0
  end
end

if IsServer() then
  function modifier_item_dagger_of_moriah_passive:OnTakeDamage(event)
    local parent = self:GetParent()
    local attacker = event.attacker
    local damaged_unit = event.unit
    local inflictor = event.inflictor

    -- Check if attacker exists
    if not attacker or attacker:IsNull() then
      return
    end

    -- Check if attacker has this modifier
    if attacker ~= parent then
      return
    end

    -- Check if damaged entity exists
    if not damaged_unit or damaged_unit:IsNull() then
      return
    end

    -- Ignore self damage and allies
    if damaged_unit == attacker or damaged_unit:GetTeamNumber() == attacker:GetTeamNumber() then
      return
    end

    -- Check if attacker is dead
    if not attacker:IsAlive() then
      return
    end

    -- Check if damaged entity is an item, rune or something weird
    if damaged_unit.GetUnitName == nil then
      return
    end

    -- Don't affect buildings, wards and invulnerable units.
    if damaged_unit:IsTower() or damaged_unit:IsBarracks() or damaged_unit:IsBuilding() or damaged_unit:IsOther() or damaged_unit:IsInvulnerable() then
      return
    end

    -- Disable stacking with Spirit Vessel (because Spirit Vessel has a better heal reduction)
    if damaged_unit:HasModifier("modifier_spirit_vessel_oaa_debuff_with_charge") then
      return
    end

    local ability = self:GetAbility()
    if not ability or ability:IsNull() then
      return
    end

    -- Check if inflictor exists (if it doesn't, it's not a spell) and damage category
    if not inflictor or event.damage_category ~= DOTA_DAMAGE_CATEGORY_SPELL then
      return
    end

    -- If inflictor is an item (radiance e.g.), don't continue
    if inflictor and inflictor:IsItem() then
      return
    end

    -- Ignore damage that has the no-reflect flag
    if bit.band(event.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) > 0 then
      return
    end

    -- Ignore damage that has hp removal flag
    if bit.band(event.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) > 0 then
      return
    end

    -- Ignore damage that is <= 0
    if event.damage <= 0 then
      return
    end

    -- Apply Heal reduction debuff
    damaged_unit:AddNewModifier(parent, ability, "modifier_item_dagger_of_moriah_frostbite", {duration = ability:GetSpecialValueFor("heal_reduction_duration")})
  end
end

--------------------------------------------------------------------------------

modifier_item_dagger_of_moriah_frostbite = class(ModifierBaseClass)

function modifier_item_dagger_of_moriah_frostbite:IsHidden()
  return false
end

function modifier_item_dagger_of_moriah_frostbite:IsDebuff()
  return true
end

function modifier_item_dagger_of_moriah_frostbite:IsPurgable()
  return true
end

function modifier_item_dagger_of_moriah_frostbite:OnCreated()
  local ability = self:GetAbility()
  if ability then
    self.heal_reduction = ability:GetSpecialValueFor("heal_reduction_percent")
  else
    self.heal_reduction = -45
  end
end

modifier_item_dagger_of_moriah_frostbite.OnRefresh = modifier_item_dagger_of_moriah_frostbite.OnCreated

function modifier_item_dagger_of_moriah_frostbite:DeclareFunctions()
  return {
    MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE,
  }
end

function modifier_item_dagger_of_moriah_frostbite:GetModifierHealAmplify_PercentageTarget()
  -- Disable stacking with Spirit Vessel (because Spirit Vessel has a better heal reduction)
  if self:GetParent():HasModifier("modifier_spirit_vessel_oaa_debuff_with_charge") then
    return 0
  end
  return 0 - math.abs(self.heal_reduction)
end

function modifier_item_dagger_of_moriah_frostbite:GetModifierHPRegenAmplify_Percentage()
  -- Disable stacking with Spirit Vessel (because Spirit Vessel has a better heal reduction)
  if self:GetParent():HasModifier("modifier_spirit_vessel_oaa_debuff_with_charge") then
    return 0
  end
  return 0 - math.abs(self.heal_reduction)
end

function modifier_item_dagger_of_moriah_frostbite:GetModifierLifestealRegenAmplify_Percentage()
  -- Disable stacking with Spirit Vessel (because Spirit Vessel has a better heal reduction)
  if self:GetParent():HasModifier("modifier_spirit_vessel_oaa_debuff_with_charge") then
    return 0
  end
  return 0 - math.abs(self.heal_reduction)
end

function modifier_item_dagger_of_moriah_frostbite:GetModifierSpellLifestealRegenAmplify_Percentage()
  -- Disable stacking with Spirit Vessel (because Spirit Vessel has a better heal reduction)
  if self:GetParent():HasModifier("modifier_spirit_vessel_oaa_debuff_with_charge") then
    return 0
  end
  return 0 - math.abs(self.heal_reduction)
end

function modifier_item_dagger_of_moriah_frostbite:GetEffectName()
  return "particles/items4_fx/spirit_vessel_damage.vpcf"
end

function modifier_item_dagger_of_moriah_frostbite:GetTexture()
  return "custom/dagger_of_moriah_2"
end

---------------------------------------------------------------------------------------------------

modifier_item_dagger_of_moriah_sangromancy = class(ModifierBaseClass)

function modifier_item_dagger_of_moriah_sangromancy:IsHidden()
  return false
end

function modifier_item_dagger_of_moriah_sangromancy:IsDebuff()
  return false
end

-- this doesn't do anything since it's an aura, and auras are undispellable no matter what you set here
function modifier_item_dagger_of_moriah_sangromancy:IsPurgable()
  return false
end

function modifier_item_dagger_of_moriah_sangromancy:IsAura()
  return true
end

function modifier_item_dagger_of_moriah_sangromancy:GetModifierAura()
  return "modifier_item_dagger_of_moriah_sangromancy_effect"
end

function modifier_item_dagger_of_moriah_sangromancy:GetAuraRadius()
  return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_item_dagger_of_moriah_sangromancy:GetAuraSearchTeam()
  return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_item_dagger_of_moriah_sangromancy:GetAuraSearchType()
  return bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC)
end

-- Prevent stacking with Veil of Discord
function modifier_item_dagger_of_moriah_sangromancy:GetAuraEntityReject(hEntity)
  if hEntity:HasModifier("modifier_item_veil_of_discord_debuff") then
    return true
  end
  return false
end

function modifier_item_dagger_of_moriah_sangromancy:OnCreated()
  --local spell = self:GetAbility()

  --spell.mod = self

  --self.spellamp = spell:GetSpecialValueFor( "sangromancy_spell_amp" )
  --self.selfDamage = spell:GetSpecialValueFor( "sangromancy_self_damage" )
  --self.bonusDamagefromOthers = spell:GetSpecialValueFor( "sangromancy_bonus_damage_from_others" )

  if IsServer() and self.nPreviewFX == nil then
    self.nPreviewFX = ParticleManager:CreateParticle( "particles/items/dagger_of_moriah/dagger_of_moriah_ambient_smoke.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControlEnt( self.nPreviewFX, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetOrigin(), true )
  end
end

function modifier_item_dagger_of_moriah_sangromancy:OnDestroy()
  if IsServer() and self.nPreviewFX ~= nil then
    ParticleManager:DestroyParticle( self.nPreviewFX, false )
    ParticleManager:ReleaseParticleIndex(self.nPreviewFX)
    self.nPreviewFX = nil
  end
end
--[[
function modifier_item_dagger_of_moriah_sangromancy:OnRefresh( event )
  local spell = self:GetAbility()

  spell.mod = self

  self.spellamp = spell:GetSpecialValueFor( "sangromancy_spell_amp" )
  self.selfDamage = spell:GetSpecialValueFor( "sangromancy_self_damage" )
  self.bonusDamagefromOthers = spell:GetSpecialValueFor( "sangromancy_bonus_damage_from_others" )
end

function modifier_item_dagger_of_moriah_sangromancy:OnRemoved()
  local spell = self:GetAbility()

  if spell and not spell:IsNull() then
    spell.mod = nil
  end
end

function modifier_item_dagger_of_moriah_sangromancy:DeclareFunctions()
  local funcs = {
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    MODIFIER_EVENT_ON_TAKEDAMAGE,
  }

  return funcs
end

function modifier_item_dagger_of_moriah_sangromancy:GetModifierSpellAmplify_Percentage( event )
  local spell = self:GetAbility()

  return self.spellamp or spell:GetSpecialValueFor( "sangromancy_spell_amp" )
end

function modifier_item_dagger_of_moriah_sangromancy:GetModifierIncomingDamage_Percentage( event )
  local spell = self:GetAbility()
  if event.attacker == self:GetParent() then
    return 0
  else
    return self.bonusDamagefromOthers or spell:GetSpecialValueFor( "sangromancy_bonus_damage_from_others" )
  end
end

function modifier_item_dagger_of_moriah_sangromancy:OnTakeDamage(event)
  if event.damage_category == 0 and event.attacker == self:GetParent() and not (event.unit == self:GetParent()) and bit.band(event.damage_flags, DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION) == 0 then

    local damage = {
      victim = event.attacker,
      attacker = event.attacker,
      damage = event.original_damage * (self.selfDamage / 100),
      damage_type = event.damage_type,
      damage_flags = bit.bor(event.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION, DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, DOTA_DAMAGE_FLAG_NON_LETHAL),
      ability = self:GetAbility(),
    }

    ApplyDamage( damage )

    if IsServer() then
      local unit = self:GetParent()
      if unit.flashFX == nil and unit:HasModifier( "modifier_item_dagger_of_moriah_sangromancy" ) then
        unit.flashFX = ParticleManager:CreateParticle( "particles/items/dagger_of_moriah/dagger_of_moriah_ambient_smoke_flash.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
        ParticleManager:SetParticleControlEnt( unit.flashFX, 0, unit, PATTACH_ABSORIGIN_FOLLOW, nil, unit:GetOrigin(), true )
        Timers:CreateTimer(0.3, function()
          ParticleManager:DestroyParticle(unit.flashFX, false)
          ParticleManager:ReleaseParticleIndex(unit.flashFX)
          unit.flashFX = nil
        end)
      end
    end
  end
end
]]

function modifier_item_dagger_of_moriah_sangromancy:GetTexture()
  return "custom/dagger_of_moriah_2_active"
end

--------------------------------------------------------------------------------

modifier_item_dagger_of_moriah_sangromancy_effect = class(ModifierBaseClass)

function modifier_item_dagger_of_moriah_sangromancy_effect:IsHidden()
  return false
end

function modifier_item_dagger_of_moriah_sangromancy_effect:IsDebuff()
  return true
end

function modifier_item_dagger_of_moriah_sangromancy_effect:IsPurgable()
  return false
end

function modifier_item_dagger_of_moriah_sangromancy_effect:OnCreated()
  local ability = self:GetAbility()
  if ability and not ability:IsNull() then
    --self.magic_resistance = ability:GetSpecialValueFor("magic_resistance")
    self.magic_dmg_amp = ability:GetSpecialValueFor("magic_dmg_amp")
  end
end

function modifier_item_dagger_of_moriah_sangromancy_effect:OnRefresh()
  self:OnCreated()
end

function modifier_item_dagger_of_moriah_sangromancy_effect:DeclareFunctions()
  return {
    --MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  }
end

--function modifier_item_dagger_of_moriah_sangromancy_effect:GetModifierMagicalResistanceBonus()
  --return self.magic_resistance or -25
--end

function modifier_item_dagger_of_moriah_sangromancy_effect:GetModifierIncomingDamage_Percentage(keys)
  if keys.damage_category == DOTA_DAMAGE_CATEGORY_SPELL and keys.damage_type == DAMAGE_TYPE_MAGICAL then
    return self.magic_dmg_amp or 35
  end
  return 0
end

function modifier_item_dagger_of_moriah_sangromancy_effect:GetTexture()
  return "custom/dagger_of_moriah_2_active"
end
