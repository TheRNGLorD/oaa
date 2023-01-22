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
    "modifier_angel_oaa",
    "modifier_any_damage_crit_oaa",
    "modifier_any_damage_lifesteal_oaa",
    "modifier_aoe_radius_increase_oaa",
    "modifier_blood_magic_oaa",
    "modifier_bonus_armor_negative_magic_resist_oaa",
    "modifier_brawler_oaa",
    "modifier_courier_kill_bonus_oaa",
    "modifier_echo_strike_oaa",
    "modifier_explosive_death_oaa",
    "modifier_ham_oaa",
    "modifier_magus_oaa",
    "modifier_no_cast_points_oaa",
    "modifier_pro_active_oaa",
    "modifier_range_increase_oaa",
    "modifier_rend_oaa",
    "modifier_roshan_power_oaa",
    "modifier_sorcerer_oaa",
    "modifier_titan_soul_oaa",
    "modifier_troll_switch_oaa",
  }

  self.mid_game_modifiers = {
    "modifier_all_healing_amplify_oaa",
    "modifier_angel_oaa",
    "modifier_any_damage_crit_oaa",
    "modifier_any_damage_lifesteal_oaa",
    "modifier_aoe_radius_increase_oaa",
    "modifier_blood_magic_oaa",
    "modifier_bonus_armor_negative_magic_resist_oaa",
    "modifier_brute_oaa",
    "modifier_cursed_attack_oaa",
    "modifier_debuff_duration_oaa",
    "modifier_echo_strike_oaa",
    "modifier_explosive_death_oaa",
    "modifier_ham_oaa",
    "modifier_hero_anti_stun_oaa",
    "modifier_hybrid_oaa",
    "modifier_magus_oaa",
    "modifier_mr_phys_weak_oaa",
    "modifier_no_brain_oaa",
    "modifier_no_cast_points_oaa",
    "modifier_pro_active_oaa",
    "modifier_range_increase_oaa",
    "modifier_rend_oaa",
    "modifier_sorcerer_oaa",
    "modifier_spell_block_oaa",
    "modifier_titan_soul_oaa",
    "modifier_troll_switch_oaa",
    "modifier_true_sight_strike_oaa",
    "modifier_wisdom_oaa",
  }

  self.late_game_modifiers = {
    "modifier_all_healing_amplify_oaa",
    "modifier_angel_oaa",
    "modifier_any_damage_crit_oaa",
    "modifier_aoe_radius_increase_oaa",
    "modifier_blood_magic_oaa",
    "modifier_bonus_armor_negative_magic_resist_oaa",
    "modifier_brute_oaa",
    "modifier_debuff_duration_oaa",
    "modifier_echo_strike_oaa",
    "modifier_explosive_death_oaa",
    "modifier_ham_oaa",
    "modifier_hero_anti_stun_oaa",
    "modifier_hybrid_oaa",
    "modifier_magus_oaa",
    "modifier_mr_phys_weak_oaa",
    "modifier_nimble_oaa",
    "modifier_no_cast_points_oaa",
    "modifier_pro_active_oaa",
    "modifier_range_increase_oaa",
    "modifier_rend_oaa",
    "modifier_sorcerer_oaa",
    "modifier_spell_block_oaa",
    "modifier_troll_switch_oaa",
    "modifier_true_sight_strike_oaa",
    "modifier_wisdom_oaa",
  }

  local healer_heroes = {
    "npc_dota_hero_abaddon",
    "npc_dota_hero_chen",
    "npc_dota_hero_dawnbreaker",
    "npc_dota_hero_dazzle",
    "npc_dota_hero_death_prophet",
    "npc_dota_hero_enchantress",
    "npc_dota_hero_faceless_void",
    "npc_dota_hero_keeper_of_the_light",
    "npc_dota_hero_necrolyte",
    "npc_dota_hero_omniknight",
    "npc_dota_hero_oracle",
    "npc_dota_hero_phoenix",
    "npc_dota_hero_pugna",
    "npc_dota_hero_shadow_demon",
    "npc_dota_hero_treant",
    "npc_dota_hero_undying",
    "npc_dota_hero_warlock",
    "npc_dota_hero_winter_wyvern",
    "npc_dota_hero_wisp",
    "npc_dota_hero_witch_doctor",
  }

  for _, v in pairs(healer_heroes) do
    if parent:GetUnitName() == v then
      table.insert(self.mid_game_modifiers, "modifier_healer_oaa")
      table.insert(self.late_game_modifiers, "modifier_healer_oaa")
    end
  end

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
    local mid_game_time_start = FIRST_DUEL_TIMEOUT + DUEL_INTERVAL
    while repeat_loop do
      local random_mod = self.late_game_modifiers[RandomInt(1, #self.late_game_modifiers)]
      if HudTimer then
        if HudTimer:GetGameTime() <= mid_game_time_start then
          random_mod = self.initial_modifiers[RandomInt(1, #self.initial_modifiers)]
        elseif HudTimer:GetGameTime() > mid_game_time_start and HudTimer:GetGameTime() <= 20*60 then
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
