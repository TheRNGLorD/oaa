modifier_diarrhetic_oaa = class(ModifierBaseClass)

function modifier_diarrhetic_oaa:IsHidden()
  return false
end

function modifier_diarrhetic_oaa:IsDebuff()
  return true
end

function modifier_diarrhetic_oaa:IsPurgable()
  return false
end

function modifier_diarrhetic_oaa:RemoveOnDeath()
  return false
end

function modifier_diarrhetic_oaa:OnCreated()
  local interval = 30
  self.check_for_ward_radius = 300
  self.duration = 2 * interval -- POOP_WARD_DURATION

  if IsServer() then
    self:StartIntervalThink(interval)
  end
end

if IsServer() then
  function modifier_diarrhetic_oaa:OnIntervalThink()
    local parent = self:GetParent()
    local position = parent:GetAbsOrigin()
    local team = parent:GetTeamNumber()
    local no_wards_nearby = true

    local wards = FindUnitsInRadius(
      team,
      position,
      nil,
      self.check_for_ward_radius,
      DOTA_UNIT_TARGET_TEAM_FRIENDLY,
      DOTA_UNIT_TARGET_OTHER,
      DOTA_UNIT_TARGET_FLAG_NONE,
      FIND_ANY_ORDER,
      false
    )

    for _, v in pairs(wards) do
      if v and not v:IsNull() and (v:HasModifier("modifier_item_buff_ward") or v:HasModifier("modifier_ward_invisibility")) then
        no_wards_nearby = false
        break
      end
    end

    if no_wards_nearby then
      local ward = CreateUnitByName("npc_dota_observer_wards", position, true, nil, parent, team)
      ward:AddNewModifier(ward, nil, "modifier_kill", {duration = self.duration})
      ward:AddNewModifier(ward, nil, "modifier_ward_invisibility", {})
    end
  end
end

function modifier_diarrhetic_oaa:GetTexture()
  return "item_ward_observer"
end
