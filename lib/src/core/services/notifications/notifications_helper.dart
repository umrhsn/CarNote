import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:car_note/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsHelper {
  static void requestNotificationsPermission() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) AwesomeNotifications().requestPermissionToSendNotifications();
    });
  }

  static Future<String> scheduleDailyNotification(BuildContext context) async {
    TimeOfDay? scheduleTime;

    await showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
            helpText: AppStrings.dailyNotificationTimePickerHelperText)
        .then((value) => scheduleTime = value);

    scheduleTime == null
        ? BotToast.showText(
            text: AppStrings.notificationTimeNotSet,
            duration: const Duration(seconds: 5),
          )
        : await AwesomeNotifications()
            .createNotification(
            content: NotificationContent(
              id: 90,
              category: NotificationCategory.Reminder,
              backgroundColor: Colors.transparent,
              channelKey: AppStrings.notifChannelScheduledKey,
              title: AppStrings.dailyNotificationTitle,
              body: AppStrings.dailyNotificationBody,
              autoDismissible: false,
              badge: 0,
            ),
            schedule: NotificationCalendar(
              hour: scheduleTime?.hour ?? 9,
              minute: scheduleTime?.minute ?? 0,
              preciseAlarm: true,
              allowWhileIdle: true,
            ),
          )
            .then(
            (value) {
              BotToast.showText(
                text: AppStrings.showNotificationTime(scheduleTime!),
                duration: const Duration(seconds: 5),
              );
              return di.sl<SharedPreferences>().setBool(AppStrings.prefsBoolNotif, true);
            },
          );
    return scheduleTime.toString().substring(
        scheduleTime.toString().indexOf('(') + 1, scheduleTime.toString().lastIndexOf(')'));
  }

  static void cancelNotification() async {
    await AwesomeNotifications().cancel(90).then((value) {
      BotToast.showText(text: AppStrings.dailyNotificationOff);
      return di.sl<SharedPreferences>().setBool(AppStrings.prefsBoolNotif, false);
    });
  }

  static void showAlarmingNotifications(BuildContext context) {
    ConsumableCubit cubit = di.sl<ConsumableCubit>();

    for (int index = 0; index < Consumable.getCount(); index++) {
      if (cubit.getChangeKmValidatingText(context, index).data != '' &&
          !cubit.isNormalText(index)) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: index,
            backgroundColor: cubit.getValidatingTextColor(context, index),
            channelKey: AppStrings.notifChannelBasicKey,
            title: AppStrings.consumables[index],
            body: '${cubit.getChangeKmValidatingText(context, index).data}',
            color: Colors.red,
            badge: 0,
          ),
        );
      }
    }
  }
}
