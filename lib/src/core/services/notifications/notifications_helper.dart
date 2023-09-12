import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:car_note/injection_container.dart' as di;

class NotificationsHelper {
  static void requestNotificationsPermission() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) AwesomeNotifications().requestPermissionToSendNotifications();
    });
  }

  static Future<bool> showDailyNotification(BuildContext context) {
    return AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 90,
        category: NotificationCategory.Recommendation,
        backgroundColor: Colors.transparent,
        channelKey: AppStrings.notifChannelScheduledKey,
        title: AppStrings.dailyNotificationTitle(context),
        body: AppStrings.dailyNotificationBody(context),
        autoDismissible: false,
        badge: 0,
      ),
    );
  }

  static void showAlarmingNotifications(BuildContext context) {
    ConsumableCubit cubit = di.sl<ConsumableCubit>();

    for (int index = 0; index < Consumable.getCount(); index++) {
      Consumable item = DatabaseHelper.consumableBox.get(AppStrings.consumableBox)![index];

      if (cubit.lastChangedAtControllers[index].text.isNotEmpty &&
              cubit.changeIntervalControllers[index].text.isNotEmpty &&
              cubit.remainingKmControllers[index].text.isNotEmpty &&
              !cubit.isNormalText(index) ||
          cubit.isConsiderText(index)) {
        String remainingKm = LocaleCubit.currentLangCode == AppStrings.en
            ? cubit.remainingKmControllers[index].text != ''
                ? cubit.remainingKmControllers[index].text
                : '0'
            : cubit.remainingKmControllers[index].text != ''
                ? cubit.remainingKmControllers[index].text.toArabicNumerals()
                : '0'.toArabicNumerals();
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: index,
            backgroundColor: cubit.getValidatingTextColor(context, index),
            channelKey: AppStrings.notifChannelBasicKey,
            title: item.name,
            body: cubit.isErrorText(index)
                ? '${AppStrings.remainingKmErrorLabel(context)} $remainingKm ${AppStrings.km(context)}'
                : '$remainingKm ${AppStrings.km(context)} ${AppStrings.remaining(context)}',
            color: Colors.red,
            badge: 0,
          ),
        );
      }
    }
  }
}
