modifier_chaos_oaa = class(ModifierBaseClass)

function modifier_chaos_oaa:IsHidden()
  return self:GetElapsedTime() > 5 * 60
end

function modifier_chaos_oaa:IsDebuff()
  return false
end

function modifier_chaos_oaa:IsPurgable()
  return false
end

function modifier_chaos_oaa:RemoveOnDeath()
  return false
end

function modifier_chaos_oaa:OnCreated()
  if not IsServer() then
    return
  end

  local parent = self:GetParent()

  self.initial_modifiers = {
    "modifier_any_damage_crit_oaa",
    "modifier_any_damage_lifesteal_oaa",
    "modifier_aoe_radius_increase_oaa",
    "modifier_brawler_oaa",
    "modifier_explosive_death_oaa",
    "modifier_ham_oaa",
    "modifier_hyper_experience_oaa",
    "modifier_magus_oaa",
    "modifier_pro_active_oaa",
    "modifier_range_increase_oaa",
    "modifier_rend_oaa",
    "modifier_sorcerer_oaa",
    "modifier_spell_block_oaa",
    "modifier_courier_kill_bonus_oaa",
    "modifier_double_multiplier_oaa",
    "modifier_bonus_armor_negative_magic_resist_oaa",
    "modifier_angel_oaa",
    "modifier_blood_magic_oaa",
    "modifier_troll_switch_oaa",
  }

  self.mid_game_modifiers = {
    "modifier_any_damage_crit_oaa",
    "modifier_any_damage_lifesteal_oaa",
    "modifier_aoe_radius_increase_oaa",
    "modifier_brute_oaa",
    "modifier_debuff_duration_oaa",
    "modifier_echo_strike_oaa",
    "modifier_explosive_death_oaa",
    "modifier_ham_oaa",
    "modifier_magus_oaa",
    "modifier_no_cast_points_oaa",
    "modifier_pro_active_oaa",
    "modifier_range_increase_oaa",
    "modifier_rend_oaa",
    "modifier_sorcerer_oaa",
    "modifier_spell_block_oaa",
    "modifier_wisdom_oaa",
    "modifier_all_healing_amplify_oaa",
    "modifier_double_multiplier_oaa",
    "modifier_cursed_attack_oaa",
    "modifier_no_brain_oaa",
    "modifier_bonus_armor_negative_magic_resist_oaa",
    "modifier_true_sight_strike_oaa",
    "modifier_mr_phys_weak_oaa",
    "modifier_angel_oaa",
    "modifier_hero_anti_stun_oaa",
    "modifier_troll_switch_oaa",
    "modifier_blood_magic_oaa",
  }

  self.late_game_modifiers = {
    "modifier_any_damage_crit_oaa",
    "modifier_aoe_radius_increase_oaa",
    "modifier_brute_oaa",
    "modifier_debuff_duration_oaa",
    "modifier_echo_strike_oaa",
    "modifier_explosive_death_oaa",
    "modifier_ham_oaa",
    "modifier_magus_oaa",
    "modifier_nimble_oaa",
    "modifier_no_cast_points_oaa",
    "modifier_pro_active_oaa",
    "modifier_range_increase_oaa",
    "modifier_rend_oaa",
    "modifier_sorcerer_oaa",
    "modifier_spell_block_oaa",
    "modifier_wisdom_oaa",
    "modifier_all_healing_amplify_oaa",
    "modifier_double_multiplier_oaa",
    "modifier_bonus_armor_negative_magic_resist_oaa",
    "modifier_true_sight_strike_oaa",
    "modifier_mr_phys_weak_oaa",
    "modifier_angel_oaa",
    "modifier_hero_anti_stun_oaa",
    "modifier_troll_switch_oaa",
    "modifier_blood_magic_oaa",
  }

  -- "modifier_healer_oaa",
  self.healer_heroes = {

  }
  
  local function remove_mod_from_table(table1, mod)
    for k, v in pairs(table1) do
      if v == mod then
        table.remove(table1, k)
      end
    end
  end

  local random_mod = self.initial_modifiers[RandomInt(1, #self.initial_modifiers)]
  if not parent:HasModifier(random_mod) then
    parent:AddNewModifier(parent, nil, random_mod, {})
    self.last_mod = random_mod
  else
    -- Remove the found modifier from the lists
    remove_mod_from_table(self.initial_modifiers, random_mod)
    remove_mod_from_table(self.mid_game_modifiers, random_mod)
    remove_mod_from_table(self.late_game_modifiers, random_mod)

    local new_random = self.initial_modifiers[RandomInt(1, #self.initial_modifiers)]
    if not parent:HasModifier(new_random) then
      parent:AddNewModifier(parent, nil, new_random, {})
      self.last_mod = new_random
    end
  end
end

function modifier_chaos_oaa:DeclareFunctions()
  return {
    MODIFIER_EVENT_ON_RESPAWN,
  }
end

if IsServer() then
  function modifier_chaos_oaa:OnRespawn(event)
    local parent = self:GetParent()

    if event.unit ~= parent then
      return
    end

    if not parent:IsRealHero() or parent:IsTempestDouble() then
      return
    end

    if self.last_mod then
      parent:RemoveModifierByName(self.last_mod)
    end

    local repeat_loop = true
    while repeat_loop do
      local random_mod = self.late_game_modifiers[RandomInt(1, #self.late_game_modifiers)]
      if HudTimer then
        if HudTimer:GetGameTime() <= 10*60 then
          random_mod = self.initial_modifiers[RandomInt(1, #self.initial_modifiers)]
        elseif HudTimer:GetGameTime() > 10*60 and HudTimer:GetGameTime() <= 24*60 then
          random_mod = self.mid_game_modifiers[RandomInt(1, #self.mid_game_modifiers)]
        end
      end
      if random_mod ~= self.last_mod and not parent:HasModifier(random_mod) then
        parent:AddNewModifier(parent, nil, random_mod, {})
        self.last_mod = random_mod
        repeat_loop = false
      end
    end
  end
end

function modifier_chaos_oaa:GetTexture()
  return "chaos_knight_chaos_strike"
end
