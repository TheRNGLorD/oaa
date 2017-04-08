std = {
  globals = { -- these globals can be set and accessed.
  },
  read_globals = { -- these globals can only be accessed.
    ---- Other
    "require",
    "class",
    -- -- Global
    "AddFOWViewer",
    "AngleDiff",
    "AppendToLogFile",
    "ApplyDamage",
    "AxisAngleToQuaternion",
    "CalcClosestPointOnEntityOBB",
    "CalcDistanceBetweenEntityOBB",
    "CalcDistanceToLineSegment2D",
    "CancelEntityIOEvents",
    "ClearTeamCustomHealthbarColor",
    "CreateEffect",
    "CreateHeroForPlayer",
    "CreateHTTPRequestScriptVM",
    "CreateItem",
    "CreateItemOnPositionForLaunch",
    "CreateItemOnPositionSync",
    "CreateModifierThinker",
    "CreateTempTree",
    "CreateTrigger",
    "CreateTriggerRadiusApproximate",
    "CreateUnitByName",
    "CreateUnitByNameAsync",
    "CreateUnitFromTable",
    "cvar_getf",
    "cvar_setf",
    "DebugBreak",
    "DebugDrawBox",
    "DebugDrawBoxDirection",
    "DebugDrawCircle",
    "DebugDrawClear",
    "DebugDrawLine",
    "DebugDrawLine_vCol",
    "DebugDrawScreenTextLine",
    "DebugDrawSphere",
    "DebugDrawText",
    "DebugScreenTextPretty",
    "DoCleaveAttack",
    "DoEntFire",
    "DoEntFireByInstanceHandle",
    "DoIncludeScript",
    "DoScriptAssert",
    "DoUniqueString",
    "EmitAnnouncerSound",
    "EmitAnnouncerSoundForPlayer",
    "EmitAnnouncerSoundForTeam",
    "EmitAnnouncerSoundForTeamOnLocation",
    "EmitGlobalSound",
    "EmitSoundOn",
    "EmitSoundOnClient",
    "EmitSoundOnLocationForAllies",
    "EmitSoundOnLocationWithCaster",
    "EntIndexToHScript",
    "ExecuteOrderFromTable",
    "ExponentialDecay",
    "FileToString",
    "FindClearSpaceForUnit",
    "FindUnitsInRadius",
    "FindUnitsInLine",
    "FireEntityIOInputNameOnly",
    "FireEntityIOInputString",
    "FireEntityIOInputVec",
    "FireGameEvent",
    "FireGameEventLocal",
    "FrameTime",
    "GetEntityIndexForTreeId",
    "GetFrameCount",
    "GetFrostyBoostAmount",
    "GetFrostyPointsForRound",
    "GetGoldFrostyBoostAmount",
    "GetGoldFrostyPointsForRound",
    "GetGroundHeight",
    "GetGroundPosition",
    "GetItemCost",
    "GetListenServerHost",
    "GetMapName",
    "GetMaxOutputDelay",
    "GetPhysAngularVelocity",
    "GetPhysVelocity",
    "GetSystemDate",
    "GetSystemTime",
    "GetTeamHeroKills",
    "GetTeamName",
    "GetTreeIdForEntityIndex",
    "GetWorldMaxX",
    "GetWorldMaxY",
    "GetWorldMinX",
    "GetWorldMinY",
    "InitLogFile",
    "IsClient",
    "IsDedicatedServer",
    "IsMarkedForDeletion",
    "IsServer",
    "IsValidEntity",
    "IsInToolsMode",
    "LimitPathingSearchDepth",
    "LinkLuaModifier",
    "ListenToGameEvent",
    "LoadKeyValues",
    "LoadKeyValuesFromString",
    "MakeStringToken",
    "MinimapEvent",
    "Msg",
    "PauseGame",
    "PlayerInstanceFromIndex",
    "PrecacheEntityFromTable",
    "PrecacheEntityListFromTable",
    "PrecacheItemByNameAsync",
    "PrecacheItemByNameSync",
    "PrecacheModel",
    "PrecacheResource",
    "PrecacheUnitByNameAsync",
    "PrecacheUnitByNameSync",
    "PrintLinkedConsoleMessage",
    "RandomFloat",
    "RandomInt",
    "RandomVector",
    "RegisterSpawnGroupFilterProxy",
    "ReloadMOTD",
    "RemoveSpawnGroupFilterProxy",
    "ResolveNPCPositions",
    "RollPercentage",
    "RotateOrientation",
    "RotatePosition",
    "RotateQuaternionByAxisAngle",
    "RotationDelta",
    "RotationDeltaAsAngularVelocity",
    "rr_AddDecisionRule",
    "rr_CommitAIResponse",
    "rr_GetResponseTargets",
    "rr_QueryBestResponse",
    "Say",
    "ScreenShake",
    "SendFrostivusTimeElapsedToGC",
    "SendFrostyPointsMessageToGC",
    "SendOverheadEventMessage",
    "SendToConsole",
    "SendToServerConsole",
    "SetOpvarFloatAll",
    "SetOpvarFloatPlayer",
    "SetPhysAngularVelocity",
    "SetQuestName",
    "SetQuestPhase",
    "SetRenderingEnabled",
    "SetTeamCustomHealthbarColor",
    "ShowCustomHeaderMessage",
    "ShowGenericPopup",
    "ShowGenericPopupToPlayer",
    "ShowMessage",
    "SpawnEntityFromTableSynchronous",
    "SpawnEntityGroupFromTable",
    "SpawnEntityListFromTableAsynchronous",
    "SpawnEntityListFromTableSynchronous",
    "SplineQuaternions",
    "SplineVectors",
    "StartSoundEvent",
    "StartSoundEventFromPosition",
    "StartSoundEventFromPositionReliable",
    "StartSoundEventFromPositionUnreliable",
    "StartSoundEventReliable",
    "StartSoundEventUnreliable",
    "StopEffect",
    "StopListeningToAllGameEvents",
    "StopListeningToGameEvent",
    "StopSoundEvent",
    "StopSoundOn",
    "StringToFile",
    "Time",
    "TraceCollideable",
    "TraceHull",
    "TraceLine",
    "UnitFilter",
    "UnloadSpawnGroup",
    "UnloadSpawnGroupByHandle",
    "UpdateEventPoints",
    "UTIL_MessageText",
    "UTIL_MessageText_WithContext",
    "UTIL_MessageTextAll",
    "UTIL_MessageTextAll_WithContext",
    "UTIL_Remove",
    "UTIL_RemoveImmediate",
    "UTIL_ResetMessageText",
    "UTIL_ResetMessageTextAll",
    "VectorToAngles",
    "Warning",
    "CDOTA_PlayerResource",
    ---- Constants
    -- AbilityLearnResult_t
    "ABILITY_CAN_BE_UPGRADED",
    "ABILITY_CANNOT_BE_UPGRADED_NOT_UPGRADABLE",
    "ABILITY_CANNOT_BE_UPGRADED_AT_MAX",
    "ABILITY_CANNOT_BE_UPGRADED_REQUIRES_LEVEL",
    "ABILITY_NOT_LEARNABLE",
    -- Attributes
    "DOTA_ATTRIBUTE_INVALID",
    "DOTA_ATTRIBUTE_STRENGTH",
    "DOTA_ATTRIBUTE_AGILITY",
    "DOTA_ATTRIBUTE_INTELLECT",
    "DOTA_ATTRIBUTE_MAX",
    -- DAMAGE_TYPES
    "DAMAGE_TYPE_NONE",
    "DAMAGE_TYPE_PHYSICAL",
    "DAMAGE_TYPE_MAGICAL",
    "DAMAGE_TYPE_PURE",
    "DAMAGE_TYPE_ALL",
    "DAMAGE_TYPE_HP_REMOVAL",
    -- DOTAAbilitySpeakTrigger_t
    "DOTA_ABILITY_SPEAK_START_ACTION_PHASE",
    "DOTA_ABILITY_SPEAK_CAST",
    -- DOTADamageFlag_t
    "DOTA_DAMAGE_FLAG_NONE",
    "DOTA_DAMAGE_FLAG_IGNORES_MAGIC_ARMOR",
    "DOTA_DAMAGE_FLAG_IGNORES_PHYSICAL_ARMOR",
    "DOTA_DAMAGE_FLAG_BYPASSES_INVULNERABILITY",
    "DOTA_DAMAGE_FLAG_BYPASSES_BLOCK",
    "DOTA_DAMAGE_FLAG_REFLECTION",
    "DOTA_DAMAGE_FLAG_HPLOSS",
    "DOTA_DAMAGE_FLAG_NO_DIRECTOR_EVENT",
    "DOTA_DAMAGE_FLAG_NON_LETHAL",
    "DOTA_DAMAGE_FLAG_USE_COMBAT_PROFICIENCY",
    "DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS",
    -- DOTAHUDVisibility_t
    "DOTA_HUD_VISIBILITY_TOP_TIMEOFDAY",
    "DOTA_HUD_VISIBILITY_TOP_HEROES",
    "DOTA_HUD_VISIBILITY_TOP_SCOREBOARD",
    "DOTA_HUD_VISIBILITY_ACTION_PANEL",
    "DOTA_HUD_VISIBILITY_ACTION_MINIMAP",
    "DOTA_HUD_VISIBILITY_INVENTORY_PANEL",
    "DOTA_HUD_VISIBILITY_INVENTORY_SHOP",
    "DOTA_HUD_VISIBILITY_INVENTORY_ITEMS",
    "DOTA_HUD_VISIBILITY_INVENTORY_QUICKBUY",
    "DOTA_HUD_VISIBILITY_INVENTORY_COURIER",
    "DOTA_HUD_VISIBILITY_INVENTORY_PROTECT",
    "DOTA_HUD_VISIBILITY_INVENTORY_GOLD",
    "DOTA_HUD_VISIBILITY_SHOP_SUGGESTEDITEMS",
    "DOTA_HUD_VISIBILITY_COUNT",
    -- DOTAInventoryFlags_t
    "DOTA_INVENTORY_ALLOW_NONE",
    "DOTA_INVENTORY_ALLOW_MAIN",
    "DOTA_INVENTORY_ALLOW_STASH",
    "DOTA_INVENTORY_ALL_ACCESS",
    "DOTA_INVENTORY_ALLOW_DROP_ON_GROUND",
    "DOTA_INVENTORY_ALLOW_DROP_AT_FOUNTAIN",
    "DOTA_INVENTORY_LIMIT_DROP_ON_GROUND",
    -- DOTAMinimapEvent_t
    "DOTA_MINIMAP_EVENT_ANCIENT_UNDER_ATTACK",
    "DOTA_MINIMAP_EVENT_BASE_UNDER_ATTACK",
    "DOTA_MINIMAP_EVENT_BASE_GLYPHED",
    "DOTA_MINIMAP_EVENT_TEAMMATE_UNDER_ATTACK",
    "DOTA_MINIMAP_EVENT_TEAMMATE_TELEPORTING",
    "DOTA_MINIMAP_EVENT_TEAMMATE_DIED",
    "DOTA_MINIMAP_EVENT_TUTORIAL_TASK_ACTIVE",
    "DOTA_MINIMAP_EVENT_TUTORIAL_TASK_FINISHED",
    "DOTA_MINIMAP_EVENT_HINT_LOCATION",
    "DOTA_MINIMAP_EVENT_ENEMY_TELEPORTING",
    "DOTA_MINIMAP_EVENT_CANCEL_TELEPORTING",
    -- DOTAModifierAttribute_t
    "MODIFIER_ATTRIBUTE_NONE",
    "MODIFIER_ATTRIBUTE_PERMANENT",
    "MODIFIER_ATTRIBUTE_MULTIPLE",
    "MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE",
    -- DOTAMusicStatus_t
    "DOTA_MUSIC_STATUS_NONE",
    "DOTA_MUSIC_STATUS_EXPLORATION",
    "DOTA_MUSIC_STATUS_BATTLE",
    "DOTA_MUSIC_STATUS_PRE_GAME_EXPLORATION",
    "DOTA_MUSIC_STATUS_DEAD",
    "DOTA_MUSIC_STATUS_LAST",
    -- DOTASlotType_t
    "DOTA_LOADOUT_TYPE_INVALID",
    "DOTA_LOADOUT_TYPE_WEAPON",
    "DOTA_LOADOUT_TYPE_OFFHAND_WEAPON",
    "DOTA_LOADOUT_TYPE_WEAPON2",
    "DOTA_LOADOUT_TYPE_OFFHAND_WEAPON2",
    "DOTA_LOADOUT_TYPE_HEAD",
    "DOTA_LOADOUT_TYPE_SHOULDER",
    "DOTA_LOADOUT_TYPE_ARMS",
    "DOTA_LOADOUT_TYPE_ARMOR",
    "DOTA_LOADOUT_TYPE_BELT",
    "DOTA_LOADOUT_TYPE_NECK",
    "DOTA_LOADOUT_TYPE_BACK",
    "DOTA_LOADOUT_TYPE_LEGS",
    "DOTA_LOADOUT_TYPE_GLOVES",
    "DOTA_LOADOUT_TYPE_TAIL",
    "DOTA_LOADOUT_TYPE_MISC",
    "DOTA_LOADOUT_TYPE_BODY_HEAD",
    "DOTA_LOADOUT_TYPE_MOUNT",
    "DOTA_LOADOUT_TYPE_SUMMON",
    "DOTA_LOADOUT_TYPE_SHAPESHIFT",
    "DOTA_LOADOUT_TYPE_TAUNT",
    "DOTA_LOADOUT_TYPE_AMBIENT_EFFECTS",
    "DOTA_LOADOUT_TYPE_ABILITY_ATTACK",
    "DOTA_LOADOUT_TYPE_ABILITY1",
    "DOTA_LOADOUT_TYPE_ABILITY2",
    "DOTA_LOADOUT_TYPE_ABILITY3",
    "DOTA_LOADOUT_TYPE_ABILITY4",
    "DOTA_LOADOUT_TYPE_ABILITY_ULTIMATE",
    "DOTA_LOADOUT_TYPE_VOICE",
    "DOTA_LOADOUT_TYPE_ACTION_ITEM",
    "DOTA_PLAYER_LOADOUT_START",
    "DOTA_LOADOUT_TYPE_COURIER",
    "DOTA_LOADOUT_TYPE_ANNOUNCER",
    "DOTA_LOADOUT_TYPE_MEGA_KILLS",
    "DOTA_LOADOUT_TYPE_MUSIC",
    "DOTA_LOADOUT_TYPE_WARD",
    "DOTA_LOADOUT_TYPE_HUD_SKIN",
    "DOTA_LOADOUT_TYPE_LOADING_SCREEN",
    "DOTA_LOADOUT_TYPE_WEATHER",
    "DOTA_LOADOUT_TYPE_HEROIC_STATUE",
    "DOTA_LOADOUT_TYPE_MULTIKILL_BANNER",
    "DOTA_LOADOUT_TYPE_CURSOR_PACK",
    "DOTA_LOADOUT_TYPE_TELEPORT_EFFECT",
    "DOTA_LOADOUT_TYPE_BLINK_EFFECT",
    "DOTA_LOADOUT_TYPE_TEAM_SHOWCASE",
    "DOTA_PLAYER_LOADOUT_END",
    "DOTA_LOADOUT_TYPE_NONE",
    "DOTA_LOADOUT_TYPE_COUNT",
    -- DOTASpeechType_t
    "DOTA_SPEECH_USER_INVALID",
    "DOTA_SPEECH_USER_SINGLE",
    "DOTA_SPEECH_USER_TEAM",
    "DOTA_SPEECH_USER_TEAM_NEARBY",
    "DOTA_SPEECH_USER_NEARBY",
    "DOTA_SPEECH_USER_ALL",
    "DOTA_SPEECH_GOOD_TEAM",
    "DOTA_SPEECH_BAD_TEAM",
    "DOTA_SPEECH_SPECTATOR",
    "DOTA_SPEECH_RECIPIENT_TYPE_MAX",
    -- DOTATeam_t
    "DOTA_TEAM_FIRST",
    "DOTA_TEAM_GOODGUYS",
    "DOTA_TEAM_BADGUYS",
    "DOTA_TEAM_NEUTRALS",
    "DOTA_TEAM_NOTEAM",
    "DOTA_TEAM_CUSTOM_1",
    "DOTA_TEAM_CUSTOM_MIN",
    "DOTA_TEAM_CUSTOM_2",
    "DOTA_TEAM_CUSTOM_3",
    "DOTA_TEAM_CUSTOM_COUNT",
    "DOTA_TEAM_CUSTOM_4",
    "DOTA_TEAM_CUSTOM_5",
    "DOTA_TEAM_CUSTOM_6",
    "DOTA_TEAM_CUSTOM_7",
    "DOTA_TEAM_CUSTOM_8",
    "DOTA_TEAM_CUSTOM_MAX",
    "DOTA_TEAM_COUNT",
    -- DOTAUnitAttackCapability_t
    "DOTA_UNIT_CAP_NO_ATTACK",
    "DOTA_UNIT_CAP_MELEE_ATTACK",
    "DOTA_UNIT_CAP_RANGED_ATTACK",
    -- DOTAUnitMoveCapability_t
    "DOTA_UNIT_CAP_MOVE_NONE",
    "DOTA_UNIT_CAP_MOVE_GROUND",
    "DOTA_UNIT_CAP_MOVE_FLY",
    -- DOTA_UNIT_ORDERS
    "DOTA_UNIT_ORDER_NONE",
    "DOTA_UNIT_ORDER_MOVE_TO_POSITION",
    "DOTA_UNIT_ORDER_MOVE_TO_TARGET",
    "DOTA_UNIT_ORDER_ATTACK_MOVE",
    "DOTA_UNIT_ORDER_ATTACK_TARGET",
    "DOTA_UNIT_ORDER_CAST_POSITION",
    "DOTA_UNIT_ORDER_CAST_TARGET",
    "DOTA_UNIT_ORDER_CAST_TARGET_TREE",
    "DOTA_UNIT_ORDER_CAST_NO_TARGET",
    "DOTA_UNIT_ORDER_CAST_TOGGLE",
    "DOTA_UNIT_ORDER_HOLD_POSITION",
    "DOTA_UNIT_ORDER_TRAIN_ABILITY",
    "DOTA_UNIT_ORDER_DROP_ITEM",
    "DOTA_UNIT_ORDER_GIVE_ITEM",
    "DOTA_UNIT_ORDER_PICKUP_ITEM",
    "DOTA_UNIT_ORDER_PICKUP_RUNE",
    "DOTA_UNIT_ORDER_PURCHASE_ITEM",
    "DOTA_UNIT_ORDER_SELL_ITEM",
    "DOTA_UNIT_ORDER_DISASSEMBLE_ITEM",
    "DOTA_UNIT_ORDER_MOVE_ITEM",
    "DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO",
    "DOTA_UNIT_ORDER_STOP",
    "DOTA_UNIT_ORDER_TAUNT",
    "DOTA_UNIT_ORDER_BUYBACK",
    "DOTA_UNIT_ORDER_GLYPH",
    "DOTA_UNIT_ORDER_EJECT_ITEM_FROM_STASH",
    "DOTA_UNIT_ORDER_CAST_RUNE",
    -- DOTA_ABILITY_BEHAVIOR
    "DOTA_ABILITY_BEHAVIOR_NONE",
    "DOTA_ABILITY_BEHAVIOR_HIDDEN",
    "DOTA_ABILITY_BEHAVIOR_PASSIVE",
    "DOTA_ABILITY_BEHAVIOR_NO_TARGET",
    "DOTA_ABILITY_BEHAVIOR_UNIT_TARGET",
    "DOTA_ABILITY_BEHAVIOR_POINT",
    "DOTA_ABILITY_BEHAVIOR_AOE",
    "DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE",
    "DOTA_ABILITY_BEHAVIOR_CHANNELLED",
    "DOTA_ABILITY_BEHAVIOR_ITEM",
    "DOTA_ABILITY_BEHAVIOR_TOGGLE",
    "DOTA_ABILITY_BEHAVIOR_DIRECTIONAL",
    "DOTA_ABILITY_BEHAVIOR_IMMEDIATE",
    "DOTA_ABILITY_BEHAVIOR_AUTOCAST",
    "DOTA_ABILITY_BEHAVIOR_OPTIONAL_UNIT_TARGET",
    "DOTA_ABILITY_BEHAVIOR_OPTIONAL_POINT",
    "DOTA_ABILITY_BEHAVIOR_OPTIONAL_NO_TARGET",
    "DOTA_ABILITY_BEHAVIOR_AURA",
    "DOTA_ABILITY_BEHAVIOR_ATTACK",
    "DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT",
    "DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES",
    "DOTA_ABILITY_BEHAVIOR_UNRESTRICTED",
    "DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE",
    "DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL",
    "DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT",
    "DOTA_ABILITY_BEHAVIOR_DONT_ALERT_TARGET",
    "DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK",
    "DOTA_ABILITY_BEHAVIOR_NORMAL_WHEN_STOLEN",
    "DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING",
    "DOTA_ABILITY_BEHAVIOR_RUNE_TARGET",
    "DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL",
    "DOTA_ABILITY_LAST_BEHAVIOR",
    -- DOTA_HeroPickState
    "DOTA_HEROPICK_STATE_NONE",
    "DOTA_HEROPICK_STATE_AP_SELECT",
    "DOTA_HEROPICK_STATE_SD_SELECT",
    "DOTA_HEROPICK_STATE_INTRO_SELECT",
    "DOTA_HEROPICK_STATE_RD_SELECT",
    "DOTA_HEROPICK_STATE_CM_INTRO",
    "DOTA_HEROPICK_STATE_CM_CAPTAINPICK",
    "DOTA_HEROPICK_STATE_CM_BAN1",
    "DOTA_HEROPICK_STATE_CM_BAN2",
    "DOTA_HEROPICK_STATE_CM_BAN3",
    "DOTA_HEROPICK_STATE_CM_BAN4",
    "DOTA_HEROPICK_STATE_CM_BAN5",
    "DOTA_HEROPICK_STATE_CM_BAN6",
    "DOTA_HEROPICK_STATE_CM_BAN7",
    "DOTA_HEROPICK_STATE_CM_BAN8",
    "DOTA_HEROPICK_STATE_CM_BAN9",
    "DOTA_HEROPICK_STATE_CM_BAN10",
    "DOTA_HEROPICK_STATE_CM_SELECT1",
    "DOTA_HEROPICK_STATE_CM_SELECT2",
    "DOTA_HEROPICK_STATE_CM_SELECT3",
    "DOTA_HEROPICK_STATE_CM_SELECT4",
    "DOTA_HEROPICK_STATE_CM_SELECT5",
    "DOTA_HEROPICK_STATE_CM_SELECT6",
    "DOTA_HEROPICK_STATE_CM_SELECT7",
    "DOTA_HEROPICK_STATE_CM_SELECT8",
    "DOTA_HEROPICK_STATE_CM_SELECT9",
    "DOTA_HEROPICK_STATE_CM_SELECT10",
    "DOTA_HEROPICK_STATE_CM_PICK",
    "DOTA_HEROPICK_STATE_AR_SELECT",
    "DOTA_HEROPICK_STATE_MO_SELECT",
    "DOTA_HEROPICK_STATE_FH_SELECT",
    "DOTA_HEROPICK_STATE_CD_INTRO",
    "DOTA_HEROPICK_STATE_CD_CAPTAINPICK",
    "DOTA_HEROPICK_STATE_CD_BAN1",
    "DOTA_HEROPICK_STATE_CD_BAN2",
    "DOTA_HEROPICK_STATE_CD_BAN3",
    "DOTA_HEROPICK_STATE_CD_BAN4",
    "DOTA_HEROPICK_STATE_CD_BAN5",
    "DOTA_HEROPICK_STATE_CD_BAN6",
    "DOTA_HEROPICK_STATE_CD_SELECT1",
    "DOTA_HEROPICK_STATE_CD_SELECT2",
    "DOTA_HEROPICK_STATE_CD_SELECT3",
    "DOTA_HEROPICK_STATE_CD_SELECT4",
    "DOTA_HEROPICK_STATE_CD_SELECT5",
    "DOTA_HEROPICK_STATE_CD_SELECT6",
    "DOTA_HEROPICK_STATE_CD_SELECT7",
    "DOTA_HEROPICK_STATE_CD_SELECT8",
    "DOTA_HEROPICK_STATE_CD_SELECT9",
    "DOTA_HEROPICK_STATE_CD_SELECT10",
    "DOTA_HEROPICK_STATE_CD_PICK",
    "DOTA_HEROPICK_STATE_BD_SELECT",
    "DOTA_HERO_PICK_STATE_ABILITY_DRAFT_SELECT",
    "DOTA_HERO_PICK_STATE_ARDM_SELECT",
    "DOTA_HEROPICK_STATE_ALL_DRAFT_SELECT",
    "DOTA_HERO_PICK_STATE_CUSTOMGAME_SELECT",
    "DOTA_HEROPICK_STATE_COUNT",
    -- DOTA_MOTION_CONTROLLER_PRIORITY
    "DOTA_MOTION_CONTROLLER_PRIORITY_LOWEST",
    "DOTA_MOTION_CONTROLLER_PRIORITY_LOW",
    "DOTA_MOTION_CONTROLLER_PRIORITY_MEDIUM",
    "DOTA_MOTION_CONTROLLER_PRIORITY_HIGH",
    "DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST",
    -- DOTA_RUNES
    "DOTA_RUNE_INVALID",
    "DOTA_RUNE_DOUBLEDAMAGE",
    "DOTA_RUNE_HASTE",
    "DOTA_RUNE_ILLUSION",
    "DOTA_RUNE_INVISIBILITY",
    "DOTA_RUNE_REGENERATION",
    "DOTA_RUNE_BOUNTY",
    "DOTA_RUNE_COUNT",
    "DOTA_RUNE_HAUNTED",
    "DOTA_RUNE_SPOOKY",
    "DOTA_RUNE_RAPIER",
    "DOTA_RUNE_TURBO",
    "DOTA_RUNE_MYSTERY",
    "DOTA_HALLOWEEN_RUNE_COUNT",
    -- DOTA_UNIT_TARGET_FLAGS
    "DOTA_UNIT_TARGET_FLAG_NONE",
    "DOTA_UNIT_TARGET_FLAG_RANGED_ONLY",
    "DOTA_UNIT_TARGET_FLAG_MELEE_ONLY",
    "DOTA_UNIT_TARGET_FLAG_DEAD",
    "DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES",
    "DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES",
    "DOTA_UNIT_TARGET_FLAG_INVULNERABLE",
    "DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE",
    "DOTA_UNIT_TARGET_FLAG_NO_INVIS",
    "DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS",
    "DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED",
    "DOTA_UNIT_TARGET_FLAG_NOT_DOMINATED",
    "DOTA_UNIT_TARGET_FLAG_NOT_SUMMONED",
    "DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS",
    "DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE",
    "DOTA_UNIT_TARGET_FLAG_MANA_ONLY",
    "DOTA_UNIT_TARGET_FLAG_CHECK_DISABLE_HELP",
    "DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO",
    "DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD",
    "DOTA_UNIT_TARGET_FLAG_NOT_NIGHTMARED",
    -- DOTA_UNIT_TARGET_TEAM
    "DOTA_UNIT_TARGET_TEAM_NONE",
    "DOTA_UNIT_TARGET_TEAM_FRIENDLY",
    "DOTA_UNIT_TARGET_TEAM_ENEMY",
    "DOTA_UNIT_TARGET_TEAM_BOTH",
    "DOTA_UNIT_TARGET_TEAM_CUSTOM",
    -- DOTA_UNIT_TARGET_TYPE
    "DOTA_UNIT_TARGET_NONE",
    "DOTA_UNIT_TARGET_HERO",
    "DOTA_UNIT_TARGET_CREEP",
    "DOTA_UNIT_TARGET_BUILDING",
    "DOTA_UNIT_TARGET_MECHANICAL",
    "DOTA_UNIT_TARGET_COURIER",
    "DOTA_UNIT_TARGET_BASIC",
    "DOTA_UNIT_TARGET_OTHER",
    "DOTA_UNIT_TARGET_ALL",
    "DOTA_UNIT_TARGET_TREE",
    "DOTA_UNIT_TARGET_CUSTOM",
    -- EDOTA_ModifyGold_Reason
    "DOTA_ModifyGold_Unspecified",
    "DOTA_ModifyGold_Death",
    "DOTA_ModifyGold_Buyback",
    "DOTA_ModifyGold_PurchaseConsumable",
    "DOTA_ModifyGold_PurchaseItem",
    "DOTA_ModifyGold_AbandonedRedistribute",
    "DOTA_ModifyGold_SellItem",
    "DOTA_ModifyGold_AbilityCost",
    "DOTA_ModifyGold_CheatCommand",
    "DOTA_ModifyGold_SelectionPenalty",
    "DOTA_ModifyGold_GameTick",
    "DOTA_ModifyGold_Building",
    "DOTA_ModifyGold_HeroKill",
    "DOTA_ModifyGold_CreepKill",
    "DOTA_ModifyGold_RoshanKill",
    "DOTA_ModifyGold_CourierKill",
    "DOTA_ModifyGold_SharedGold",
    -- EDOTA_ModifyXP_Reason
    "DOTA_ModifyXP_Unspecified",
    "DOTA_ModifyXP_HeroKill",
    "DOTA_ModifyXP_CreepKill",
    "DOTA_ModifyXP_RoshanKill",
    -- EShareAbility
    "ITEM_FULLY_SHAREABLE",
    "ITEM_PARTIALLY_SHAREABLE",
    "ITEM_NOT_SHAREABLE",
    -- LuaModifierType
    "LUA_MODIFIER_MOTION_NONE",
    "LUA_MODIFIER_MOTION_HORIZONTAL",
    "LUA_MODIFIER_MOTION_VERTICAL",
    "LUA_MODIFIER_MOTION_BOTH",
    "LUA_MODIFIER_INVALID",
    -- ModifierPriority
    "MODIFIER_PRIORITY_LOW",
    "MODIFIER_PRIORITY_NORMAL",
    "MODIFIER_PRIORITY_HIGH",
    "MODIFIER_PRIORITY_ULTRA",
    "MODIFIER_PRIORITY_SUPER_ULTRA",
    -- ParticleAttachment_t
    "PATTACH_INVALID",
    "PATTACH_ABSORIGIN",
    "PATTACH_ABSORIGIN_FOLLOW",
    "PATTACH_CUSTOMORIGIN",
    "PATTACH_CUSTOMORIGIN_FOLLOW",
    "PATTACH_POINT",
    "PATTACH_POINT_FOLLOW",
    "PATTACH_EYES_FOLLOW",
    "PATTACH_OVERHEAD_FOLLOW",
    "PATTACH_WORLDORIGIN",
    "PATTACH_ROOTBONE_FOLLOW",
    "PATTACH_RENDERORIGIN_FOLLOW",
    "PATTACH_MAIN_VIEW",
    "PATTACH_WATERWAKE",
    "MAX_PATTACH_TYPES",
    -- UnitFilterResult
    "UF_SUCCESS",
    "UF_FAIL_FRIENDLY",
    "UF_FAIL_ENEMY",
    "UF_FAIL_HERO",
    "UF_FAIL_CONSIDERED_HERO",
    "UF_FAIL_CREEP",
    "UF_FAIL_BUILDING",
    "UF_FAIL_MECHANICAL",
    "UF_FAIL_COURIER",
    "UF_FAIL_OTHER",
    "UF_FAIL_ANCIENT",
    "UF_FAIL_ILLUSION",
    "UF_FAIL_SUMMONED",
    "UF_FAIL_DOMINATED",
    "UF_FAIL_MELEE",
    "UF_FAIL_RANGED",
    "UF_FAIL_DEAD",
    "UF_FAIL_MAGIC_IMMUNE_ALLY",
    "UF_FAIL_MAGIC_IMMUNE_ENEMY",
    "UF_FAIL_INVULNERABLE",
    "UF_FAIL_IN_FOW",
    "UF_FAIL_INVISIBLE",
    "UF_FAIL_NOT_PLAYER_CONTROLLED",
    "UF_FAIL_ATTACK_IMMUNE",
    "UF_FAIL_CUSTOM",
    "UF_FAIL_INVALID_LOCATION",
    "UF_FAIL_DISABLE_HELP",
    "UF_FAIL_OUT_OF_WORLD",
    "UF_FAIL_NIGHTMARED",
    -- modifierstate
    "MODIFIER_STATE_ROOTED",
    "MODIFIER_STATE_DISARMED",
    "MODIFIER_STATE_ATTACK_IMMUNE",
    "MODIFIER_STATE_SILENCED",
    "MODIFIER_STATE_MUTED",
    "MODIFIER_STATE_STUNNED",
    "MODIFIER_STATE_HEXED",
    "MODIFIER_STATE_INVISIBLE",
    "MODIFIER_STATE_INVULNERABLE",
    "MODIFIER_STATE_MAGIC_IMMUNE",
    "MODIFIER_STATE_PROVIDES_VISION",
    "MODIFIER_STATE_NIGHTMARED",
    "MODIFIER_STATE_BLOCK_DISABLED",
    "MODIFIER_STATE_EVADE_DISABLED",
    "MODIFIER_STATE_UNSELECTABLE",
    "MODIFIER_STATE_CANNOT_MISS",
    "MODIFIER_STATE_SPECIALLY_DENIABLE",
    "MODIFIER_STATE_FROZEN",
    "MODIFIER_STATE_COMMAND_RESTRICTED",
    "MODIFIER_STATE_NOT_ON_MINIMAP",
    "MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES",
    "MODIFIER_STATE_LOW_ATTACK_PRIORITY",
    "MODIFIER_STATE_NO_HEALTH_BAR",
    "MODIFIER_STATE_FLYING",
    "MODIFIER_STATE_NO_UNIT_COLLISION",
    "MODIFIER_STATE_NO_TEAM_MOVE_TO",
    "MODIFIER_STATE_NO_TEAM_SELECT",
    "MODIFIER_STATE_PASSIVES_DISABLED",
    "MODIFIER_STATE_DOMINATED",
    "MODIFIER_STATE_BLIND",
    "MODIFIER_STATE_OUT_OF_GAME",
    "MODIFIER_STATE_FAKE_ALLY",
    "MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY",
    "MODIFIER_STATE_TRUESIGHT_IMMUNE",
    "MODIFIER_STATE_LAST",
    -- quest_text_replace_values_t
    "QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE",
    "QUEST_TEXT_REPLACE_VALUE_TARGET_VALUE",
    "QUEST_TEXT_REPLACE_VALUE_ROUND",
    "QUEST_TEXT_REPLACE_VALUE_REWARD",
    "QUEST_NUM_TEXT_REPLACE_VALUES",
    "Find",
    "FIND_UNITS_EVERYWHERE",
    "FIND_ANY_ORDER",
    "FIND_CLOSEST",
    "FIND_FARTHEST",
    -- subquest_text_replace_values_t
    "SUBQUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE",
    "SUBQUEST_TEXT_REPLACE_VALUE_TARGET_VALUE",
    "SUBQUEST_NUM_TEXT_REPLACE_VALUES",
    -- DOTAScriptInventorySlot_t
    "DOTA_ITEM_SLOT_1",
    "DOTA_ITEM_SLOT_2",
    "DOTA_ITEM_SLOT_3",
    "DOTA_ITEM_SLOT_4",
    "DOTA_ITEM_SLOT_5",
    "DOTA_ITEM_SLOT_6",
    "DOTA_STASH_SLOT_1",
    "DOTA_STASH_SLOT_2",
    "DOTA_STASH_SLOT_3",
    "DOTA_STASH_SLOT_4",
    "DOTA_STASH_SLOT_5",
    "DOTA_STASH_SLOT_6",
    -- DOTA_GameState
    "DOTA_GAMERULES_STATE_INIT",
    "DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD",
    "DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP",
    "DOTA_GAMERULES_STATE_HERO_SELECTION",
    "DOTA_GAMERULES_STATE_STRATEGY_TIME",
    "DOTA_GAMERULES_STATE_TEAM_SHOWCASE",
    "DOTA_GAMERULES_STATE_PRE_GAME",
    "DOTA_GAMERULES_STATE_GAME_IN_PROGRESS",
    "DOTA_GAMERULES_STATE_POST_GAME",
    "DOTA_GAMERULES_STATE_DISCONNECT",
    -- DOTALimits_t
    "DOTA_DEFAULT_MAX_TEAM",
    "DOTA_DEFAULT_MAX_TEAM_PLAYERS",
    "DOTA_MAX_PLAYER_TEAMS",
    "DOTA_MAX_TEAM",
    "DOTA_MAX_TEAM_PLAYERS",
    "DOTA_MAX_SPECTATOR_TEAM_SIZE",
    "DOTA_MAX_PLAYERS",
    -- GameActivity_t
    "ACT_DOTA_IDLE",
    "ACT_DOTA_IDLE_RARE",
    "ACT_DOTA_RUN",
    "ACT_DOTA_ATTACK",
    "ACT_DOTA_ATTACK2",
    "ACT_DOTA_ATTACK_EVENT",
    "ACT_DOTA_DIE",
    "ACT_DOTA_FLINCH",
    "ACT_DOTA_FLAIL",
    "ACT_DOTA_DISABLED",
    "ACT_DOTA_CAST_ABILITY_1",
    "ACT_DOTA_CAST_ABILITY_2",
    "ACT_DOTA_CAST_ABILITY_3",
    "ACT_DOTA_CAST_ABILITY_4",
    "ACT_DOTA_CAST_ABILITY_5",
    "ACT_DOTA_CAST_ABILITY_6",
    "ACT_DOTA_OVERRIDE_ABILITY_1",
    "ACT_DOTA_OVERRIDE_ABILITY_2",
    "ACT_DOTA_OVERRIDE_ABILITY_3",
    "ACT_DOTA_OVERRIDE_ABILITY_4",
    "ACT_DOTA_CHANNEL_ABILITY_1",
    "ACT_DOTA_CHANNEL_ABILITY_2",
    "ACT_DOTA_CHANNEL_ABILITY_3",
    "ACT_DOTA_CHANNEL_ABILITY_4",
    "ACT_DOTA_CHANNEL_ABILITY_5",
    "ACT_DOTA_CHANNEL_ABILITY_6",
    "ACT_DOTA_CHANNEL_END_ABILITY_1",
    "ACT_DOTA_CHANNEL_END_ABILITY_2",
    "ACT_DOTA_CHANNEL_END_ABILITY_3",
    "ACT_DOTA_CHANNEL_END_ABILITY_4",
    "ACT_DOTA_CHANNEL_END_ABILITY_5",
    "ACT_DOTA_CHANNEL_END_ABILITY_6",
    "ACT_DOTA_CONSTANT_LAYER",
    "ACT_DOTA_CAPTURE",
    "ACT_DOTA_SPAWN",
    "ACT_DOTA_KILLTAUNT",
    "ACT_DOTA_TAUNT",
    "ACT_DOTA_THIRST",
    "ACT_DOTA_CAST_DRAGONBREATH",
    "ACT_DOTA_ECHO_SLAM",
    "ACT_DOTA_CAST_ABILITY_1_END",
    "ACT_DOTA_CAST_ABILITY_2_END",
    "ACT_DOTA_CAST_ABILITY_3_END",
    "ACT_DOTA_CAST_ABILITY_4_END",
    "ACT_MIRANA_LEAP_END",
    "ACT_WAVEFORM_START",
    "ACT_WAVEFORM_END",
    "ACT_DOTA_CAST_ABILITY_ROT",
    "ACT_DOTA_DIE_SPECIAL",
    "ACT_DOTA_RATTLETRAP_BATTERYASSAULT",
    "ACT_DOTA_RATTLETRAP_POWERCOGS",
    "ACT_DOTA_RATTLETRAP_HOOKSHOT_START",
    "ACT_DOTA_RATTLETRAP_HOOKSHOT_LOOP",
    "ACT_DOTA_RATTLETRAP_HOOKSHOT_END",
    "ACT_STORM_SPIRIT_OVERLOAD_RUN_OVERRIDE",
    "ACT_DOTA_TINKER_REARM1",
    "ACT_DOTA_TINKER_REARM2",
    "ACT_DOTA_TINKER_REARM3",
    "ACT_TINY_AVALANCHE",
    "ACT_TINY_TOSS",
    "ACT_TINY_GROWL",
    "ACT_DOTA_WEAVERBUG_ATTACH",
    "ACT_DOTA_CAST_WILD_AXES_END",
    "ACT_DOTA_CAST_LIFE_BREAK_START",
    "ACT_DOTA_CAST_LIFE_BREAK_END",
    "ACT_DOTA_NIGHTSTALKER_TRANSITION",
    "ACT_DOTA_LIFESTEALER_RAGE",
    "ACT_DOTA_LIFESTEALER_OPEN_WOUNDS",
    "ACT_DOTA_SAND_KING_BURROW_IN",
    "ACT_DOTA_SAND_KING_BURROW_OUT",
    "ACT_DOTA_EARTHSHAKER_TOTEM_ATTACK",
    "ACT_DOTA_WHEEL_LAYER",
    "ACT_DOTA_ALCHEMIST_CHEMICAL_RAGE_START",
    "ACT_DOTA_ALCHEMIST_CONCOCTION",
    "ACT_DOTA_JAKIRO_LIQUIDFIRE_START",
    "ACT_DOTA_JAKIRO_LIQUIDFIRE_LOOP",
    "ACT_DOTA_LIFESTEALER_INFEST",
    "ACT_DOTA_LIFESTEALER_INFEST_END",
    "ACT_DOTA_LASSO_LOOP",
    "ACT_DOTA_ALCHEMIST_CONCOCTION_THROW",
    "ACT_DOTA_ALCHEMIST_CHEMICAL_RAGE_END",
    "ACT_DOTA_CAST_COLD_SNAP",
    "ACT_DOTA_CAST_GHOST_WALK",
    "ACT_DOTA_CAST_TORNADO",
    "ACT_DOTA_CAST_EMP",
    "ACT_DOTA_CAST_ALACRITY",
    "ACT_DOTA_CAST_CHAOS_METEOR",
    "ACT_DOTA_CAST_SUN_STRIKE",
    "ACT_DOTA_CAST_FORGE_SPIRIT",
    "ACT_DOTA_CAST_ICE_WALL",
    "ACT_DOTA_CAST_DEAFENING_BLAST",
    "ACT_DOTA_VICTORY",
    "ACT_DOTA_DEFEAT",
    "ACT_DOTA_SPIRIT_BREAKER_CHARGE_POSE",
    "ACT_DOTA_SPIRIT_BREAKER_CHARGE_END",
    "ACT_DOTA_TELEPORT",
    "ACT_DOTA_TELEPORT_END",
    "ACT_DOTA_CAST_REFRACTION",
    "ACT_DOTA_CAST_ABILITY_7",
    "ACT_DOTA_CANCEL_SIREN_SONG",
    "ACT_DOTA_CHANNEL_ABILITY_7",
    "ACT_DOTA_LOADOUT",
    "ACT_DOTA_FORCESTAFF_END",
    "ACT_DOTA_POOF_END",
    "ACT_DOTA_SLARK_POUNCE",
    "ACT_DOTA_MAGNUS_SKEWER_START",
    "ACT_DOTA_MAGNUS_SKEWER_END",
    "ACT_DOTA_MEDUSA_STONE_GAZE",
    "ACT_DOTA_RELAX_START",
    "ACT_DOTA_RELAX_LOOP",
    "ACT_DOTA_RELAX_END",
    "ACT_DOTA_CENTAUR_STAMPEDE",
    "ACT_DOTA_BELLYACHE_START",
    "ACT_DOTA_BELLYACHE_LOOP",
    "ACT_DOTA_BELLYACHE_END",
    "ACT_DOTA_ROQUELAIRE_LAND",
    "ACT_DOTA_ROQUELAIRE_LAND_IDLE",
    "ACT_DOTA_GREEVIL_CAST",
    "ACT_DOTA_GREEVIL_OVERRIDE_ABILITY",
    "ACT_DOTA_GREEVIL_HOOK_START",
    "ACT_DOTA_GREEVIL_HOOK_END",
    "ACT_DOTA_GREEVIL_BLINK_BONE",
    "ACT_DOTA_IDLE_SLEEPING",
    "ACT_DOTA_INTRO",
    "ACT_DOTA_GESTURE_POINT",
    "ACT_DOTA_GESTURE_ACCENT",
    "ACT_DOTA_SLEEPING_END",
    "ACT_DOTA_AMBUSH",
    "ACT_DOTA_ITEM_LOOK",
    "ACT_DOTA_STARTLE",
    "ACT_DOTA_FRUSTRATION",
    "ACT_DOTA_TELEPORT_REACT",
    "ACT_DOTA_TELEPORT_END_REACT",
    "ACT_DOTA_SHRUG",
    "ACT_DOTA_RELAX_LOOP_END",
    "ACT_DOTA_PRESENT_ITEM",
    "ACT_DOTA_IDLE_IMPATIENT",
    "ACT_DOTA_SHARPEN_WEAPON",
    "ACT_DOTA_SHARPEN_WEAPON_OUT",
    "ACT_DOTA_IDLE_SLEEPING_END",
    "ACT_DOTA_BRIDGE_DESTROY",
    "ACT_DOTA_TAUNT_SNIPER",
    "ACT_DOTA_DEATH_BY_SNIPER",
    "ACT_DOTA_LOOK_AROUND",
    "ACT_DOTA_CAGED_CREEP_RAGE",
    "ACT_DOTA_CAGED_CREEP_RAGE_OUT",
    "ACT_DOTA_CAGED_CREEP_SMASH",
    "ACT_DOTA_CAGED_CREEP_SMASH_OUT",
    "ACT_DOTA_IDLE_IMPATIENT_SWORD_TAP",
    "ACT_DOTA_INTRO_LOOP",
    "ACT_DOTA_BRIDGE_THREAT",
    "ACT_DOTA_DAGON",
    "ACT_DOTA_CAST_ABILITY_2_ES_ROLL_START",
    "ACT_DOTA_CAST_ABILITY_2_ES_ROLL",
    "ACT_DOTA_CAST_ABILITY_2_ES_ROLL_END",
    "ACT_DOTA_NIAN_PIN_START",
    "ACT_DOTA_NIAN_PIN_LOOP",
    "ACT_DOTA_NIAN_PIN_END",
    "ACT_DOTA_LEAP_STUN",
    "ACT_DOTA_LEAP_SWIPE",
    "ACT_DOTA_NIAN_INTRO_LEAP",
    "ACT_DOTA_AREA_DENY",
    "ACT_DOTA_NIAN_PIN_TO_STUN",
    "ACT_DOTA_RAZE_1",
    "ACT_DOTA_RAZE_2",
    "ACT_DOTA_RAZE_3",
    "ACT_DOTA_UNDYING_DECAY",
    "ACT_DOTA_UNDYING_SOUL_RIP",
    "ACT_DOTA_UNDYING_TOMBSTONE",
    "ACT_DOTA_WHIRLING_AXES_RANGED",
    "ACT_DOTA_SHALLOW_GRAVE",
    "ACT_DOTA_COLD_FEET",
    "ACT_DOTA_ICE_VORTEX",
    "ACT_DOTA_CHILLING_TOUCH",
    "ACT_DOTA_ENFEEBLE",
    "ACT_DOTA_FATAL_BONDS",
    "ACT_DOTA_MIDNIGHT_PULSE",
    "ACT_DOTA_ANCESTRAL_SPIRIT",
    "ACT_DOTA_THUNDER_STRIKE",
    "ACT_DOTA_KINETIC_FIELD",
    "ACT_DOTA_STATIC_STORM",
    "ACT_DOTA_MINI_TAUNT",
    "ACT_DOTA_ARCTIC_BURN_END",
    "ACT_DOTA_LOADOUT_RARE",
    "ACT_DOTA_SWIM",
    "ACT_DOTA_FLEE",
    "ACT_DOTA_TROT",
    "ACT_DOTA_SHAKE",
    "ACT_DOTA_SWIM_IDLE",
    "ACT_DOTA_WAIT_IDLE",
    "ACT_DOTA_GREET",
    "ACT_DOTA_TELEPORT_COOP_START",
    "ACT_DOTA_TELEPORT_COOP_WAIT",
    "ACT_DOTA_TELEPORT_COOP_END",
    "ACT_DOTA_TELEPORT_COOP_EXIT",
    "ACT_DOTA_SHOPKEEPER_PET_INTERACT",
    "ACT_DOTA_ITEM_PICKUP",
    "ACT_DOTA_ITEM_DROP",
    "ACT_DOTA_CAPTURE_PET",
    "ACT_DOTA_PET_WARD_OBSERVER",
    "ACT_DOTA_PET_WARD_SENTRY",
    "ACT_DOTA_PET_LEVEL",
    "ACT_DOTA_CAST_BURROW_END",
    "ACT_DOTA_LIFESTEALER_ASSIMILATE",
    "ACT_DOTA_LIFESTEALER_EJECT",
    "ACT_DOTA_ATTACK_EVENT_BASH",
    "ACT_DOTA_CAPTURE_RARE",
    "ACT_DOTA_AW_MAGNETIC_FIELD",
    "ACT_DOTA_CAST_GHOST_SHIP",
    -- modifierfunction
    "MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE",
    "MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT",
    "MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE",
    "MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL",
    "MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL",
    "MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE",
    "MODIFIER_PROPERTY_PROCATTACK_FEEDBACK",
    "MODIFIER_PROPERTY_PRE_ATTACK",
    "MODIFIER_PROPERTY_INVISIBILITY_LEVEL",
    "MODIFIER_PROPERTY_PERSISTENT_INVISIBILITY",
    "MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT",
    "MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE",
    "MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE",
    "MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE_UNIQUE",
    "MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE",
    "MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE",
    "MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN",
    "MODIFIER_PROPERTY_MOVESPEED_LIMIT",
    "MODIFIER_PROPERTY_MOVESPEED_MAX",
    "MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT",
    "MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT_POWER_TREADS",
    "MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT_SECONDARY",
    "MODIFIER_PROPERTY_COOLDOWN_REDUCTION_CONSTANT",
    "MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT",
    "MODIFIER_PROPERTY_ATTACK_POINT_CONSTANT",
    "MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE",
    "MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION",
    "MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE",
    "MODIFIER_PROPERTY_MAGICDAMAGEOUTGOING_PERCENTAGE",
    "MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE",
    "MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE_UNIQUE",
    "MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE",
    "MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE",
    "MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT",
    "MODIFIER_PROPERTY_EVASION_CONSTANT",
    "MODIFIER_PROPERTY_AVOID_DAMAGE",
    "MODIFIER_PROPERTY_AVOID_SPELL",
    "MODIFIER_PROPERTY_MISS_PERCENTAGE",
    "MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS",
    "MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_ILLUSIONS",
    "MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE",
    "MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE_ACTIVE",
    "MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS",
    "MODIFIER_PROPERTY_MAGICAL_RESISTANCE_ITEM_UNIQUE",
    "MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DECREPIFY_UNIQUE",
    "MODIFIER_PROPERTY_BASE_MANA_REGEN",
    "MODIFIER_PROPERTY_MANA_REGEN_CONSTANT",
    "MODIFIER_PROPERTY_MANA_REGEN_CONSTANT_UNIQUE",
    "MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE",
    "MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE",
    "MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT",
    "MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE",
    "MODIFIER_PROPERTY_HEALTH_BONUS",
    "MODIFIER_PROPERTY_MANA_BONUS",
    "MODIFIER_PROPERTY_EXTRA_STRENGTH_BONUS",
    "MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS",
    "MODIFIER_PROPERTY_EXTRA_MANA_BONUS",
    "MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE",
    "MODIFIER_PROPERTY_STATS_STRENGTH_BONUS",
    "MODIFIER_PROPERTY_STATS_AGILITY_BONUS",
    "MODIFIER_PROPERTY_STATS_INTELLECT_BONUS",
    "MODIFIER_PROPERTY_ATTACK_RANGE_BONUS",
    "MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS",
    "MODIFIER_PROPERTY_REINCARNATION",
    "MODIFIER_PROPERTY_CAST_RANGE_BONUS",
    "MODIFIER_PROPERTY_RESPAWNTIME",
    "MODIFIER_PROPERTY_RESPAWNTIME_PERCENTAGE",
    "MODIFIER_PROPERTY_RESPAWNTIME_STACKING",
    "MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE",
    "MODIFIER_PROPERTY_CASTTIME_PERCENTAGE",
    "MODIFIER_PROPERTY_MANACOST_PERCENTAGE",
    "MODIFIER_PROPERTY_DEATHGOLDCOST",
    "MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE",
    "MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK",
    "MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK_UNAVOIDABLE_PRE_ARMOR",
    "MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK",
    "MODIFIER_PROPERTY_OVERRIDE_ANIMATION",
    "MODIFIER_PROPERTY_OVERRIDE_ANIMATION_WEIGHT",
    "MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE",
    "MODIFIER_PROPERTY_ABSORB_SPELL",
    "MODIFIER_PROPERTY_REFLECT_SPELL",
    "MODIFIER_PROPERTY_DISABLE_AUTOATTACK",
    "MODIFIER_PROPERTY_BONUS_DAY_VISION",
    "MODIFIER_PROPERTY_BONUS_NIGHT_VISION",
    "MODIFIER_PROPERTY_BONUS_NIGHT_VISION_UNIQUE",
    "MODIFIER_PROPERTY_BONUS_VISION_PERCENTAGE",
    "MODIFIER_PROPERTY_FIXED_DAY_VISION",
    "MODIFIER_PROPERTY_FIXED_NIGHT_VISION",
    "MODIFIER_PROPERTY_MIN_HEALTH",
    "MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL",
    "MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL",
    "MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE",
    "MODIFIER_PROPERTY_IS_ILLUSION",
    "MODIFIER_PROPERTY_ILLUSION_LABEL",
    "MODIFIER_PROPERTY_SUPER_ILLUSION",
    "MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE",
    "MODIFIER_PROPERTY_DISABLE_HEALING",
    "MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL",
    "MODIFIER_PROPERTY_UNIT_STATS_NEEDS_REFRESH",
    "MODIFIER_PROPERTY_BOUNTY_CREEP_MULTIPLIER",
    "MODIFIER_PROPERTY_BOUNTY_OTHER_MULTIPLIER",
    "MODIFIER_EVENT_ON_ATTACK_RECORD",
    "MODIFIER_EVENT_ON_ATTACK_START",
    "MODIFIER_EVENT_ON_ATTACK",
    "MODIFIER_EVENT_ON_ATTACK_LANDED",
    "MODIFIER_EVENT_ON_ATTACK_FAIL",
    "MODIFIER_EVENT_ON_ATTACK_ALLIED",
    "MODIFIER_EVENT_ON_PROJECTILE_DODGE",
    "MODIFIER_EVENT_ON_ORDER",
    "MODIFIER_EVENT_ON_UNIT_MOVED",
    "MODIFIER_EVENT_ON_ABILITY_START",
    "MODIFIER_EVENT_ON_ABILITY_EXECUTED",
    "MODIFIER_EVENT_ON_ABILITY_FULLY_CAST",
    "MODIFIER_EVENT_ON_BREAK_INVISIBILITY",
    "MODIFIER_EVENT_ON_ABILITY_END_CHANNEL",
    "MODIFIER_EVENT_ON_PROCESS_UPGRADE",
    "MODIFIER_EVENT_ON_REFRESH",
    "MODIFIER_EVENT_ON_TAKEDAMAGE",
    "MODIFIER_EVENT_ON_STATE_CHANGED",
    "MODIFIER_EVENT_ON_ORB_EFFECT",
    "MODIFIER_EVENT_ON_ATTACKED",
    "MODIFIER_EVENT_ON_DEATH",
    "MODIFIER_EVENT_ON_RESPAWN",
    "MODIFIER_EVENT_ON_SPENT_MANA",
    "MODIFIER_EVENT_ON_TELEPORTING",
    "MODIFIER_EVENT_ON_TELEPORTED",
    "MODIFIER_EVENT_ON_SET_LOCATION",
    "MODIFIER_EVENT_ON_HEALTH_GAINED",
    "MODIFIER_EVENT_ON_MANA_GAINED",
    "MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT",
    "MODIFIER_EVENT_ON_HERO_KILLED",
    "MODIFIER_EVENT_ON_HEAL_RECEIVED",
    "MODIFIER_EVENT_ON_BUILDING_KILLED",
    "MODIFIER_EVENT_ON_MODEL_CHANGED",
    "MODIFIER_PROPERTY_TOOLTIP",
    "MODIFIER_PROPERTY_MODEL_CHANGE",
    "MODIFIER_PROPERTY_MODEL_SCALE",
    "MODIFIER_PROPERTY_IS_SCEPTER",
    "MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS",
    "MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND",
    "MODIFIER_PROPERTY_LIFETIME_FRACTION",
    "MODIFIER_PROPERTY_PROVIDES_FOW_POSITION",
    "MODIFIER_PROPERTY_SPELLS_REQUIRE_HP",
    "MODIFIER_PROPERTY_FORCE_DRAW_MINIMAP",
    "MODIFIER_PROPERTY_DISABLE_TURNING",
    "MODIFIER_PROPERTY_IGNORE_CAST_ANGLE",
    "MODIFIER_PROPERTY_CHANGE_ABILITY_VALUE",
    "MODIFIER_PROPERTY_ABILITY_LAYOUT",
    "MODIFIER_EVENT_ON_DOMINATED",
    "MODIFIER_PROPERTY_TEMPEST_DOUBLE",
    "MODIFIER_PROPERTY_PRESERVE_PARTICLES_ON_MODEL_CHANGE",
    "MODIFIER_FUNCTION_LAST",
    "MODIFIER_FUNCTION_INVALID",
    -- DOTA_CONNECTION_STATE
    "DOTA_CONNECTION_STATE_UNKNOWN",
    "DOTA_CONNECTION_STATE_NOT_YET_CONNECTED",
    "DOTA_CONNECTION_STATE_CONNECTED",
    "DOTA_CONNECTION_STATE_DISCONNECTED",
    "DOTA_CONNECTION_STATE_ABANDONED",
    "DOTA_CONNECTION_STATE_LOADING",
    "DOTA_CONNECTION_STATE_FAILED",
  }
}
exclude_files = {
  "game/scripts/vscripts/statcollection" -- we just ignore getdotastats
}
