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
    keptGems[y] = value;
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
        case "gem_chipped_emerald":
            $("#ChippedEmerald").style.color = color;
            break;
        case "gem_chipped_amethyst":
            $("#ChippedAmethyst").style.color = color;
            break;
        case "gem_chipped_ruby":
            $("#ChippedRuby").style.color = color;
            break;
        case "gem_chipped_opal":
            $("#ChippedOpal").style.color = color;
            break;
        case "gem_chipped_aquamarine":
            $("#ChippedAquamarine").style.color = color;
            break;

        case "gem_flawed_ruby":
            $("#FlawedRuby").style.color = color;
            break;
        case "gem_flawed_sapphire":
            $("#FlawedSapphire").style.color = color;
            break;
        case "gem_flawed_diamond":
            $("#FlawedDiamond").style.color = color;
            break;
        case "gem_flawed_topaz":
            $("#FlawedTopaz").style.color = color;
            break;
        case "gem_flawed_amethyst":
            $("#FlawedAmethyst").style.color = color;
            break;
        case "gem_flawed_aquamarine":
            $("#FlawedAquamarine").style.color = color;
            break;
        case "gem_flawed_opal":
            $("#FlawedOpal").style.color = color;
            break;
        case "gem_flawed_emerald":
            $("#FlawedEmerald").style.color = color;
            break;

        case "gem_normal_ruby":
            $("#NormalRuby").style.color = color;
            break;
        case "gem_normal_sapphire":
            $("#NormalSapphire").style.color = color;
            break;
        case "gem_normal_diamond":
            $("#NormalDiamond").style.color = color;
            break;
        case "gem_normal_topaz":
            $("#NormalTopaz").style.color = color;
            break;
        case "gem_normal_amethyst":
            $("#NormalAmethyst").style.color = color;
            break;
        case "gem_normal_aquamarine":
            $("#NormalAquamarine").style.color = color;
            break;
        case "gem_normal_opal":
            $("#NormalOpal").style.color = color;
            break;
        case "gem_normal_emerald":
            $("#NormalEmerald").style.color = color;
            break;

        case "gem_flawless_ruby":
            $("#FlawlessRuby").style.color = color;
            break;
        case "gem_flawless_sapphire":
            $("#FlawlessSapphire").style.color = color;
            break;
        case "gem_flawless_diamond":
            $("#FlawlessDiamond").style.color = color;
            break;
        case "gem_flawless_topaz":
            $("#FlawlessTopaz").style.color = color;
            break;
        case "gem_flawless_amethyst":
            $("#FlawlessAmethyst").style.color = color;
            break;
        case "gem_flawless_aquamarine":
            $("#FlawlessAquamarine").style.color = color;
            break;
        case "gem_flawless_opal":
            $("#FlawlessOpal").style.color = color;
            break;
        case "gem_flawless_emerald":
            $("#FlawlessEmerald").style.color = color;
            break;

        case "gem_perfect_ruby":
            $("#PerfectRuby").style.color = color;
            break;
        case "gem_perfect_sapphire":
            $("#PerfectSapphire").style.color = color;
            break;
        case "gem_perfect_diamond":
            $("#PerfectDiamond").style.color = color;
            break;
        case "gem_perfect_topaz":
            $("#PerfectTopaz").style.color = color;
            break;
        case "gem_perfect_amethyst":
            $("#PerfectAmethyst").style.color = color;
            break;
        case "gem_perfect_aquamarine":
            $("#PerfectAquamarine").style.color = color;
            break;
        case "gem_perfect_opal":
            $("#PerfectOpal").style.color = color;
            break;
        case "gem_perfect_emerald":
            $("#PerfectEmerald").style.color = color;
            break;

        default:
            $.Msg("No gem found with gem: ", value);
    }
}

function ButtonPressed() {
    $.Msg("Button pressed");
    $("#GemGuideUi").ToggleClass("Visible");
    $("#Button").ToggleClass("onClick");
}

GameEvents.Subscribe("keep_gem", KeepGem);
GameEvents.Subscribe("place_gem", PlaceGem);
GameEvents.Subscribe("remove_gem", RemoveGemAfterCombine);



