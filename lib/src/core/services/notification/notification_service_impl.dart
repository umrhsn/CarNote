// lib/src/core/services/notification/notification_service_impl.dart
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:car_note/src/core/services/notification/notification_service.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';

class NotificationServiceImpl implements NotificationService {
  @override
  Future<void> init() async {
    await AwesomeNotifications().initialize(
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

  @override
  void requestNotificationsPermission() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void scheduleDailyNotification(BuildContext context) {
    // Schedule for 9 AM
    Cron().schedule(
        Schedule.parse('0 9 * * *'), () => showDailyNotification(context));
    // Schedule for 9 PM
    Cron().schedule(
        Schedule.parse('0 21 * * *'), () => showDailyNotification(context));
  }

  @override
  Future<bool> showDailyNotification(BuildContext context) {
    return createNotification(
      id: 90,
      title: AppStrings.dailyNotificationTitle(context),
      body: AppStrings.dailyNotificationBody(context),
      backgroundColor: Colors.transparent,
      channelKey: AppStrings.notifChannelScheduledKey,
    );
  }

  @override
  void showAlarmingNotifications(
      BuildContext context, List<NotificationData> notifications) {
    for (final notification in notifications) {
      createNotification(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        backgroundColor: notification.backgroundColor,
        color: notification.color,
        channelKey: AppStrings.notifChannelBasicKey,
      );
    }
  }

  @override
  Future<bool> createNotification({
    required int id,
    required String title,
    required String body,
    Color? backgroundColor,
    Color? color,
    String? channelKey,
  }) async {
    try {
      return await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          category: NotificationCategory.Recommendation,
          backgroundColor: backgroundColor ?? Colors.transparent,
          channelKey: channelKey ?? AppStrings.notifChannelBasicKey,
          title: title,
          body: body,
          autoDismissible: false,
          badge: 0,
          color: color,
        ),
      );
    } catch (e) {
      debugPrint('Error creating notification: $e');
      return false;
    }
  }
}
