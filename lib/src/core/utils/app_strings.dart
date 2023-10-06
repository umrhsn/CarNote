import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/services/file_creator/file_creator.dart';
import 'package:car_note/src/core/utils/app_lists.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';

class AppStrings {
  /// Core
  static String appName(BuildContext context) => translate(context, "app_name");

  static const String fontFamilyEn = 'DIN Next'; // Product Sans
  static const String fontFamilyAr = 'ArabicTwo';

  static String get fontFamily => LocaleCubit.currentLangCode == en ? fontFamilyEn : fontFamilyAr;

  /// Localization
  static const String locale = 'locale';
  static const String en = 'en';
  static const String ar = 'ar';

  static String translate(BuildContext context, String stringKey) => AppLocalizations.of(context)!.translate(stringKey)!;

  static List<String> translateList(BuildContext context, String stringKey) => AppLocalizations.of(context)!.translateList(stringKey)!;

  /// Database
  static const String carBox = 'car';
  static const String consumableBox = 'consumable';

  static const String prefsBoolSeen = 'seen';
  static const String prefsBoolNotif = 'notifications_set';
  static const String prefsBoolDetailedModeOn = 'detailed_mode_on';
  static const String prefsBoolEditModeOn = 'edit_mode_on';
  static const String prefsBoolListAdded = 'list_added';
  static const String prefsBoolBeginCarInfoScreenTour = 'begin_car_info_screen_tour';
  static const String prefsBoolBeginConsumablesScreenTour = 'begin_consumables_screen_tour';
  static const String prefsBoolBeginDashboardScreenTour = 'begin_dashboard_screen_tour';
  static const String prefsStringNotifScheduleTime = 'schedule_time';

  /// Buttons
  static String btnContinue(BuildContext context) => translate(context, "btn_continue").toUpperCase();

  static String btnSave(BuildContext context) => translate(context, "btn_save").toUpperCase();

  static String btnAddItem(BuildContext context) => translate(context, "add_item").toUpperCase();

  /// Toasts
  static String dataSavedSuccessfully(BuildContext context) => translate(context, "data_saved_successfully");

  static String somethingWentWrong(BuildContext context) => translate(context, "something_went_wrong");

  static String detailedModeOn(BuildContext context) => translate(context, "detailed_mode_on");

  static String detailedModeOff(BuildContext context) => translate(context, "detailed_mode_off");

  static String notifTimeMsg(BuildContext context) => translate(context, "notif_time_msg");

  static String getNotifTime(TimeOfDay scheduleTime) =>
      scheduleTime.toString().substring(scheduleTime.toString().indexOf('(') + 1, scheduleTime.toString().lastIndexOf(')'));

  static String dailyNotificationOff(BuildContext context) => translate(context, "daily_notif_off");

  static String notificationTimeNotSet(BuildContext context) => translate(context, "notif_time_not_set");

  static String tapBackAgainToExit(BuildContext context) => translate(context, "tap_back_again_to_exit");

  static String langChangedToast(BuildContext context) => translate(context, "lang_changed_toast");

  static String fileCreated(BuildContext context) =>
      "${translate(context, "file_named")}\n${FileCreator.fileName}.txt\n${translate(context, "file_created")}";

  static String fileNotCreated(BuildContext context) => translate(context, "file_not_created");

  static String nameNotEmpty(BuildContext context) => translate(context, "name_not_empty");

  static String removedItem(BuildContext context) => translate(context, "removed_item_successfully");

  static String removedAllData(BuildContext context) => translate(context, "removed_all_data");

  static String itemAdded(BuildContext context) => translate(context, "item_added");

  /// Hints
  static String carTypeHint(BuildContext context) => translate(context, "car_type_hint");

  static String modelYearHint(BuildContext context) => translate(context, "model_year_hint");

  static String currentKmCarInfoScreenHint(BuildContext context) =>
      "${AppStrings.currentKmHint(context)} ${100000.toThousands()} ${AppStrings.km(context)}";

  static String currentKmHint(BuildContext context) => translate(context, "current_km_hint");

  static String nameHint(BuildContext context) => translate(context, "name_hint");

  static String currentKmLabel(BuildContext context) => translate(context, "current_km_label");

  /// Labels
  static String lastChangedAtLabel(BuildContext context) => translate(context, "last_changed_at_label");

