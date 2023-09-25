import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/app_tutorial/app_tour_service.dart';
import 'package:car_note/src/core/services/notifications/notifications_helper.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/services/dialogs/dialog_helper.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/app_bar_current_kilometer_text_field.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/app_bar_icon_buttons_row.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/bottom_buttons.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumables_list_widget.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConsumablesScreen extends StatefulWidget {
  const ConsumablesScreen({Key? key}) : super(key: key);

  @override
  State<ConsumablesScreen> createState() => _ConsumablesScreenState();
}

class _ConsumablesScreenState extends State<ConsumablesScreen> {
  // ignore: prefer_final_fields
  List? _list = DatabaseHelper.consumableBox.get(AppStrings.consumableBox);

  @override
  void initState() {
    super.initState();
    NotificationsHelper.requestNotificationsPermission();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      NotificationsHelper.scheduleDailyNotification(context);
      NotificationsHelper.showAlarmingNotifications(context);
    });
    if (AppTourService.shouldBeginTour(
        prefsBoolKey: AppStrings.prefsBoolBeginConsumablesScreenTour)) {
      AppTourService.beginConsumablesScreenTour(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsumableCubit, ConsumableState>(
      builder: (context, state) {
        LocaleCubit localeCubit = LocaleCubit.get(context);
        ConsumableCubit consumableCubit = ConsumableCubit.get(context);

        return WillPopScope(
          onWillPop: () => DialogHelper.showOnWillPopDialogs(context),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 140,
              title: Column(
                children: [
                  AppBarIconButtonsRow(localeCubit: localeCubit, consumableCubit: consumableCubit),
                  AppBarCurrentKilometerTextField(consumableCubit: consumableCubit),
                ],
              ),
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConsumablesListWidget(list: _list),
                  const Spacer(),
                  BottomButtons(consumableCubit: consumableCubit),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
