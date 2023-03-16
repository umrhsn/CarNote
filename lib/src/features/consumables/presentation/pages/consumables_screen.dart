import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/core/extensions/app_bar.dart';
import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/services/notifications/notifications_helper.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/custom_button.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumable_widget.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

class ConsumablesScreen extends StatefulWidget {
  const ConsumablesScreen({Key? key}) : super(key: key);

  @override
  State<ConsumablesScreen> createState() => _ConsumablesScreenState();
}

class _ConsumablesScreenState extends State<ConsumablesScreen> {
  final SharedPreferences _prefs = di.sl<SharedPreferences>();
  String? _scheduleTime;

  bool _getVisibilityStatus() {
    if (_prefs.getBool(AppStrings.prefsBoolVisible) == null) {
      _prefs.setBool(AppStrings.prefsBoolVisible, true);
    }
    bool visible = _prefs.getBool(AppStrings.prefsBoolVisible) ?? true;
    return visible;
  }

  bool _getNotificationStatus() {
    if (_prefs.getBool(AppStrings.prefsBoolNotif) == null) {
      _prefs.setBool(AppStrings.prefsBoolNotif, false);
    }
    bool notificationsSet = _prefs.getBool(AppStrings.prefsBoolNotif) ?? false;
    return notificationsSet;
  }

  String _getNotifScheduleTime() {
    if (_prefs.getString(AppStrings.prefsStringNotifScheduleTime) == null) {
      _prefs.setString(AppStrings.prefsStringNotifScheduleTime, '');
    }
    String scheduleTime = _prefs.getString(AppStrings.prefsStringNotifScheduleTime) ?? '';
    return scheduleTime;
  }

  @override
  void initState() {
    _getVisibilityStatus();
    _getNotificationStatus();
    // to be called only once
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => NotificationsHelper.showAlarmingNotifications(context));
    Admob.requestTrackingAuthorization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConsumableCubit cubit = ConsumableCubit.get(context);

