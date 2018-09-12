-- Library for OAA custom and original dota buildings

-- Modifiers mostly used for buildings
LinkLuaModifier("modifier_building_construction", "modifiers/modifier_building_construction.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_building_hide_on_minimap", "modifiers/modifier_building_hide_on_minimap.lua", LUA_MODIFIER_MOTION_NONE)

-- Returns bool; Is this unit OAA custom building?
function CDOTA_BaseNPC:IsCustomBuilding()
	if self:IsConsideredHero() then
		local name = self:GetUnitName()
		if string.find(name, "tower_") or string.find(name, "wall_segment") then
			return true
		end
	end
	
	return false
end

-- Returns a table; Finds OAA custom buildings within a radius.
function FindCustomBuildingsInRadius(position, radius)
	local candidates = Entities:FindAllByClassnameWithin("npc_dota_creature", position, radius)
	
	local custom_buildings = {}
	
	for _,creature in pairs(candidates) do
		if creature:IsCustomBuilding() then
			table.insert(custom_buildings, creature)
		end
	end
	
	return custom_buildings
end

-- Returns a table; Finds DOTA buildings in a given radius.
function FindAllBuildingsInRadius(position, radius)
	return FindUnitsInRadius(DOTA_TEAM_NEUTRALS, position, nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
end

-- void; Check and fix units that have been assigned a position inside a building (custom or not)
function PreventGettingStuck(position, building)
	if building:IsBuilding() or building.GetInvulnCount then
		ResolveNPCPositions(position, building:GetHullRadius())
	elseif building:IsCustomBuilding() then
		local radius = building:GetHullRadius()
		local target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC)
		local target_flags = bit.bor(DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, DOTA_UNIT_TARGET_FLAG_INVULNERABLE)
		local units = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, position, nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, target_type, target_flags, FIND_ANY_ORDER, false)
		for _,unit in pairs(units) do
			if not unit:IsCustomBuilding() then
				unit:AddNewModifier(unit, nil, "modifier_phased", {duration=0.03}) -- unit will insta unstuck after this built-in modifier expires.
			end
		end
	else
		--building is not a custom or original dota building
		print("PreventGettingStuck function has invalid second argument.")
	end
end