  static String changeIntervalLabel(BuildContext context) => translate(context, "change_interval_label");

  static String remainingKmNormalWarningLabel(BuildContext context) => translate(context, "remaining_km_normal_warning_label");

  static String remainingKmErrorLabel(BuildContext context) => translate(context, "remaining_km_error_label");

  static String advice(BuildContext context) => translate(context, "advice");

  static String severity(BuildContext context) => translate(context, "severity");

  static String skip(BuildContext context) => translate(context, "skip");

  /// Validators
  static String requiredField(BuildContext context) => translate(context, "required_field");

  static String yearMatchesLength(BuildContext context) => translate(context, "year_matches_length");

  static String yearInvalid(BuildContext context) => translate(context, "year_invalid");

  static String invalidInput(BuildContext context) => translate(context, "invalid_input");

  static String normalAndWarningText(BuildContext context) => translate(context, "normal_warning_text");

  static String considerText(BuildContext context) => translate(context, "consider_text");

  static String errorText(BuildContext context) => translate(context, "error_text");

  static String remaining(BuildContext context) => translate(context, "remaining");

  static String km(BuildContext context) => translate(context, "km");

  /// Dialogs
  static String changedDataMsg(BuildContext context) => translate(context, "changed_data_msg");

  static String sureToDeleteMsg(BuildContext context) => translate(context, "sure_to_delete");

  static String sureToExitMsg(BuildContext context) => translate(context, "sure_to_exit");

  static String saveData(BuildContext context) => translate(context, "save_data").toUpperCase();

  static String exitWithoutSaving(BuildContext context) => translate(context, "exit_without_saving").toUpperCase();

  static String removingItem(BuildContext context, int index) =>
      "${translate(context, "removing_item")}\n'${DatabaseHelper.consumableBox.get(AppStrings.consumableBox)![index].name}'";

  static String removeItem(BuildContext context) => translate(context, "remove_item");

  static String cancel(BuildContext context) => translate(context, "cancel");

  static String removeAllDataConfirmationDialogTitle(BuildContext context) => translate(context, "remove_all_data_confirmation_dialog_title");

  static String removeAllDataConfirmationDialogContent(BuildContext context) => translate(context, "remove_all_data_confirmation_dialog_content");

  static String proceed(BuildContext context) => translate(context, "proceed");

  static String removeAllDataAssuringDialogTitle(BuildContext context) => translate(context, "remove_all_data_assuring_dialog_title");

  static String removeAllDataAssuringDialogContent(BuildContext context) => translate(context, "remove_all_data_assuring_dialog_content");

  static String eraseData(BuildContext context) => translate(context, "erase_data");

  static String invalidDataDialogTitle(BuildContext context) => translate(context, "invalid_data_dialog_title");

  static String invalidDataDialogContent(BuildContext context) => translate(context, "invalid_data_dialog_content");

  /// AppBar titles
  static String addConsumable(BuildContext context) => translate(context, "add_an_item");

  /// Notifications
  static const String notifChannelBasicGroupKey = 'basic_channel_group';
  static const String notifChannelBasicGroupName = 'Basic group';
  static const String notifChannelScheduledGroupKey = 'scheduled_channel_group';
  static const String notifChannelScheduledGroupName = 'Scheduled group';

  static const String notifChannelBasicKey = 'basic_channel';
  static const String notifChannelBasicName = 'Basic notifications';
  static const String notifChannelBasicDescription = 'Notification channel for basic notifications';
  static const String notifChannelScheduledKey = 'scheduled_channel';
  static const String notifChannelScheduledName = 'Scheduled notifications';
  static const String notifChannelScheduledDescription = 'Notification channel for scheduled notifications';

  static String dailyNotificationTitle(BuildContext context) => translate(context, "daily_notif_title");

  static String dailyNotificationBody(BuildContext context) => translate(context, "daily_notif_body");

  static String dailyNotificationTimePickerHelperText(BuildContext context) => translate(context, "daily_notif_time_picker_helper_text");

  /// Tooltips
  static String toggleModeTooltip(BuildContext context) => translate(context, "toggle_mode_tooltip");

  static String switchLangTooltip(BuildContext context) => translate(context, "switch_language_tooltip");

  static String createFileTooltip(BuildContext context) => translate(context, "create_file_tooltip");

