// lib/src/core/services/notifications/notifications_helper.dart
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/services/notification/notification_service.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:car_note/injection_container.dart' as di;

class NotificationsHelper {
  static final NotificationService _notificationService =
      di.sl<NotificationService>();
  static bool _isShowingNotifications = false; // Flag to prevent infinite loops
  static DateTime? _lastNotificationTime;
  static const Duration _minimumNotificationInterval =
      Duration(seconds: 5); // Minimum time between notifications

  static Future<void> init() async {
    await _notificationService.init();
  }

  static void requestNotificationsPermission() {
    _notificationService.requestNotificationsPermission();
  }

  static void scheduleDailyNotification(BuildContext context) {
    _notificationService.scheduleDailyNotification(context);
  }

  static Future<bool> showDailyNotification(BuildContext context) {
    return _notificationService.showDailyNotification(context);
  }

  static void showAlarmingNotifications(
      BuildContext context, ConsumableCubit cubit) {
    // Prevent infinite loops
    if (_isShowingNotifications) {
      debugPrint(
          "🔔 NotificationsHelper: Already showing notifications, skipping");
      return;
    }

    // Rate limiting - don't show notifications too frequently
    final now = DateTime.now();
    if (_lastNotificationTime != null &&
        now.difference(_lastNotificationTime!) < _minimumNotificationInterval) {
      debugPrint(
          "🔔 NotificationsHelper: Too soon since last notification, skipping");
      return;
    }

    _isShowingNotifications = true;
    _lastNotificationTime = now;

    debugPrint(
        "🔔 NotificationsHelper: Starting to check for alarming notifications");
    debugPrint("🔔 Consumable count: ${cubit.consumableCount}");

    try {
      for (int index = 0; index < cubit.consumableCount; index++) {
        final item = cubit.consumables[index];

        debugPrint("🔔 Checking consumable $index: ${item.name}");

        // Check if this consumable needs a notification
        bool shouldNotify = false;

        // Check if all required fields are filled
        if (cubit.lastChangedAtControllers[index].text.isNotEmpty &&
            cubit.changeIntervalControllers[index].text.isNotEmpty &&
            cubit.remainingKmControllers[index].text.isNotEmpty) {
          // Check if it's not normal (needs attention)
          if (!cubit.isNormalText(index)) {
            shouldNotify = true;
          }

          // Also check for consider text (exactly at change point)
          if (cubit.isConsiderText(index)) {
            shouldNotify = true;
          }
        }

        debugPrint("🔔 Should notify for $index: $shouldNotify");

        if (shouldNotify) {
          String remainingKm = LocaleCubit.currentLangCode == AppStrings.en
              ? cubit.remainingKmControllers[index].text.isNotEmpty
                  ? cubit.remainingKmControllers[index].text
                  : '0'
              : cubit.remainingKmControllers[index].text.isNotEmpty
                  ? cubit.remainingKmControllers[index].text.toArabicNumerals()
                  : '0'.toArabicNumerals();

          String body = cubit.isErrorText(index)
              ? '${AppStrings.remainingKmErrorLabel(context)} $remainingKm ${AppStrings.km(context)}'
              : '$remainingKm ${AppStrings.km(context)} ${AppStrings.remaining(context)}';

          Color notificationColor = AppColors.getValidatingTextColor(context,
              cubit: cubit, index: index);

          debugPrint("🔔 Creating notification for: ${item.name}");

          _notificationService.createNotification(
            id: index,
            title: item.name,
            body: body,
            backgroundColor: notificationColor,
            color: notificationColor,
          );
        }
      }
    } finally {
      // Always reset the flag
      _isShowingNotifications = false;
    }

    debugPrint("🔔 NotificationsHelper: Finished checking notifications");
  }

  static Future<bool> createNotification({
    required int id,
    required String title,
    required String body,
    Color? backgroundColor,
    Color? color,
  }) {
    return _notificationService.createNotification(
      id: id,
      title: title,
      body: body,
      backgroundColor: backgroundColor,
      color: color,
    );
  }

  // Reset the rate limiting (useful for testing or when user explicitly requests notifications)
  static void resetRateLimit() {
    _lastNotificationTime = null;
    _isShowingNotifications = false;
  }
}
