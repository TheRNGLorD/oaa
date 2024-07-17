dire_tower_boss_creeps_stolen_valor = class(AbilityBaseClass)

LinkLuaModifier("modifier_dire_tower_boss_creeps_stolen_valor", "abilities/boss/dire_tower_boss/stolen_valor.lua", LUA_MODIFIER_MOTION_NONE)

function dire_tower_boss_creeps_stolen_valor:GetIntrinsicModifierName()
  return "modifier_dire_tower_boss_creeps_stolen_valor"
end

function dire_tower_boss_creeps_stolen_valor:IsStealable()
  return false
end

function dire_tower_boss_creeps_stolen_valor:ProcMagicStick()
  return false
end

---------------------------------------------------------------------------------------------------

modifier_dire_tower_boss_creeps_stolen_valor = class(ModifierBaseClass)

function modifier_dire_tower_boss_creeps_stolen_valor:IsHidden()
  return true
end

function modifier_dire_tower_boss_creeps_stolen_valor:IsDebuff()
  return false
end

function modifier_dire_tower_boss_creeps_stolen_valor:IsPurgable()
  return false
end

function modifier_dire_tower_boss_creeps_stolen_valor:DeclareFunctions()
  return {
    MODIFIER_EVENT_ON_DEATH,
  }
end

if IsServer() then
  function modifier_dire_tower_boss_creeps_stolen_valor:OnDeath(event)
    local parent = self:GetParent() -- Get the unit that has this modifier attached

    if event.unit ~= parent then return end

    local ability = self:GetAbility()
    local summon_duration = ability:GetSpecialValueFor("summon_duration")

    local attacker = event.attacker
    local vSpawnPoint = parent:GetAbsOrigin()
    local tower = parent:GetOwner() -- it seems this does not work

    -- Sound
    attacker:EmitSound("Roshan.Bash")

    local unitName = parent:GetUnitName()
    local newUnitName = nil
    if string.find(unitName, "npc_dota_creature_melee") then
      newUnitName = "npc_dota_creature_melee_stolen_creep"
    elseif string.find(unitName, "npc_dota_creature_ranged") then
      newUnitName = "npc_dota_creature_ranged_stolen_creep"
    elseif string.find(unitName, "npc_dota_creature_siege") then
      newUnitName = "npc_dota_creature_siege_stolen_creep"
    else
      print("Unknown unit type.")
    end

    if newUnitName then
      local summon = CreateUnitByName( newUnitName, vSpawnPoint, true, attacker, attacker, attacker:GetTeamNumber())
      if summon then
        summon:AddNewModifier(attacker, ability, "modifier_kill", {duration = summon_duration})
        summon:AddNewModifier(attacker, ability, "modifier_generic_dead_tracker_oaa", {duration = summon_duration + MANUAL_GARBAGE_CLEANING_TIME})
        summon:AddNewModifier(attacker, ability, "modifier_phased", {duration = FrameTime()})
        summon:SetInitialGoalEntity(attacker:GetInitialGoalEntity())
        if tower then
          if tower.IsOAABoss and tower:IsOAABoss() then
            summon.tower = tower -- it seems this does not work
          end
        end
      end
    end
  end
end
