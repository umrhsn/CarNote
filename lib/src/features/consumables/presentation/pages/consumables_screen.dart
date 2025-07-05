// lib/src/features/consumables/presentation/pages/consumables_screen.dart
import 'package:car_note/src/core/services/app_tutorial/app_tour_service.dart';
import 'package:car_note/src/core/services/notification/notifications_helper.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_ids.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/services/dialogs/dialog_helper.dart';
import 'package:car_note/src/core/widgets/ads/banner_ad_widget.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/app_bar_current_kilometer_text_field.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/app_bar_icon_buttons_row.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/bottom_buttons.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumables_list_widget.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

class ConsumablesScreen extends StatefulWidget {
  const ConsumablesScreen({super.key});

  @override
  State<ConsumablesScreen> createState() => _ConsumablesScreenState();
}

class _ConsumablesScreenState extends State<ConsumablesScreen> {
  bool _canPop = false;
  bool _notificationsInitialized = false;

  @override
  void initState() {
    super.initState();

    debugPrint("🔔 ConsumablesScreen: Initializing");

    // Initialize notifications ONCE
    if (!_notificationsInitialized) {
      _notificationsInitialized = true;
      NotificationsHelper.requestNotificationsPermission();

      // Schedule daily notifications
      NotificationsHelper.scheduleDailyNotification(context);

      // Show initial notifications after a delay to ensure everything is loaded
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          final consumableCubit = ConsumableCubit.get(context);
          debugPrint("🔔 ConsumablesScreen: Initial notification trigger");
          NotificationsHelper.showAlarmingNotifications(
              context, consumableCubit);
        }
      });
    }

    // Initialize app tour if needed
    if (AppTourService.shouldBeginTour(
        prefsBoolKey: AppKeys.prefsBoolBeginConsumablesScreenTour)) {
      AppTourService.beginConsumablesScreenTour(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConsumableCubit, ConsumableState>(
      listener: (context, state) {
        // Only trigger notifications on specific state changes that indicate data was saved
        if (state is DataSaved) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              final consumableCubit = ConsumableCubit.get(context);
              debugPrint(
                  "🔔 ConsumablesScreen: Data saved, triggering notifications");
              NotificationsHelper.showAlarmingNotifications(
                  context, consumableCubit);
            }
          });
        }
      },
      child: BlocBuilder<ConsumableCubit, ConsumableState>(
        builder: (context, state) {
          LocaleCubit localeCubit = LocaleCubit.get(context);
          ConsumableCubit consumableCubit = ConsumableCubit.get(context);

          return PopScope(
            canPop: _canPop,
            onPopInvoked: (didPop) {
              if (DialogHelper.showOnWillPopDialogs(context, consumableCubit)) {
                setState(() => _canPop = true);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: AppDimens.appBarHeight140,
                title: Column(
                  children: [
                    AppBarIconButtonsRow(
                        localeCubit: localeCubit,
                        consumableCubit: consumableCubit),
                    AppBarCurrentKilometerTextField(
                        consumableCubit: consumableCubit),
                  ],
                ),
              ),
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConsumablesListWidget(consumableCubit: consumableCubit),
                    const Spacer(),
                    BottomButtons(consumableCubit: consumableCubit),
                    const SizedBox(height: AppDimens.sizedBox15),
                    const BannerAdWidget(
                        androidAdUnitId: AppIDs.adUnitConsumables),

                    // Debug button for testing notifications (remove in production)
                    if (kDebugMode)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint("🔔 Debug: Manual notification trigger");
                            consumableCubit.triggerNotifications(context);
                          },
                          child: const Text("Test Notifications"),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
