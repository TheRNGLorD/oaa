var test = require('tape');
var Lib = require('../kv-lib');
var path = require('path');
var fs = require('fs');
var after = require('after');
var spok = require('spok');
var extend = require('xtend');
var partial = require('ap').partial;

var dotaItems = null;
var dotaItemIDs = null;
var dotaAbilities = null;
var dotaItemList = null;
var dotaAbilityList = null;
var stupidItemNames = [
  'item_recipe',
  'item_halloween_candy_corn',
  'item_halloween_rapier',
  'item_firework_mine',
  'nothing'
];

var itemsFound = {};
var idsFound = {};
var itemFileMap = {};
var nextAvailableId = 5000;

test('KV Values', function (t) {
  t.test('before', function (t) {
    t.plan(4);
    Lib.dotaItems(function (err, data) {
      t.notOk(err, 'no err while reading dota items');
      dotaItems = data;
      dotaItemList = Object.keys(dotaItems).filter(a => a !== 'values');
      dotaItemIDs = dotaItemList
        .map(function (item) {
          // console.log(dotaItems[item]);
          return dotaItems[item].values.ID;
        })
        .filter(a => !!a);

      while (dotaItemIDs.indexOf(nextAvailableId) !== -1) {
        nextAvailableId++;
      }

      t.ok(Object.keys(data).length > 1, 'gets dota items from github');
    });
    Lib.dotaAbilities(function (err, data) {
      t.notOk(err, 'no err while reading dota abilities');
      dotaAbilities = data;
      dotaAbilityList = Object.keys(dotaAbilities).filter(a => a !== 'values');
      t.ok(Object.keys(data).length > 1, 'gets dota abilities from github');
    });
  });
  t.test('Testing all item KV values', function (t) {
    dotaItems['item_lua'] = true;
    dotaAbilities['ability_lua'] = true;
    dotaItems['item_datadriven'] = true;
    dotaAbilities['ability_datadriven'] = true;
    Lib.items(function (err, data) {
      if (err) {
        t.notOk(err, 'no err while item reading kvs');
        itemsFound = {};
        return t.end();
      }

      var keys = Object.keys(data);
      var done = after(keys.length + 1, t.end);
      keys.forEach(function (name) {
        checkKVData(t, name, data[name], true, done);
      });
      buildItemTree(t, data, done);
    });
  });
  t.test('Testing all ability KV values', function (t) {
    Lib.abilities(function (err, data) {
      if (err) {
        t.notOk(err, 'no err while ability reading kvs');
        itemsFound = {};
        return t.end();
      }

      var keys = Object.keys(data);
      var done = after(keys.length, t.end);
      keys.forEach(function (name) {
        checkKVData(t, name, data[name], false, done);
      });
    });
  });
  t.test('next available ID', function (t) {
    t.ok(nextAvailableId, 'found an available id');
    console.log('Next available ID is', nextAvailableId);
    t.end();
  });
});

var specialValuesForItem = {};

function checkKVData (t, name, data, isItem, cb) {
  t.test(name, function (t) {
    var root = data;
    var foundRoot = false;
    if (root.DOTAItems) {
      root = root.DOTAItems;
      foundRoot = true;
    }
    if (root.DOTAAbilities) {
      root = root.DOTAAbilities;
      foundRoot = true;
    }
    t.ok(foundRoot, 'Starts with either DOTAItems or DOTAAbilities');

    var keys = Object.keys(root).filter(a => a !== 'values');
    var done = after(keys.length, function (err) {
      t.notOk(err, 'no error at very end');
      t.end();
      cb(err);
    });
    keys.forEach(partial(testKVItem, t, root, isItem, name, done));
  });
}

