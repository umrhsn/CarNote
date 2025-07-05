// lib/src/core/services/notification/notification_service.dart
import 'package:flutter/material.dart';

abstract class NotificationService {
  /// Initialize the notification service
  Future<void> init();

  /// Request notification permissions from the user
  void requestNotificationsPermission();

  /// Schedule daily notifications (morning and evening)
  void scheduleDailyNotification(BuildContext context);

  /// Show notifications for consumables that need attention
  void showAlarmingNotifications(
      BuildContext context, List<NotificationData> notifications);

  /// Show a single daily reminder notification
  Future<bool> showDailyNotification(BuildContext context);

  /// Create a custom notification
  Future<bool> createNotification({
    required int id,
    required String title,
    required String body,
    Color? backgroundColor,
    Color? color,
    String? channelKey,
  });
}

/// Data class for notification information
class NotificationData {
  final int id;
  final String title;
  final String body;
  final Color? backgroundColor;
  final Color? color;

  const NotificationData({
    required this.id,
    required this.title,
    required this.body,
    this.backgroundColor,
    this.color,
  });
}
