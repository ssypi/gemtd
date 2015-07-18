"use strict";

var gems = [];
var x = 0;
var keptGem = "";

function KeepGem(data) {
    for (var key in data) {
        if (data.hasOwnProperty(key)) {
            var value = data[key];
        }
    }
    $.Msg("Gem kept: ", value);

    ChangeGemNameColor(value, "green");
    keptGem = value;
    RemoveGemsFromArray();
}

function PlaceGem(data) {
    for (var key in data) {
        if (data.hasOwnProperty(key)) {
            var value = data[key];
        }
    }
    $.Msg("Gem placed: ", value);
    AddGemToArray(value);
    ChangeGemNameColor(value, "yellow");
}

function AddGemToArray(gem) {
    $.Msg("Adding gem to array: ", gem);
    //for (var i = 0)
    gems[x] = gem;
    x++;
    $.Msg("Size of gem array: ", gems.length);
}

function RemoveGemsFromArray() {
    for (var i = 0; i < gems.length; i++) {
        if (gems[i] != keptGem) {
            ChangeGemNameColor(gems[i], "red");
        }
    }
    gems.length = 0;
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



