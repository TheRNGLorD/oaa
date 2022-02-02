modifier_aoe_radius_increase_oaa = class(ModifierBaseClass)

function modifier_aoe_radius_increase_oaa:IsHidden()
  return false
end

function modifier_aoe_radius_increase_oaa:IsPurgable()
  return false
end

function modifier_aoe_radius_increase_oaa:RemoveOnDeath()
  return false
end

local aoe_keywords = {
  aoe = true,
  area_of_effect = true,
  radius = true,
}

local other_keywords = {
  scepter_range = true,
  arrow_range_multiplier = true,
  wave_width = true,
  agility_range = true,
  aftershock_range = true,
  echo_slam_damage_range = true,
  echo_slam_echo_search_range = true,
  echo_slam_echo_range = true,
  torrent_max_distance = true,
  cleave_ending_width = true,
  cleave_distance = true,
  ghostship_width = true,
  dragon_slave_distance = true,
  dragon_slave_width_initial = true,
  dragon_slave_width_end = true,
  width = true,
  arrow_width = true,
  requiem_line_width_start = true,
  requiem_line_width_end = true,
  orb_vision = true,
  hook_distance = true,
  flesh_heap_range = true,
  hook_width = true,
  end_distance = true,
  burrow_width = true,
  splash_width = true,
  splash_range = true,
  jump_range = true,
  bounce_range = true,
  attack_spill_range = true,
  attack_spill_width = true,
}

function modifier_aoe_radius_increase_oaa:OnCreated()
  self.aoe_multiplier = 1.5
end

function modifier_aoe_radius_increase_oaa:DeclareFunctions()
  return {
    MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
    MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
  }
end

function modifier_aoe_radius_increase_oaa:GetModifierOverrideAbilitySpecial(keys)
  if not keys.ability or not keys.ability_special_value or not aoe_keywords then
    return 0
  end

  for keyword, _ in pairs(aoe_keywords) do
    if string.find(keys.ability_special_value, keyword) then
      return 1
    end
  end

  if other_keywords and other_keywords[keys.ability_special_value] then
    return 1
  end

  return 0
end

function modifier_aoe_radius_increase_oaa:GetModifierOverrideAbilitySpecialValue(keys)
  local value = keys.ability:GetLevelSpecialValueNoOverride(keys.ability_special_value, keys.ability_special_level)
  for keyword, _ in pairs(aoe_keywords) do
    if string.find(keys.ability_special_value, keyword) then
      return value * self.aoe_multiplier
    end
  end

  if other_keywords and other_keywords[keys.ability_special_value] then
    return value * self.aoe_multiplier
  end

  return value
end

function modifier_aoe_radius_increase_oaa:GetTexture()
  return "void_spirit_dissimilate"
end
