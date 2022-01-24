magma_boss_projectile = class(AbilityBaseClass)

function magma_boss_projectile:Precache(context)
  PrecacheResource("particle", "particles/creatures/magma_golem/magma_golem_projectile.vpcf", context)
  PrecacheResource("particle", "particles/darkmoon_creep_warning.vpcf", context)
  PrecacheResource("soundfile", "soundevents/bosses/game_sounds_dungeon_enemies.vsndevts", context)
end

function magma_boss_projectile:OnAbilityPhaseStart()
  if IsServer() then
    local caster = self:GetCaster()
    -- Warning Particle
    self.nPreviewFX = ParticleManager:CreateParticle( "particles/darkmoon_creep_warning.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControlEnt( self.nPreviewFX, 0, caster, PATTACH_ABSORIGIN_FOLLOW, nil, caster:GetOrigin(), true )
    ParticleManager:SetParticleControl( self.nPreviewFX, 1, Vector( 150, 150, 150 ) )
    ParticleManager:SetParticleControl( self.nPreviewFX, 15, Vector( 188, 26, 26 ) )
  end

  return true
end

function magma_boss_projectile:OnAbilityPhaseInterrupted()
	if IsServer() then
    if self.nPreviewFX then
      ParticleManager:DestroyParticle(self.nPreviewFX, false)
      ParticleManager:ReleaseParticleIndex(self.nPreviewFX)
      self.nPreviewFX = nil
    end
  end
end

function magma_boss_projectile:OnSpellStart()
	local caster = self:GetCaster()
  if self.nPreviewFX then
    ParticleManager:DestroyParticle(self.nPreviewFX, true)
    ParticleManager:ReleaseParticleIndex(self.nPreviewFX)
    self.nPreviewFX = nil
  end

  local attack_speed = self:GetSpecialValueFor( "attack_speed" )
  local attack_width_initial = self:GetSpecialValueFor( "attack_width_initial" )
  local attack_width_end = self:GetSpecialValueFor( "attack_width_end" )
  local attack_distance = self:GetSpecialValueFor( "attack_distance" )
  --local damage = self:GetSpecialValueFor( "damage_impact" )

  local vPos
  if self:GetCursorTarget() then
    vPos = self:GetCursorTarget():GetOrigin()
  else
    vPos = self:GetCursorPosition()
  end

  local vDirection = vPos - caster:GetOrigin()
  vDirection.z = 0.0
  vDirection = vDirection:Normalized()

  attack_speed = attack_speed * ( attack_distance / ( attack_distance - attack_width_initial ) )

  local info = {
    EffectName = "particles/creatures/magma_golem/magma_golem_projectile.vpcf",
    Ability = self,
    vSpawnOrigin = caster:GetOrigin(),
    fStartRadius = attack_width_initial,
    fEndRadius = attack_width_end,
    vVelocity = vDirection * attack_speed,
    fDistance = attack_distance,
    Source = caster,
    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
  }

  ProjectileManager:CreateLinearProjectile( info )
  caster:EmitSound( "MagmaGolem.Projectile")
end

function magma_boss_projectile:OnProjectileHit( hTarget, vLocation )
  if hTarget and not hTarget:IsMagicImmune() and not hTarget:IsInvulnerable() then
    -- Reduce number of sounds
    if hTarget:IsRealHero() then
      hTarget:EmitSound("MagmaGolem.Projectile.Impact")
    end

    local damageTable = {
      victim = hTarget,
      attacker = self:GetCaster(),
      damage = self:GetSpecialValueFor( "damage_impact" ),
      damage_type = self:GetAbilityDamageType(),
      ability = self
    }

    ApplyDamage( damageTable )
  end

  return false
end

