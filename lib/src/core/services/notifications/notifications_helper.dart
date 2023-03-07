import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:car_note/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsHelper {
  static void scheduleDailyNotification(BuildContext context) async {
    TimeOfDay? scheduleTime;

    await showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
            helpText: AppStrings.dailyNotificationTimePickerHelperText)
        .then(
      (value) {
        debugPrint('value = $value');
        scheduleTime = value;
        debugPrint('scheduleTime = $scheduleTime');
      },
    );

    scheduleTime == null
        ? null
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
              ),
              schedule: NotificationCalendar(
                hour: scheduleTime?.hour ?? 9,
                minute: scheduleTime?.minute ?? 0,
                preciseAlarm: true,
                allowWhileIdle: true,
              ),
            )
            .then(
              (value) => di.sl<SharedPreferences>().setBool(AppStrings.prefsBoolNotification, true),
            );
  }

  static void cancelNotification() async => await AwesomeNotifications()
      .cancel(90)
      .then((value) => di.sl<SharedPreferences>().setBool(AppStrings.prefsBoolNotification, false));

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
          ),
        );
      }
    }
  }
}
