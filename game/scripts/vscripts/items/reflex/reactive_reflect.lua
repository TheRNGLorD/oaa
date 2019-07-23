LinkLuaModifier( "modifier_item_reactive_reflect", "items/reflex/reactive_reflect.lua", LUA_MODIFIER_MOTION_NONE )
--LinkLuaModifier( "modifier_charge_replenisher", "modifiers/modifier_charge_replenisher.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_bonus", "modifiers/modifier_generic_bonus.lua", LUA_MODIFIER_MOTION_NONE)
--LinkLuaModifier( "modifier_intrinsic_multiplexer", "modifiers/modifier_intrinsic_multiplexer.lua", LUA_MODIFIER_MOTION_NONE)

item_reflection_shard_1 = class(ItemBaseClass)
item_reflection_shard_2 = item_reflection_shard_1
item_reflection_shard_3 = item_reflection_shard_1

function item_reflection_shard_1:GetIntrinsicModifierName()
  return "modifier_generic_bonus" -- "modifier_charge_replenisher"
end

function item_reflection_shard_1:OnSpellStart()
  --[[
  local charges = self:GetCurrentCharges()
  if charges <= 0 then
    return false
  end
  ]]

  local caster = self:GetCaster()
  local duration = self:GetSpecialValueFor( "duration" )

  --[[
  self:SetCurrentCharges( charges - 1 )
  if charges == 1 then
    self:StartCooldown(self:GetCooldownTime())
  end
  ]]

  caster:AddNewModifier( caster, self, "modifier_item_reactive_reflect", { duration = duration } )
end

modifier_item_reactive_reflect = class(ModifierBaseClass)

function modifier_item_reactive_reflect:IsHidden()
  return false
end

function modifier_item_reactive_reflect:IsDebuff()
  return false
end

function modifier_item_reactive_reflect:IsPurgable()
  return false
end

function modifier_item_reactive_reflect:OnCreated( event )
  if IsServer() and self.nPreviewFX == nil then
    local parent = self:GetParent()
    parent:EmitSound( "Item.LotusOrb.Target" ) -- Hero_Antimage.Counterspell.Cast
    self.nPreviewFX = ParticleManager:CreateParticle("particles/items/reflection_shard/reflection_shield.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
    --self.reflect_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_antimage/antimage_spellshield_reflect.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, parent)

    if parent.stored_reflected_spells == nil then
      parent.stored_reflected_spells = {}
    end
  end
end

function modifier_item_reactive_reflect:OnDestroy()
  if IsServer() then
    local parent = self:GetParent()
    parent:EmitSound("Item.LotusOrb.Destroy")
    if self.nPreviewFX then
      ParticleManager:DestroyParticle(self.nPreviewFX, false)
      ParticleManager:ReleaseParticleIndex(self.nPreviewFX)
      self.nPreviewFX = nil
    end
    for i=1, #parent.stored_reflected_spells do
      local ability = parent.stored_reflected_spells[i]
      -- If this ability is not having active modifiers and its not channgeling it can be removed
      if ability:NumModifiersUsingAbility() == 0 and not ability:IsChanneling() then
        ability:RemoveSelf()
        table.remove(parent.stored_reflected_spells,i)
      end
    end
  end
end

function modifier_item_reactive_reflect:DeclareFunctions()
  return {
    --MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
    --MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
    --MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    MODIFIER_PROPERTY_ABSORB_SPELL,
    MODIFIER_PROPERTY_REFLECT_SPELL,
  }
end
--[[
function modifier_item_reactive_reflect:GetAbsoluteNoDamagePhysical()
  return 1
end

function modifier_item_reactive_reflect:GetAbsoluteNoDamageMagical()
  return 1
end

function modifier_item_reactive_reflect:GetAbsoluteNoDamagePure()
  return 1
end
]]
function modifier_item_reactive_reflect:GetAbsorbSpell()
  return 1
end

function modifier_item_reactive_reflect:GetReflectSpell(kv)
  if IsServer() then
    local parent = self:GetParent()
    parent:EmitSound( "Item.LotusOrb.Activate" ) --Hero_Antimage.Counterspell.Target

    local burst = ParticleManager:CreateParticle( "particles/items/reflection_shard/immunity_sphere_yellow.vpcf", PATTACH_ABSORIGIN, parent)
    Timers:CreateTimer(1.5, function()
      ParticleManager:DestroyParticle( burst, false )
      ParticleManager:ReleaseParticleIndex(burst)
    end)

    local ability_name = kv.ability:GetAbilityName()
    local target = kv.ability:GetCaster()
    local ability_level = kv.ability:GetLevel()

    local exception_list = {
      ["rubick_spell_steal"] = true,
      ["legion_commander_duel"] = true,
    }

    -- Do not reflect allied spells for any reason
    if target:GetTeamNumber() == parent:GetTeamNumber() then
      return nil
    end

    -- If this is a reflected ability from other Reflection shard, do nothing (reflecting reflected spells should not be possible)
    if kv.ability.reflected_spell then
      return nil
    end

    -- If target has reflecting modifiers (lotus orb or reflection shard) do nothing to prevent looping (reflecting reflected spells should not be possible)
    if target:HasModifier("modifier_item_lotus_orb_active") or target:HasModifier("modifier_item_reactive_reflect") then
      return nil
    end

    -- If ability is on the exception list do nothing
    if exception_list[ability_name] then
      return nil
    end

    -- Check if the parent already has reflected ability
    local old = false
    for _,ability in pairs(parent.stored_reflected_spells) do
      if ability ~= nil and ability:GetAbilityName() == ability_name then
        old = true
        break
      end
    end

    local reflect_ability
    local parent_ability
    if old then
      reflect_ability = parent:FindAbilityByName(ability_name)
    else
      parent_ability = parent:FindAbilityByName(ability_name)
      if parent_ability then
        -- This is a rare case (Rubick stole the spell and then casted that same spell on the target he stole it from and target has reflection shard buff)
        -- when parent already has the kv.ability naturally, it wasn't added or stolen, then it should not be stolen or hidden because that would mess up things
        -- We shouldn't duplicate abilities if the parent already has the kv.ability
        parent:SetCursorCastTarget(target) -- Set the target for the spell.
        parent_ability:OnSpellStart() -- Cast the spell back (to Rubick).
        return -- Don't do other stuff
      end
      reflect_ability = parent:AddAbility(ability_name) -- Add the spell to the parent for the first time
      if reflect_ability then
        reflect_ability:SetStolen(true) -- Just to be safe with some interactions.
        reflect_ability:SetHidden(true) -- Hide the ability on the parent.
        reflect_ability.reflected_spell = true  -- Tag this ability as reflected
        table.insert(parent.stored_reflected_spells, reflect_ability) -- Store the spell reference for future use.
      end
    end

    if reflect_ability == nil then return end -- If reflect_ability becomes nil for some reason, don't do other stuff
    reflect_ability:SetLevel(ability_level) -- Set level to be the same as the level of the original ability
    parent:SetCursorCastTarget(target) -- Set the target for the spell.
    reflect_ability:OnSpellStart() -- Cast the spell.

  end
end