  static String infoTooltip(BuildContext context) => translate(context, "info_tooltip");

  static String switchToGridView(BuildContext context) => translate(context, "switch_to_grid_view");

  static String switchToListView(BuildContext context) => translate(context, "switch_to_list_view");

  static String switchedToGridView(BuildContext context) => translate(context, "switched_to_grid_view");

  static String switchedToListView(BuildContext context) => translate(context, "switched_to_list_view");

  static String sortByAlphaTooltip(BuildContext context) => translate(context, "sort_by_alpha_tooltip");

  static String sortByCategoryTooltip(BuildContext context) => translate(context, "sort_by_category_tooltip");

  static String sortBySeverityTooltip(BuildContext context) => translate(context, "sort_by_severity_tooltip");

  static String eraseDataTooltip(BuildContext context) => translate(context, "erase_data_tooltip");

  /// Lists
  static List<String> warningTitles(BuildContext context) => translateList(context, "warning_titles");

  static List<String> advisoryTitles(BuildContext context) => translateList(context, "advisory_titles");

  static List<String> infoTitles(BuildContext context) => translateList(context, "info_titles");

  static List<String> warningDescriptions(BuildContext context) => translateList(context, "warning_descriptions");

  static List<String> advisoryDescriptions(BuildContext context) => translateList(context, "advisory_descriptions");

  static List<String> infoDescriptions(BuildContext context) => translateList(context, "info_descriptions");

  static List<String> warningAdvices(BuildContext context) => translateList(context, "warning_advices");

  static List<String> advisoryAdvices(BuildContext context) => translateList(context, "advisory_advices");

  static List<String> infoAdvices(BuildContext context) => translateList(context, "info_advices");

  // FIXME: these methods were functional before switching lists to json files
  static void sortAlphabetically(BuildContext context) => AppLists.dashboardItems(context).sort((a, b) => a.title.compareTo(b.title));

  static void sortCategories(BuildContext context) {
    sortAlphabetically(context);
    AppLists.dashboardItems(context).sort((a, b) => a.category.compareTo(b.category));
  }

  static void sortSeverities(BuildContext context) {
    sortCategories(context);
    AppLists.dashboardItems(context).sort((a, b) => b.severity.compareTo(a.severity));
  }

  static String nothingHere(BuildContext context) => translate(context, "nothing_here");

  static String tryToAddItems(BuildContext context) => translate(context, "try_to_add_items");

  /// App Tour
  static String tourTargetAppBarTextField(BuildContext context) => translate(context, "tour_target_app_bar_text_field");

  static String tourTargetList(BuildContext context) => translate(context, "tour_target_list");

  static String tourTargetCard(BuildContext context) => translate(context, "tour_target_card");

  static String tourTargetEditName(BuildContext context) => translate(context, "tour_target_edit_name");

  static String tourTargetDeleteCard(BuildContext context) => translate(context, "tour_target_delete_card");

  static String tourTargetTextFieldLastChanged(BuildContext context) => translate(context, "tour_target_text_field_last_changed");

  static String tourTargetTextFieldChangeInterval(BuildContext context) => translate(context, "tour_target_text_field_change_interval");

  static String tourTargetTextFieldRemaining(BuildContext context) => translate(context, "tour_target_text_field_remaining");

  static String tourTargetCardReorder(BuildContext context) => translate(context, "tour_target_card_reorder");

  static String tourTargetSaveData(BuildContext context) => translate(context, "tour_target_save_data");

  static String tourTargetAddItem(BuildContext context) => translate(context, "tour_target_add_item");

  static String tourTargetSwitchLang(BuildContext context) => translate(context, "tour_target_switch_lang");

  static String tourTargetToggleDetailedMode(BuildContext context) => translate(context, "tour_target_toggle_detailed_mode");

  static String tourTargetSaveToFile(BuildContext context) => translate(context, "tour_target_save_to_file");

  static String tourTargetDeleteAll(BuildContext context) => translate(context, "tour_target_delete_all");

  static String tourTargetInfo(BuildContext context) => translate(context, "tour_target_info");

  static String tourTargetGridItem(BuildContext context) => translate(context, "tour_target_grid_item");

  static String tourTargetSwitchListGrid(BuildContext context) => translate(context, "tour_target_switch_list_grid");

  /// Error handling
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';
}
