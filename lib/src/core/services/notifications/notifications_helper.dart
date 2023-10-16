import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:car_note/injection_container.dart' as di;

class NotificationsHelper {
  init() {
    AwesomeNotifications().initialize(
      'resource://drawable/icon',
      [
        NotificationChannel(
          channelKey: AppStrings.notifChannelBasicKey,
          channelName: AppStrings.notifChannelBasicName,
          channelDescription: AppStrings.notifChannelBasicDescription,
          ledColor: AppColors.primaryLight,
          importance: NotificationImportance.High,
        ),
        NotificationChannel(
          channelKey: AppStrings.notifChannelScheduledKey,
          channelName: AppStrings.notifChannelScheduledName,
          channelDescription: AppStrings.notifChannelScheduledDescription,
          ledColor: AppColors.primaryLight,
          importance: NotificationImportance.High,
        ),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: AppStrings.notifChannelBasicGroupKey,
          channelGroupName: AppStrings.notifChannelBasicGroupName,
        ),
        NotificationChannelGroup(
          channelGroupKey: AppStrings.notifChannelScheduledGroupKey,
          channelGroupName: AppStrings.notifChannelScheduledGroupName,
        ),
      ],
    );
  }

  static void requestNotificationsPermission() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) AwesomeNotifications().requestPermissionToSendNotifications();
    });
  }

  // FIXME: works only if app is minimized, not closed
  static void scheduleDailyNotification(BuildContext context) {
    Cron().schedule(Schedule.parse('0 9 * * *'), () => NotificationsHelper._showDailyNotification(context));
    Cron().schedule(Schedule.parse('0 21 * * *'), () => NotificationsHelper._showDailyNotification(context));
  }

  static Future<bool> _showDailyNotification(BuildContext context) {
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
      Consumable item = DatabaseHelper.consumableBox.get(AppKeys.consumableBox)![index];

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
            backgroundColor: AppColors.getValidatingTextColor(context, cubit: cubit, index: index),
            channelKey: AppStrings.notifChannelBasicKey,
            title: item.name,
            body: cubit.isErrorText(index)
                ? '${AppStrings.remainingKmErrorLabel(context)} $remainingKm ${AppStrings.km(context)}'
                : '$remainingKm ${AppStrings.km(context)} ${AppStrings.remaining(context)}',
            color: AppColors.getValidatingTextColor(context, cubit: cubit, index: index),
            badge: 0,
          ),
        );
      }
    }
  }
}
