/*global $, GameEvents*/

var notification = {};

(function (notification) {
    "use strict";

    function showNotification(data) {
        var notification = data.notification;
        $.Msg("Show notification: ", notification);
        var notificationText = $("#Notification");
        notificationText.text = notification;
        $.GetContextPanel().SetHasClass("NotificationText", true);
        $.Schedule(5, function () {
            $.Msg("Hiding notification");
            $.GetContextPanel().SetHasClass("NotificationText", false);
        });
    }

    GameEvents.Subscribe("show_notification", showNotification);

}(notification || {}));