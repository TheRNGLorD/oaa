/* global $, GetDotaHud, Players*/

let local_player = Players.GetLocalPlayer();
let DotaHUD = GetDotaHud()


$.RegisterForUnhandledEvent("StyleClassesChanged", function(panel){
  if(panel == null){return;}
  if(panel.paneltype == "DOTAAbilityPanel" && panel.BHasClass("ShowingItemContextMenu")) {
      let currentlySelectedUnit = Players.GetQueryUnit(local_player);
      if (currentlySelectedUnit === -1) {
        currentlySelectedUnit = Players.GetLocalPlayerPortraitUnit();
      }
      if (currentlySelectedUnit !== Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer())) return;
      if(!Entities.IsRealHero(Players.GetLocalPlayerPortraitUnit())){return;}
      const itemImage = panel.FindChildTraverse("ItemImage")
      let abilityIndex = itemImage.contextEntityIndex;
      let FindContextMenu = DotaHUD.FindChildTraverse("InventoryItemContextMenu")
      if(FindContextMenu){
          let Buttons = FindContextMenu.FindChildTraverse("Contents")
          if(Buttons){
              let FPanel = Buttons.FindChildTraverse("TestButton")
              if(!FPanel){
                  let panel = $.CreatePanel("Button", Buttons, "TestButton")
                  panel.visible = true
                  $.CreatePanel("Label", panel, "TestText", {text:$.Localize("#DOTA_SHOP_DETAILS_UPGRADE")})
                  panel.SetPanelEvent("onactivate", function() {
                      $.Msg(Abilities.GetAbilityName( abilityIndex ))
                      let itemName = Abilities.GetAbilityName( abilityIndex )
                      $.Msg(GetItemID(itemName))
                      buyUpgrade(local_player, itemName)
                      $.DispatchEvent("DismissAllContextMenus");
                  })
              }
          }
      }
  }
});

function isUpgradable (itemName) {
  let upgradeItemName = ""
  itemTier = 0
  if (/_\d$/.test(itemName)) {
    itemTier = Number(itemName.slice(-1))
    upgradeItemName = itemName.slice(0, -1) + (itemTier + 1) 
  } else {
    itemTier = 2
    upgradeItemName = itemName + "_2"
  }
  itemID = GetItemID(upgradeItemName)
  if (itemID) {
    return [upgradeItemName, itemTier]
  }
  return null
}

function buyUpgrade (ent, itemName) {
  var [upgradeItemName, itemTier] = isUpgradable(itemName)
  $.Msg(itemTier)
  var order = {}
  order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_PURCHASE_ITEM
  order.UnitIndex = ent
  order.AbilityIndex = Number(GetItemID(upgradeItemName.replace("item_", "item_recipe_")))
  order.Queue = false
  order.ShowEffects = true
  Game.PrepareUnitOrders(order)
  var core = "item_upgrade_core"
  if (itemTier >= 2) {
    core = core + "_" + (itemTier)
  }
  order.AbilityIndex = Number(GetItemID(core))
  Game.PrepareUnitOrders(order)
}

function GetItemID(itemName) {
  let allItems = CustomNetTables.GetTableValue("item_kv", "custom_items");
  $.Msg(allItems[itemName])
  if (allItems && allItems[itemName]) {
      return allItems[(itemName)];
  }
  return null;
}