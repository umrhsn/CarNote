import 'package:admob_flutter/admob_flutter.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/services/file_creator/file_creator.dart';
import 'package:car_note/src/core/services/notifications/notifications_helper.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/asset_manager.dart';
import 'package:car_note/src/core/widgets/custom_button.dart';
import 'package:car_note/src/core/widgets/custom_button_with_icon.dart';
import 'package:car_note/src/core/widgets/custom_icon_button.dart';
import 'package:car_note/src/core/widgets/dialogs.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumable_widget.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
  final List? _list = DatabaseHelper.consumableBox.get(AppStrings.consumableBox);

  bool _getVisibilityStatus() {
    if (_prefs.getBool(AppStrings.prefsBoolDetailedModeOn) == null) {
      _prefs.setBool(AppStrings.prefsBoolDetailedModeOn, true);
    }
    bool visible = _prefs.getBool(AppStrings.prefsBoolDetailedModeOn) ?? true;
    return visible;
  }

  void _scheduleDailyNotification() {
    Cron().schedule(
        Schedule.parse('0 9 * * *'), () => NotificationsHelper.showDailyNotification(context));
    Cron().schedule(
        Schedule.parse('0 21 * * *'), () => NotificationsHelper.showDailyNotification(context));
  }

  @override
  void initState() {
    super.initState();
    _getVisibilityStatus();
    NotificationsHelper.requestNotificationsPermission();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scheduleDailyNotification();
      NotificationsHelper.showAlarmingNotifications(context);
    });
    Admob.requestTrackingAuthorization();
  }

  @override
  Widget build(BuildContext context) {
    LocaleCubit localeCubit = LocaleCubit.get(context);
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    Column buildAppBarWidgets() => Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.language),
                  onPressed: () => AppLocalizations.of(context)!.isEnLocale
                      ? localeCubit.toArabic(context)
                      : localeCubit.toEnglish(context),
                  tooltip: AppStrings.switchLangTooltip(context),
                ),
                const Spacer(),
                CustomIconButton(
                  btnEnabled: _list!.isNotEmpty,
                  icon: _getVisibilityStatus() ? Icons.visibility : Icons.visibility_outlined,
                  onPressed: () => consumableCubit.changeVisibility(context),
                  tooltip: AppStrings.toggleModeTooltip(context),
                ),
                CustomIconButton(
                  btnEnabled: _list!.isNotEmpty,
                  icon: Icons.file_copy,
                  onPressed: () => DatabaseHelper.writeConsumablesData(context).then((value) =>
                      FileCreator.writeDataToFile().then((value) => BotToast.showText(
                          duration: Duration(seconds: value == true ? 7 : 2),
                          text: value == true
                              ? AppStrings.fileCreated(context)
                              : AppStrings.fileNotCreated(context),
                          textStyle: const TextStyle(
                              color: Colors.white, fontFamily: AppStrings.fontFamilyEn)))),
                  tooltip: AppStrings.createFileTooltip(context),
                ),
                CustomIconButton(
                  btnEnabled: _list!.isNotEmpty,
                  icon: Icons.delete_forever,
                  onPressed: () => Dialogs.showRemoveAllDataConfirmationDialog(context),
                  tooltip: AppStrings.eraseDataTooltip(context),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.infoRoute),
                  icon: const Icon(Icons.info),
                  tooltip: AppStrings.infoTooltip(context),
                ),
              ],
            ),
            TextFormField(
              focusNode: consumableCubit.currentKmFocus,
              cursorColor: AppColors.getTextFieldBorderAndLabel(context),
              controller: consumableCubit.currentKmController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                floatingLabelStyle: TextStyle(
                  color: consumableCubit.currentKmFocus.hasFocus
                      ? AppColors.getTextFieldBorderAndLabelFocused(context)
                      : AppColors.getTextFieldBorderAndLabel(context),
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.getTextFieldBorderAndLabel(context),
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

    Column buildEmptyListWidget(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AssetManager.nothingHere, height: context.height / 5),
          const SizedBox(height: 15),
          Text(
            AppStrings.nothingHere(context),
            style: TextStyle(
              fontFamily: AppStrings.fontFamilyEn,
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.tryToAddItems(context),
            style: TextStyle(
                color: AppColors.getHintColor(context), fontFamily: AppStrings.fontFamilyEn),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    Expanded buildConsumablesList() {
      return Expanded(
        flex: 1000,
        child: _list != null && _list!.isEmpty
            ? buildEmptyListWidget(context)
            : Scrollbar(
                interactive: true,
                thumbVisibility: false,
                trackVisibility: false,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 15, end: 10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: ReorderableListView.builder(
                        itemCount: Consumable.getCount(),
                        itemBuilder: (context, index) {
                          Consumable item = _list![index];
                          return AnimationConfiguration.staggeredList(
                            key: ValueKey(index),
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: ConsumableWidget(index: index, name: item.name),
                              ),
                            ),
                          );
                        },
                        onReorder: (oldIndex, newIndex) => setState(() =>
                            DatabaseHelper.changeConsumableOrder(context, oldIndex, newIndex))),
                  ),
                ),
              ),
      );
    }

    Padding buildBottomButtons() => Padding(
          padding: const EdgeInsetsDirectional.only(end: 10),
          child: Row(
            children: [
              Flexible(
                flex: 4,
                child: CustomButton(
                  text: AppStrings.btnSave(context),
                  btnEnabled: consumableCubit.shouldEnableButtons(context) && _list!.isNotEmpty,
                  onPressed: () => DatabaseHelper.writeConsumablesData(context).then((value) =>
                      BotToast.showText(text: AppStrings.dataSavedSuccessfully(context))),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: CustomButtonWithIcon(
                  iconData: Icons.add,
                  btnEnabled: consumableCubit.shouldEnableButtons(context),
                  onPressed: () => Navigator.pushNamed(context, Routes.addConsumableRoute),
                ),
              ),
            ],
          ),
        );

    return BlocBuilder<ConsumableCubit, ConsumableState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () => Dialogs.onWillPop(context),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 140,
              title: buildAppBarWidgets(),
            )
            // TODO: add ads to page
            // .withBottomAdmobBanner(context)
            ,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
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
          ),
        );
      },
    );
  }
}