function testKVItem (t, root, isItem, fileName, cb, item) {
  var iconDirectory = isItem
    ? 'items'
    : 'spellicons';
  // t.test(item, function (t) {

  itemFileMap[item] = fileName;
  var done = after(3, function (err) {
    t.notOk(err, 'no error at very end');
    // t.end();
    cb(err);
  });
  var values = root[item].values;
  var isBuiltIn = isItem
    ? dotaItems[item] && dotaItems[item] !== true
    : dotaAbilities[item] && dotaAbilities[item] !== true;

  t.notOk(itemsFound[item], 'can only be defined once');
  if (item !== 'ability_base_datadriven') {
    t.notOk(idsFound[values.ID], 'must have a unique ID');
    if (!isBuiltIn && item !== 'item_dummy_datadriven') {
      t.ok(values.ID, 'must have an item id');
      t.ok(!isItem || values.ItemCost, 'non-built-in items must have prices');
      t.ok(dotaItemIDs.indexOf(values.ID) === -1, 'cannot use an id used by dota');
    }
  }

  itemsFound[item] = item;
  idsFound[values.ID] = item;

  while (dotaItemIDs.indexOf(nextAvailableId) !== -1 || idsFound['' + nextAvailableId]) {
    nextAvailableId += 1;
  }

  var icon = values.AbilityTextureName;

  if (icon) {
    t.equal(values.AbilityTextureName.toLowerCase(), values.AbilityTextureName, 'Icon names must be lowercase');

    if (stupidItemNames.indexOf(icon) === -1 && dotaItemList.indexOf(icon) === -1 && dotaAbilityList.indexOf(icon) === -1) {
      if (icon.substr(-4) === '.png') {
        t.fail('AbilityTextureName should not contain file extension');
      }
      var iconParts = icon.split('/');
      if (iconParts[0] === 'item_custom') {
        iconParts[0] = 'custom';
      }
      if (iconParts[iconParts.length - 1].substr(0, 5) === 'item_') {
        t.fail('AbilityTextureName should not start with item_');
      }
      icon = iconParts.join('/');
      icon += '.png';
      fs.access(path.join(Lib.gameDir, 'resource/flash3/images/', iconDirectory, icon), function (err, data) {
        t.notOk(err, 'icon ' + icon + ' exists for ' + item);
        done();
      });
    } else {
      done();
    }
  } else {
    done();
  }
  var parentKV = null;
  if (values.BaseClass) {
    if (isItem) {
      t.ok(dotaItems[values.BaseClass], 'base class ' + values.BaseClass + ' must be item_datadriven, item_lua, or a built in item');
    } else {
      t.ok(dotaAbilities[values.BaseClass], 'base class ' + values.BaseClass + ' must be ability_datadriven, ability_lua, or a built in ability');
    }
  } else {
    if (isItem) {
      t.ok(dotaItems[item], 'missing baseclass only allowed when overriding built in items');
      parentKV = dotaItems[item];
    } else {
      t.ok(dotaAbilities[item], 'missing baseclass only allowed when overriding built in abilities');
      parentKV = dotaAbilities[item];
    }
  }
  if (parentKV && values.ID) {
    checkInheritedValues(t, values, root[item].comments, parentKV.values);
  }

  if (values.ScriptFile) {
    fs.access(path.join(Lib.vscriptDir, values.ScriptFile), function (err, data) {
      t.notOk(err, 'script file referenced from kv exists');
      done();
    });
  } else {
    done();
  }
  var specials = root[item].AbilitySpecial;

  if (specials) {
    // check specials!
    var rootItem = item.match(/^(.*?)(_[0-9]+)?$/);
    t.ok(rootItem, 'can parse basic item name out');
    // var version = rootItem[2];
    rootItem = rootItem[1];
    if (!specialValuesForItem[rootItem]) {
      if (!isItem) {
        testSpecialValues(t, specials, parentKV ? parentKV.AbilitySpecial : null);
      }
      specialValuesForItem[rootItem] = specials;
    } else {
      spok(t, specials, specialValuesForItem[rootItem], 'special values are consistent');
    }
    done();
  } else {
    done();
  }
  // });
}

function checkInheritedValues (t, values, comments, parentValues) {
  if (values.ID) {
    t.equals(values.ID, parentValues.ID, 'ID must not be changed from base dota item');
  }
  if (values.AbilityBehavior && (!comments.AbilityBehavior || !comments.AbilityBehavior.includes('OAA'))) {
    t.equals(values.AbilityBehavior, parentValues.AbilityBehavior, 'AbilityBehavior must not be changed from base dota item');
  }
  if (values.ItemCost && (!comments.ItemCost || !comments.ItemCost.includes('OAA'))) {
    t.equals(values.ItemCost, parentValues.ItemCost, 'ItemCost must not be changed from base dota item (' + parentValues.ItemCost + ' vs ' + values.ItemCost + ')');
  }
}

