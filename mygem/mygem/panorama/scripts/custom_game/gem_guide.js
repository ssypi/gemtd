/*global $, GameEvents*/

var myGem = {};

(function (myGem) {
    "use strict";

    var placedGems = {};
    var ownedGems = {};
    var lastKeptGem = "";

// Adding kept gem
    function keepGem(data) {
        var gemName = data.gemName;
        $.Msg("Gem kept: ", gemName);

        if (!ownedGems[gemName]) {
            ownedGems[gemName] = 1;
        }
        placedGems = {};
        updateUi();
    }

    function updatePlacedGems() {
        for (var gem in placedGems) {
            if (placedGems.hasOwnProperty(gem)) {
                $.Msg("Placed gem " + gem + " value: " + placedGems[gem]);
                if (ownedGems[gem] < 2) {
                    changeGemNameColor(gem, "yellow");
                }
            }
        }
    }

    function updateUi() {
        var allGems = $("#recipes").FindChildrenWithClassTraverse("Gem");

        $.Msg("All gems count: ", allGems.length);

        for (var i = 0; i < allGems.length; i++) {
            $.Msg("asd: ", allGems[i]);
            allGems[i].style.color = "red";
        }

        updatePlacedGems();


        for (var gem in ownedGems) {
            if (ownedGems.hasOwnProperty(gem)) {
                $.Msg("Owned gem " + gem + " value: " + ownedGems[gem]);
                if (!ownedGems[gem]) {
                    //changeGemNameColor(gem, "red");
                } else {
                    changeGemNameColor(gem, "green");
                }
            }
        }
    }

    function addSpecial(data) {
        var gemName = data.gemName;
        if (ownedGems[gemName]) {
            ownedGems[gemName]++;
        } else {
            ownedGems[gemName] = 1;
        }
        updateUi();
    }

// Adding placed gem in this turn
    function placeGem(data) {
        var gemName = data.gemName;
        $.Msg("Gem placed: ", gemName);

        if (!placedGems[gemName]) {
            placedGems[gemName] = 1;
        } else {
            placedGems[gemName]++;
        }

        if (!ownedGems[gemName]) {
            ownedGems[gemName] = 1;
        } else {
            ownedGems[gemName]++;
        }
        updatePlacedGems();
    }

    function removeGem(data) {
        var gemName = data.gemName;
        $.Msg("Removing gem after combine: ", gemName);
        $.Msg("Kept gems size before remove: ", ownedGems.length);

        if (ownedGems[gemName]) {
            ownedGems[gemName]--;
        } else {
            ownedGems[gemName] = 0;
        }
        updateUi();
    }

    function changeGemNameColor(value, color) {
        $.Msg("Chaning " + value + " to " + color);
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

            case "gem_special_silver":
                $("#Silver").style.color = color;
                break;
            case "gem_special_malachite":
                $("#Malachite").style.color = color;
                break;
            case "gem_special_star_ruby":
                $("#StarRuby").style.color = color;
                break;
            case "gem_special_black_opal":
                $("#BlackOpal").style.color = color;
                break;
            case "gem_special_blood_stone":
                $("#BloodStone").style.color = color;
                break;
            case "gem_special_dark_emerald":
                $("#DarkEmerald").style.color = color;
                break;
            case "gem_special_gold":
                $("#Gold").style.color = color;
                break;
            case "gem_special_jade":
                $("#Jade").style.color = color;
                break;
            case "gem_special_pink_diamond":
                $("#PinkDiamond").style.color = color;
                break;
            case "gem_special_red_crystal":
                $("#RedCrystal").style.color = color;
                break;
            case "gem_special_uranium_238":
                $("#Uranium238").style.color = color;
                break;
            case "gem_special_yellow_sapphire":
                $("#YellowSapphire").style.color = color;
                break;
            case "gem_special_paraiba_tourmaline":
                $("#ParaibaTourmaline").style.color = color;
                break;

            default:
                $.Msg("No gem found with gem: ", value);
        }
    }


    GameEvents.Subscribe("keep_gem", keepGem);
    GameEvents.Subscribe("place_gem", placeGem);
    GameEvents.Subscribe("remove_gem", removeGem);
    GameEvents.Subscribe("add_combined_gem", keepGem);
    GameEvents.Subscribe("add_special_gem", addSpecial);

    myGem.buttonPressed = function () {
        $.Msg("Button pressed");
        $("#GemGuideUi").ToggleClass("Visible");
        $("#Button").ToggleClass("onClick");
    };

}(myGem || {}));
