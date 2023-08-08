import 'package:admob_flutter/admob_flutter.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/file_creator/file_creator.dart';
import 'package:car_note/src/core/services/notifications/notifications_helper.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/custom_button.dart';
import 'package:car_note/src/core/widgets/custom_icon_button.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumable_widget.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

class ConsumablesScreen extends StatefulWidget {
  const ConsumablesScreen({Key? key}) : super(key: key);

  @override
  State<ConsumablesScreen> createState() => _ConsumablesScreenState();
}

class _ConsumablesScreenState extends State<ConsumablesScreen> {
  final SharedPreferences _prefs = di.sl<SharedPreferences>();

  // String? _scheduleTime;

  bool _getVisibilityStatus() {
    if (_prefs.getBool(AppStrings.prefsBoolDetailedModeOn) == null) {
      _prefs.setBool(AppStrings.prefsBoolDetailedModeOn, true);
    }
    bool visible = _prefs.getBool(AppStrings.prefsBoolDetailedModeOn) ?? true;
    return visible;
  }

  // bool _getNotificationStatus() {
  //   if (_prefs.getBool(AppStrings.prefsBoolNotif) == null) {
  //     _prefs.setBool(AppStrings.prefsBoolNotif, false);
  //   }
  //   bool notificationsSet = _prefs.getBool(AppStrings.prefsBoolNotif) ?? false;
  //   return notificationsSet;
  // }

  // String _getNotifScheduleTime() {
  //   if (_prefs.getString(AppStrings.prefsStringNotifScheduleTime) == null) {
  //     _prefs.setString(AppStrings.prefsStringNotifScheduleTime, '');
  //   }
  //   String scheduleTime = _prefs.getString(AppStrings.prefsStringNotifScheduleTime) ?? '';
  //   return scheduleTime;
  // }

