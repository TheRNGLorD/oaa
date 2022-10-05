LinkLuaModifier("modifier_anti_stun_oaa", "modifiers/modifier_anti_stun_oaa.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ogre_tank_melee_smash_thinker", "abilities/boss/ogre_tank_boss/modifier_ogre_tank_melee_smash_thinker.lua", LUA_MODIFIER_MOTION_NONE)

ogre_tank_boss_melee_smash_tier5 = class(AbilityBaseClass)

function ogre_tank_boss_melee_smash_tier5:ProcsMagicStick()
	return false
end

function ogre_tank_boss_melee_smash_tier5:GetCooldown( iLevel )
  -- the cooldown should be lower than the default value if hasted by ogre seer
	return self.BaseClass.GetCooldown( self, self:GetLevel() ) / math.max( self:GetCaster():GetHasteFactor(), 1.0 )
end

function ogre_tank_boss_melee_smash_tier5:GetPlaybackRateOverride()
	return math.min( 2.0, math.max( self:GetCaster():GetHasteFactor(), 1.0 ) )
end

function ogre_tank_boss_melee_smash_tier5:OnAbilityPhaseStart()
  if IsServer() then
    local caster = self:GetCaster()
    local delay = self:GetCastPoint()

    caster:AddNewModifier(caster, self, "modifier_anti_stun_oaa", {duration = delay})
  end
  return true
end

function ogre_tank_boss_melee_smash_tier5:OnSpellStart()
  local caster = self:GetCaster()
  caster:EmitSound("OgreTank.Grunt")
  local flSpeed = self:GetSpecialValueFor( "base_swing_speed" ) / self:GetPlaybackRateOverride()
  local vToTarget = self:GetCursorPosition() - caster:GetOrigin()
  vToTarget = vToTarget:Normalized()
  local vTarget = caster:GetOrigin() + vToTarget * self:GetCastRange( caster:GetOrigin(), nil )
  CreateModifierThinker( caster, self, "modifier_ogre_tank_melee_smash_thinker", { duration = flSpeed }, vTarget, caster:GetTeamNumber(), false )
end
