"use strict";

var placedGems = [];
var keptGems = [];
var x = 0;
var y = 0;
var keptGem = "";

// Adding kept gem
function KeepGem(data) {
    for (var key in data) {
        if (data.hasOwnProperty(key)) {
            var value = data[key];
        }
    }
    $.Msg("Gem kept: ", value);

    ChangeGemNameColor(value, "green");
    keptGem = value;
    keptGems[y]  = value;
    y++;
    RemoveGemsFromPlacedGems();
}

// Adding placed gem in this turn
function PlaceGem(data) {
    for (var key in data) {
        if (data.hasOwnProperty(key)) {
            var value = data[key];
        }
    }
    $.Msg("Gem placed: ", value);
    var gemAlreadyKept = false;
    for (var i = 0; i < keptGems.length; i++) {
        if (keptGems[i] == value) {
            gemAlreadyKept = true;
        }
    }
    if (!gemAlreadyKept) {
        ChangeGemNameColor(value, "yellow");
        $.Msg("Adding gem to array: ", value);
        placedGems[x] = value;
        x++;
        $.Msg("Size of gem array: ", placedGems.length);
    }
}

// Remove gems which were not kept this turn
function RemoveGemsFromPlacedGems() {
    for (var i = 0; i < placedGems.length; i++) {
        if (placedGems[i] != keptGem) {
            ChangeGemNameColor(placedGems[i], "red");
        }
    }
    placedGems.length = 0;
    x = 0;
}

// Removes gem after combine
function RemoveGemAfterCombine(data) {
    for (var key in data) {
        if (data.hasOwnProperty(key)) {
            var gem = data[key];
        }
    }
    $.Msg("Removing gem after combine: ", gem);
    $.Msg("Kept gems size before remove: ", keptGems.length);

    for (var i = 0; i < keptGems.length; i++) {
        if (keptGems[i] == gem) {
            keptGems.splice(i, 1);
            $.Msg("Kept gems size after remove: ", keptGems.length);
            break;
        }
    }
    var multipleGemsKept = false;
    for (var j = 0; j < keptGems.length; j++) {
        if (keptGems[j] == gem) {
            multipleGemsKept = true;
            break;
        }
    }
    if (!multipleGemsKept) {
        ChangeGemNameColor(gem, "red");
    }
}

function ChangeGemNameColor(value, color) {
    switch (value) {
        case "gem_chipped_sapphire":
            $("#ChippedSapphire").style.color = color;
            break;

        case "gem_chipped_diamond":
            $("#ChippedDiamond").style.color = color;
            break;

        case "gem_chipped_topaz":
            $("#ChippedTopaz").style.color = color;
            break;

        default:
            $.Msg("No gem found with gem: ", value);
    }
}

GameEvents.Subscribe("keep_gem", KeepGem);
GameEvents.Subscribe("place_gem", PlaceGem);
GameEvents.Subscribe("remove_gem", RemoveGemAfterCombine);



