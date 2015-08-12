/*global $, GameEvents*/

var error_message = {};

(function (error) {
    "use strict";

    function showErrorMessage(data) {
        var error_message = data.error;
        $.Msg("Show error message: ", error_message);
        var errorMessage = $("#Error");
        errorMessage.text = error_message;
        Game.EmitSound( "ui_general_deny" );
        $.GetContextPanel().SetHasClass("ErrorMessage", true);
        $.Schedule(1.5, function () {
            $.Msg("Hiding error message");
            $.GetContextPanel().SetHasClass("ErrorMessage", false);
        });
        Game.EmitSound( "General.Cancel" );
    }

    GameEvents.Subscribe("show_error_message", showErrorMessage);

}(error_message || {}));