function testSpecialValues (t, specials, parentSpecials) {
  var values = Object.keys(specials).filter(a => a !== 'values');
  var result = {};
  var parentData = {};

  if (parentSpecials) {
    var parentValues = Object.keys(parentSpecials).filter(a => a !== 'values');
    parentValues.forEach(function (num) {
      var value = parentSpecials[num].values;
      var keyNames = filterExtraKeysFromSpecialValue(Object.keys(value));

      parentData[keyNames[0]] = value;
    });
  }

  values.forEach(function (num) {
    var value = specials[num].values;
    t.ok(value.var_type, 'has a var_type ' + num);

    var keyNames = filterExtraKeysFromSpecialValue(Object.keys(value));
    t.equal(keyNames.length, 1, 'gets keyname after filtering out extra values');

    var keyName = keyNames[0];

    if (parentSpecials && !parentSpecials[num].values[keyName]) {
      if (!parentData[keyName]) {
        t.fail('Extra keyname found in special values: ' + keyName);
      } else {
        t.fail('special value in wrong order: ' + keyName);
      }
    }
    if (parentData[keyName]) {
      // console.log(parentData[keyName], value);
      var compareValue = extend(value);
      compareValue[keyName] = parentData[keyName][keyName];
      compareValue.var_type = parentData[keyName].var_type;
      spok(t, compareValue, parentData[keyName], keyName + ' has all the special values from parent ');

      console.log(specials[num].comments[keyName]);

      if (!specials[num].comments[keyName] || !specials[num].comments[keyName].includes('OAA')) {
        // test base dota values
        var baseValue = '';
        if (value[keyName].length < parentData[keyName][keyName].length) {
          baseValue = parentData[keyName][keyName].split(' ').map(function (entry) {
            return value[keyName];
          }).join(' ');
        } else {
          baseValue = value[keyName].substr(0, parentData[keyName][keyName].length);
        }
        t.equal(parentData[keyName][keyName], baseValue, keyName + ' should inherit basic dota values (' + parentData[keyName][keyName] + ' vs ' + baseValue + ')');
      }
    }

    if (result[keyName]) {
      t.fail('Special value found twice: ' + keyName);
    }
    result[keyName] = value[keyName];
  });

  Object.keys(parentData).forEach(function (name) {
    t.ok(result[name], 'has value for ' + name);
  });

  return result;
}

var keyWhiteList = [
  'var_type',
  'LinkedSpecialBonus',
  'LinkedSpecialBonusField',
  'LinkedSpecialBonusOperation',
  'CalculateSpellDamageTooltip',
  'levelkey'
];
function filterExtraKeysFromSpecialValue (keyNames) {
  return keyNames.filter(a => keyWhiteList.indexOf(a) === -1);
}

