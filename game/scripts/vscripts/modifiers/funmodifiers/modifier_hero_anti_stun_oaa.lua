modifier_hero_anti_stun_oaa = class(ModifierBaseClass)

function modifier_hero_anti_stun_oaa:IsHidden()
  return true
end

function modifier_hero_anti_stun_oaa:IsDebuff()
  return false
end

function modifier_hero_anti_stun_oaa:IsPurgable()
  return false
end

function modifier_hero_anti_stun_oaa:RemoveOnDeath()
  return false
end

function modifier_hero_anti_stun_oaa:DeclareFunctions()
  return {
    MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
  }
end

function modifier_hero_anti_stun_oaa:GetModifierTotalDamageOutgoing_Percentage(event)
  return -50
end

function modifier_hero_anti_stun_oaa:GetPriority()
  return MODIFIER_PRIORITY_SUPER_ULTRA + 10000
end

function modifier_hero_anti_stun_oaa:CheckState()
  return {
    [MODIFIER_STATE_HEXED] = false,
    [MODIFIER_STATE_ROOTED] = false,
    [MODIFIER_STATE_SILENCED] = false,
    [MODIFIER_STATE_STUNNED] = false,
    [MODIFIER_STATE_FROZEN] = false,
    [MODIFIER_STATE_FEARED] = false,
    [MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
  }
end

function modifier_hero_anti_stun_oaa:GetEffectName()
  return "particles/units/heroes/hero_spirit_breaker/spirit_breaker_haste_owner.vpcf"
end

function modifier_hero_anti_stun_oaa:GetEffectAttachType()
  return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_hero_anti_stun_oaa:GetTexture()
  return "templar_assassin_refraction"
end