    // TODO: consider handling if car and consumable are null
    Future<bool> onWillPop() async {
      for (int index = 0; index < Consumable.getCount(); index++) {
        Car? car = CarCubit.carBox.get(AppStrings.carBox);
        Consumable? consumable = ConsumableCubit.consumableBox.get(index);

        if (consumable != null) {
          bool currentKmHasValue = cubit.currentKmController.text.isNotEmpty || car!.currentKm != 0;
          bool lastChangedKmHasValue = cubit.lastChangedAtControllers[index].text.isNotEmpty ||
              consumable.lastChangedAt != 0;
          bool changeIntervalHasValue = cubit.changeIntervalControllers[index].text.isNotEmpty ||
              consumable.changeInterval != 0;
          bool changeKmHasValue =
              cubit.changeKmControllers[index].text.isNotEmpty || consumable.changeKm != 0;

          bool currentKmMatch =
              car!.currentKm.toString() == cubit.currentKmController.text.removeThousandSeparator();
          bool lastChangedKmMatch = consumable.lastChangedAt.toString() ==
              cubit.lastChangedAtControllers[index].text.removeThousandSeparator();
          bool changeIntervalMatch = consumable.changeInterval.toString() ==
              cubit.changeIntervalControllers[index].text.removeThousandSeparator();
          bool changeKmMatch = consumable.changeKm.toString() ==
              cubit.changeKmControllers[index].text.removeThousandSeparator();

          if (currentKmHasValue &&
              lastChangedKmHasValue &&
              changeIntervalHasValue &&
              changeKmHasValue) {
            if (!currentKmMatch || !lastChangedKmMatch || !changeIntervalMatch || !changeKmMatch) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const Icon(Icons.warning_rounded, color: Colors.red, size: 50),
                  title: const Text(AppStrings.changedDataMsg),
                  content: const Text(AppStrings.sureToExitMsg),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Future.sync(() => cubit.writeData(context)).then((value) => exit(0)),
                      child: Text(
                        AppStrings.saveData.toUpperCase(),
                        style: TextStyle(
                            color: context.isLight
                                ? AppColors.primarySwatchLight.shade100
                                : AppColors.primarySwatchDark.shade500),
                      ),
                    ),
                    TextButton(
                      onPressed: () => exit(0),
                      child: Text(
                        AppStrings.exitWithoutSaving.toUpperCase(),
                        style: TextStyle(
                            color: context.isLight
                                ? AppColors.primarySwatchLight.shade100
                                : AppColors.primarySwatchDark.shade500),
                      ),
                    ),
                  ],
                ),
              );
              return false;
            }
          }
        }
      }
      return true;
    }

    Column buildAppBarWidgets() => Column(
          children: [
            // TODO: add granular visibility to consumable widget
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_getVisibilityStatus() ? Icons.visibility : Icons.visibility_outlined),
                  onPressed: () => cubit.changeVisibility(),
                ),
                IconButton(
                  icon: Column(
                    children: [
                      Icon(_getNotificationStatus()
                          ? Icons.notifications_active
                          : Icons.notifications_outlined),
                      Text(
                        _getNotifScheduleTime(),
                        style: TextStyle(
                          fontSize: 8,
                          height: _getNotifScheduleTime() != '' ? 2 : 0,
                          fontFamily: AppStrings.fontFamilyCursedTimer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    NotificationsHelper.requestNotificationsPermission();
                    if (_getNotificationStatus()) {
                      NotificationsHelper.cancelNotification();
                      setState(() => _prefs.setString(AppStrings.prefsStringNotifScheduleTime, ''));
                      return;
                    }
                    setState(() async {
                      _scheduleTime = await NotificationsHelper.scheduleDailyNotification(context);
                      _prefs.setString(AppStrings.prefsStringNotifScheduleTime, _scheduleTime!);
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.translate),
                  onPressed: () {
                    if (AppLocalizations.of(context)!.isEnLocale) {
                      BlocProvider.of<LocaleCubit>(context).toArabic();
                    } else {
                      BlocProvider.of<LocaleCubit>(context).toEnglish();
                    }
                  },
                ),
              ],
            ),
            TextFormField(
              focusNode: cubit.currentKmFocus,
              cursorColor: AppColors.getAppBarTextFieldBorderAndLabelFocused(context),
              controller: cubit.currentKmController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                fillColor: AppColors.getAppBarTextFieldFill(context),
                floatingLabelStyle: TextStyle(
                  color: cubit.currentKmFocus.hasFocus
                      ? AppColors.getAppBarTextFieldBorderAndLabelFocused(context)
                      : AppColors.getAppBarTextFieldBorderAndLabel(context),
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.getAppBarTextFieldBorderAndLabel(context),
                  ),
                ),
                labelText: AppStrings.currentKmLabel,
                labelStyle: TextStyle(color: AppColors.getAppBarTextFieldLabel(context)),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(9),
                FilteringTextInputFormatter.digitsOnly,
                ThousandSeparatorInputFormatter(),
              ],
              onChanged: (_) {
                cubit.validateAllLastChangedKilometerFields();
                cubit.validateAllChangeKilometerFields();
              },
              onEditingComplete: () => cubit.validateAllChangeKilometerFields(),
              autovalidateMode: AutovalidateMode.always,
            ),
          ],
        );

    Expanded buildConsumablesList() => Expanded(
          flex: 1000,
          child: Scrollbar(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 15),
              child: ListView.separated(
                itemCount: Consumable.getCount(),
                itemBuilder: (context, index) =>
                    ConsumableWidget(index: index, name: AppStrings.consumables[index]),
                separatorBuilder: (context, index) => const Divider(thickness: 2),
              ),
            ),
          ),
        );

    Padding buildSaveButton() => Padding(
          padding: const EdgeInsetsDirectional.only(top: 10, end: 15),
          child: CustomButton(
            text: AppStrings.btnSave(context),
            btnEnabled: cubit.shouldEnableSaveButton(context),
            onPressed: () => cubit.writeData(context),
          ),
        );

    return BlocBuilder<ConsumableCubit, ConsumableState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.getPrimaryColor(context),
              toolbarHeight: 140,
              title: buildAppBarWidgets(),
            ).withBottomAdmobBanner(context),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildConsumablesList(),
                    const Spacer(),
                    buildSaveButton(),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