// check upgrade paths and costs
function buildItemTree (t, data, cb) {
  var items = {};
  var recipes = {};
  var recipesByResult = {};
  var allItemNames = [];
  var allRecipeNames = [];
  t.test('item upgrade paths', function (t) {
    Object.keys(data).forEach(function (fileName) {
      var entry = data[fileName].DOTAItems;
      var itemNames = Object.keys(entry).filter(a => a !== 'values');
      itemNames.forEach(function (item) {
        var itemData = entry[item];
        var purchasable = itemData.values.ItemPurchasable !== '0';
        var itemCost = itemData.values.ItemCost;

        if (!itemCost && dotaItems[item]) {
          itemCost = dotaItems[item].values.ItemCost;
        }

        if (items[item]) {
          t.fail(item + ' was defined twice, not bothing with tree');
          return;
        }

        if (itemData.values.ItemRecipe === '1') {
          allRecipeNames.push(item);
          recipes[item] = itemData;
          t.notOk(recipesByResult[itemData.values.ItemResult], 'only 1 recipe per result');

          recipesByResult[itemData.values.ItemResult] = item;
        } else {
          allItemNames.push(item);
          items[item] = {
            baseCost: purchasable
              ? Number(itemCost)
              : 0,
            cost: purchasable
              ? Number(itemCost)
              : 0,
            // cost: Number(itemCost),
            totalCost: Number(itemCost),
            purchasable: purchasable,
            children: [], // array of string names of items that can be created with this item in only 1 jump
            recipes: [], // array of recipe objects that can create this item
            item: itemData
          };
        }
        // console.log(item, itemData);
        /*
        item_recipe_preemptive_3a { values:
         { ID: '3807',
           BaseClass: 'item_datadriven',
           ItemCost: '20000',
           ItemShopTags: '',
           ItemRecipe: '1',
           ItemResult: 'item_preemptive_3a',
           AbilityTextureName: 'item_recipe' },
        ItemRequirements:
         { values:
            { '01': 'item_preemptive_2a;item_upgrade_core_4',
              '02': 'item_preemptive_2b;item_upgrade_core_4' } } }
        */
      });
    });
    allItemNames.forEach(function (item) {
      var itemData = items[item];
      var itemNameParts = item.split('_');
      var itemRecipeParts = itemNameParts.concat();
      itemRecipeParts.splice(1, 0, 'recipe');
      var probableRecipeName = itemRecipeParts.join('_');

      var recipe = recipesByResult[item];
      var recipeData = recipe
        ? recipes[recipe]
        : null;

      if (!recipe || !recipeData.values.ItemCost) {
        recipe = recipe || probableRecipeName;
        if (dotaItems[recipe]) {
          recipeData = dotaItems[recipe];
        } else {
          // this is a base item, either from dota (gloves, etc..) or mod (upgrade_core, etc...)
          return;
        }
      }
      var requirements = recipeData.ItemRequirements.values;
      var numIndex = 1;
      requirements = Object.keys(requirements).map(function (index) {
        t.equal(Number(index), numIndex++, 'requirements indexes are in oreder for ' + item);
        return requirements[index].split(';').filter(a => !!a);
      });

      itemData.cost = Number.MAX_VALUE;
      itemData.totalCost = Number.MAX_VALUE;
      itemData.recipes = requirements;
      itemData.recipe = recipeData;
      itemData.purchasable = false;

      calculateCost(item);

      var upgradeCores = [];
      requirements.forEach(function (reqList) {
        var coreTier = null;
        reqList.forEach(function (reqItem) {
          var match = reqItem.match(/item_upgrade_core_?([0-9])?/);
          if (!match) {
            return;
          }
          coreTier = Number(match[1] || 1);
        });
        if (coreTier) {
          upgradeCores.push(coreTier);
        }
      });

      if (upgradeCores.length) {
        var minCore = upgradeCores.reduce((a, b) => Math.min(a, b), 5);
        // console.log(item, 'is made with tier', minCore, 'items');
        for (var i = minCore; i < 5; ++i) {
          t.notEqual(upgradeCores.indexOf(i), -1, item + ' has reverse compatible upgrade core ' + i);
        }
      }

      /*
        item_preemptive_3a { values:
           { ID: '3808',
             BaseClass: 'item_lua',
             AbilityBehavior: 'DOTA_ABILITY_BEHAVIOR_IMMEDIATE | DOTA_ABILITY_BEHAVIOR_NO_TARGET | DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL',
             AbilityTextureName: 'custom/preemptive_3a',
             ScriptFile: 'items/reflex/preemptive_purge.lua',
             FightRecapLevel: '1',
             MaxUpgradeLevel: '3',
             ItemBaseLevel: '3',
             AbilityManaCost: '0',
             AbilityCooldown: '20',
             AbilitySharedCooldown: 'reflex',
             AbilityCastPoint: '0.0',
             ItemCost: '13900',
             ItemShopTags: 'defense;support;mobility;hard_to_tag',
             ItemQuality: 'epic',
             ItemAliases: 'reflex;preemptive_3a;purge',
             ItemDisassembleRule: 'DOTA_ITEM_DISASSEMBLE_ALWAYS',
             ItemDeclarations: 'DECLARE_PURCHASES_TO_TEAMMATES | DECLARE_PURCHASES_IN_SPEECH | DECLARE_PURCHASES_TO_SPECTATORS' },
          AbilitySpecial:
           { values: {},
             '01': { values: [Object] },
             '02': { values: [Object] },
             '03': { values: [Object] },
             '04': { values: [Object] },
             '05': { values: [Object] } } }
      */
    });

    allItemNames.forEach(function (item) {
      if (!items[item]) {
        t.fail('missing item in items list ' + item);
        return;
      }
      t.equal(items[item].baseCost, items[item].cost, 'cost is set correctly in kv for ' + item);

      // this chunk of code will write the item costs in the file for you
      // useful...
      // if (items[item].baseCost !== items[item].cost) {
      //   var fileName = itemFileMap[item];
      //   var foundIt = false;
      //   var lines = fs.readFileSync(fileName, { encoding: 'utf8' })
      //     .split('\n')
      //     .map(function (line) {
      //       var parts = line.split(/[\s ]+/).filter(a => a && a.length);
      //       if (parts[0] === '"' + item + '"') {
      //         foundIt = true;
      //       }
      //       if (foundIt && parts[0] === '"ItemCost"') {
      //         // console.log(parts);
      //         line = line.replace('' + items[item].baseCost, items[item].cost);
      //         foundIt = false;
      //       }
      //       return line;
      //     })
      //     .join('\n');

      //   fs.writeFileSync(fileName, lines, { encoding: 'utf8' });
      // }
    });

    // output item costs in csv format (for haga usually)
    // allItemNames.forEach(function (item) {
    //   console.log([item, items[item].totalCost, items[item].cost].join(','));
    // });

    t.end();
    cb();
    // end of test
  });

  function calculateCost (item, skipChildren) {
    // console.log('Calculating the cost for', item);
    var itemData = items[item];
    var requirements = itemData.recipes;

    requirements.forEach(function (reqList) {
      var cost = Number(itemData.recipe.values.ItemCost);
      var totalCost = Number(itemData.recipe.values.ItemCost);
      reqList.forEach(function (reqItem) {
        if (item === reqItem) {
          // this item builds into itself
          // probably charge refreshing by rebuying recipe
          console.log(item, 'builds into itself');
          cost = Number.MAX_VALUE;
          totalCost = Number.MAX_VALUE;
          return;
        }
        var parentItem = items[reqItem];
        if (!parentItem) {
          if (!dotaItems[reqItem] && !recipes[reqItem]) {
            t.fail('Item ' + item + ' is made out of an unknown item ' + reqItem);
            return;
          }
          var baseItem = recipes[reqItem] || dotaItems[reqItem];
          var baseItemCost = Number(baseItem.values.ItemCost);
          parentItem = {
            baseCost: baseItemCost,
            cost: baseItemCost,
            totalCost: baseItemCost,
            item: baseItem,
            children: []
          };
          // console.log(item, 'is made with', parentItem);
        }
        if (parentItem.totalCost < parentItem.cost) {
          calculateCost(reqItem, true);
          if (parentItem.totalCost < parentItem.cost) {
            t.fail(reqItem + ' has invalid cost data');
          }
        }
        // if (item === 'item_sphere') {
        //   console.log('adding', parentItem);
        //   console.log('to', cost, totalCost);
        // }
        cost = cost + parentItem.cost;
        totalCost = totalCost + parentItem.totalCost;

        if (parentItem.children.indexOf(item) === -1) {
          parentItem.children.push(item);
        }
        if (cost > totalCost) {
          console.log('Bad cost data', reqItem, cost, totalCost, item, parentItem);
        }
      });
      if (cost > totalCost) {
        t.fail(['Bad cost data', cost, totalCost, item].join(' '));
      }
      if (cost < itemData.cost) {
        itemData.cost = cost;
      }
      if (totalCost < itemData.totalCost) {
        itemData.totalCost = totalCost;
      }
    });
    if (!skipChildren && itemData.children.length) {
      itemData.children.forEach(calculateCost);
    }
  }
}