  @override
  void initState() {
    super.initState();
    _getVisibilityStatus();
    // _getNotificationStatus();
    // to be called only once
    NotificationsHelper.requestNotificationsPermission();
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => NotificationsHelper.showAlarmingNotifications(context));
    Admob.requestTrackingAuthorization();
  }

  @override
  Widget build(BuildContext context) {
    LocaleCubit localeCubit = LocaleCubit.get(context);
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    // TODO: uncomment when onWillPop is functional
    // void showExitDialog() {
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       icon: const Icon(Icons.warning_rounded, color: Colors.red, size: 50),
    //       title: Text(AppStrings.changedDataMsg(context)),
    //       content: Text(AppStrings.sureToExitMsg(context)),
    //       actions: [
    //         TextButton(
    //           onPressed: () async => DatabaseHelper.writeConsumablesData(context)
    //               .then((value) => SystemNavigator.pop()),
    //           child: Text(
    //             AppStrings.saveData(context),
    //             style: TextStyle(
    //                 color: context.isLight
    //                     ? AppColors.primarySwatchLight.shade100
    //                     : AppColors.primarySwatchDark.shade500),
    //           ),
    //         ),
    //         TextButton(
    //           onPressed: () => SystemNavigator.pop(),
    //           child: Text(
    //             AppStrings.exitWithoutSaving(context),
    //             style: TextStyle(
    //                 color: context.isLight
    //                     ? AppColors.primarySwatchLight.shade100
    //                     : AppColors.primarySwatchDark.shade500),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // FIXME: malfunctioning
    // Future<bool> onWillPop() async {
    //   for (int index = 0; index < Consumable.getCount(); index++) {
    //     Car? car = DatabaseHelper.carBox.get(AppStrings.carBox);
    //     Consumable? consumable =
    //         DatabaseHelper.consumableBox.get(AppStrings.consumablesKey)![index];
    //
    //     if (Consumable.count !=
    //         DatabaseHelper.consumableBox.get(AppStrings.consumablesKey)!.length) {
    //       showExitDialog();
    //       return false;
    //     }
    //
    //     if (int.parse(consumableCubit.currentKmController.text.removeThousandSeparator()) !=
    //         car!.currentKm) {
    //       showExitDialog();
    //       return false;
    //     }
    //
    //     if (consumable == null) {
    //       if (consumableCubit.lastChangedAtControllers[index].text.isNotEmpty ||
    //           consumableCubit.changeIntervalControllers[index].text.isNotEmpty ||
    //           consumableCubit.remainingKmControllers[index].text.isNotEmpty) {
    //         showExitDialog();
    //         return false;
    //       }
    //     }
    //
    //     if (consumable != null) {
    //       if ((consumable.lastChangedAt == 0 &&
    //               consumableCubit.lastChangedAtControllers[index].text.isNotEmpty) ||
    //           (consumable.changeInterval == 0 &&
    //               consumableCubit.changeIntervalControllers[index].text.isNotEmpty) ||
    //           (consumable.remainingKm == 0 &&
    //               consumableCubit.remainingKmControllers[index].text.isNotEmpty)) {
    //         showExitDialog();
    //         return false;
    //       }
    //
    //       if ((consumableCubit.lastChangedAtControllers[index].text.isEmpty &&
    //               consumable.lastChangedAt != 0) ||
    //           consumableCubit.changeIntervalControllers[index].text.isEmpty &&
    //               consumable.changeInterval != 0 ||
    //           consumableCubit.remainingKmControllers[index].text.isEmpty &&
    //               consumable.remainingKm != 0) {
    //         showExitDialog();
    //         return false;
    //       }
    //
    //       if ((consumableCubit.lastChangedAtControllers[index].text.isNotEmpty &&
    //               int.parse(consumableCubit.lastChangedAtControllers[index].text
    //                       .removeThousandSeparator()) !=
    //                   consumable.lastChangedAt) ||
    //           (consumableCubit.changeIntervalControllers[index].text.isNotEmpty &&
    //               int.parse(consumableCubit.changeIntervalControllers[index].text
    //                       .removeThousandSeparator()) !=
    //                   consumable.changeInterval) ||
    //           (consumableCubit.remainingKmControllers[index].text.isNotEmpty &&
    //               int.parse(consumableCubit.remainingKmControllers[index].text
    //                       .removeThousandSeparator()) !=
    //                   consumable.remainingKm)) {
    //         showExitDialog();
    //         return false;
    //       }
    //     }
    //   }
    //   return true;
    // }

    Column buildAppBarWidgets() => Column(
          children: [
            // TODO: add granular visibility to consumable widget
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_getVisibilityStatus() ? Icons.visibility : Icons.visibility_outlined),
                  onPressed: () => consumableCubit.changeVisibility(context),
                ),
                // FIXME: notification only shows once instead of daily
                // IconButton(
                //   icon: Column(
                //     children: [
                //       Icon(_getNotificationStatus()
                //           ? Icons.notifications_active
                //           : Icons.notifications_outlined),
                //       Text(
                //         _getNotifScheduleTime(),
                //         style: TextStyle(
                //           fontSize: 8,
                //           height: _getNotifScheduleTime() != '' ? 2 : 0,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ],
                //   ),
                //   onPressed: () {
                //     NotificationsHelper.requestNotificationsPermission();
                //     if (_getNotificationStatus()) {
                //       NotificationsHelper.cancelNotification(context);
                //       setState(() => _prefs.setString(AppStrings.prefsStringNotifScheduleTime, ''));
                //       return;
                //     }
                //     setState(() async {
                //       _scheduleTime = await NotificationsHelper.scheduleDailyNotification(context);
                //       _prefs.setString(AppStrings.prefsStringNotifScheduleTime, _scheduleTime!);
                //     });
                //   },
                // ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.language),
                  onPressed: () => AppLocalizations.of(context)!.isEnLocale
                      ? localeCubit.toArabic(context)
                      : localeCubit.toEnglish(context),
                ),
                IconButton(
                  icon: const Icon(Icons.upload_file_rounded),
                  onPressed: () => FileCreator.writeDataToFile().then((value) {
                    return BotToast.showText(
                        duration: Duration(seconds: value == true ? 7 : 2),
                        text: value == true
                            ? AppStrings.fileCreated(context)
                            : AppStrings.fileNotCreated(context));
                  }),
                ),
              ],
            ),
            TextFormField(
              focusNode: consumableCubit.currentKmFocus,
              cursorColor: AppColors.getAppBarTextFieldBorderAndLabelFocused(context),
              controller: consumableCubit.currentKmController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                fillColor: AppColors.getAppBarTextFieldFill(context),
                floatingLabelStyle: TextStyle(
                  color: consumableCubit.currentKmFocus.hasFocus
                      ? AppColors.getAppBarTextFieldBorderAndLabelFocused(context)
                      : AppColors.getAppBarTextFieldBorderAndLabel(context),
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.getAppBarTextFieldBorderAndLabel(context),
                  ),
                ),
                labelText: AppStrings.currentKmLabel(context),
                labelStyle: TextStyle(color: AppColors.getAppBarTextFieldLabel(context)),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(9),
                FilteringTextInputFormatter.digitsOnly,
                ThousandSeparatorInputFormatter(),
              ],
              onChanged: (_) {
                consumableCubit.validateAllLastChangedKilometerFields(context);
                consumableCubit.validateAllChangeKilometerFields(context);
              },
              onEditingComplete: () => consumableCubit.validateAllChangeKilometerFields(context),
              autovalidateMode: AutovalidateMode.always,
            ),
          ],
        );

    Expanded buildConsumablesList() => Expanded(
          flex: 1000,
          child: Scrollbar(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 15),
              // separatorBuilder: (context, index) => const Divider(thickness: 2),
              child: ReorderableListView.builder(
                  itemCount: Consumable.getCount(),
                  itemBuilder: (context, index) {
                    List? list = DatabaseHelper.consumableBox.get(AppStrings.consumableBox);
                    Consumable item = list![index];
                    return Column(
                      key: ValueKey(index),
                      children: [
                        ConsumableWidget(index: index, name: item.name),
                        index == list.length - 1
                            ? const SizedBox()
                            : Divider(
                    indent: 20,
                    endIndent: 20
                    ,color: AppColors.getHintColor(context), thickness: 2)
                      ],
                    );
                  },
                  onReorder: (oldIndex, newIndex) =>
                      setState(() => DatabaseHelper.changeConsumableOrder(context, oldIndex, newIndex))),
            ),
          ),
        );

    Padding buildBottomButtons() => Padding(
          padding: const EdgeInsetsDirectional.only(top: 10, end: 15),
          child: Row(
            children: [
              Flexible(
                flex: 4,
                child: CustomButton(
                  text: AppStrings.btnSave(context),
                  btnEnabled: consumableCubit.shouldEnableButton(context),
                  onPressed: () => DatabaseHelper.writeConsumablesData(context),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: CustomIconButton(
                  iconData: Icons.add,
                  btnEnabled: consumableCubit.shouldEnableButton(context),
                  onPressed: () => Navigator.pushNamed(context, Routes.addConsumableRoute),
                ),
              )
            ],
          ),
        );

    return BlocBuilder<ConsumableCubit, ConsumableState>(
      builder: (context, state) {
        // TODO: implement onWillPop, surround by WillPopScope widget
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.getPrimaryColor(context),
            toolbarHeight: 140,
            title: buildAppBarWidgets(),
          )
          // TODO: add ads to page
          // .withBottomAdmobBanner(context)
          ,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildConsumablesList(),
                  const Spacer(),
                  buildBottomButtons(),
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
