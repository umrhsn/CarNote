import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/services/file_creator/file_creator.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';

class AppStrings {
  /// Core
  static String appName(BuildContext context) => translate(context, AppKeys.app_name);

  static const String fontFamilyEn = 'DIN Next'; // Product Sans
  static const String fontFamilyAr = 'ArabicTwo';

  static String get fontFamily => LocaleCubit.currentLangCode == en ? fontFamilyEn : fontFamilyAr;

  /// Localization
  static const String locale = 'locale';
  static const String en = 'en';
  static const String ar = 'ar';

  static String translate(BuildContext context, String stringKey) => AppLocalizations.of(context)!.translate(stringKey)!;

  static List<String> translateList(BuildContext context, String stringKey) => AppLocalizations.of(context)!.translateList(stringKey)!;

  /// Buttons
  static String btnContinue(BuildContext context) => translate(context, AppKeys.btn_continue).toUpperCase();

  static String btnSave(BuildContext context) => translate(context, AppKeys.btn_save).toUpperCase();

  static String btnAddItem(BuildContext context) => translate(context, AppKeys.add_item).toUpperCase();

  /// Toasts
  static String dataSavedSuccessfully(BuildContext context) => translate(context, AppKeys.data_saved_successfully);

  static String somethingWentWrong(BuildContext context) => translate(context, AppKeys.something_went_wrong);

  static String detailedModeOn(BuildContext context) => translate(context, AppKeys.detailed_mode_on);

  static String detailedModeOff(BuildContext context) => translate(context, AppKeys.detailed_mode_off);

  static String notifTimeMsg(BuildContext context) => translate(context, AppKeys.notif_time_msg);

  static String getNotifTime(TimeOfDay scheduleTime) =>
      scheduleTime.toString().substring(scheduleTime.toString().indexOf('(') + 1, scheduleTime.toString().lastIndexOf(')'));

  static String dailyNotificationOff(BuildContext context) => translate(context, AppKeys.daily_notif_off);

  static String notificationTimeNotSet(BuildContext context) => translate(context, AppKeys.notif_time_not_set);

  static String tapBackAgainToExit(BuildContext context) => translate(context, AppKeys.tap_back_again_to_exit);

  static String langChangedToast(BuildContext context) => translate(context, AppKeys.lang_changed_toast);

  static String fileCreated(BuildContext context) =>
      "${translate(context, AppKeys.file_named)}\n${FileCreator.fileName}.txt\n${translate(context, AppKeys.file_created)}";

  static String fileNotCreated(BuildContext context) => translate(context, AppKeys.file_not_created);

  static String nameNotEmpty(BuildContext context) => translate(context, AppKeys.name_not_empty);

  static String removedItem(BuildContext context) => translate(context, AppKeys.removed_item_successfully);

  static String removedAllData(BuildContext context) => translate(context, AppKeys.removed_all_data);

  static String itemAdded(BuildContext context) => translate(context, AppKeys.item_added);

  /// Hints
  static String carTypeHint(BuildContext context) => translate(context, AppKeys.car_type_hint);

  static String modelYearHint(BuildContext context) => translate(context, AppKeys.model_year_hint);

  static String currentKmCarInfoScreenHint(BuildContext context) =>
      "${AppStrings.currentKmHint(context)} ${100000.toThousands()} ${AppStrings.km(context)}";

  static String currentKmHint(BuildContext context) => translate(context, AppKeys.current_km_hint);

  static String nameHint(BuildContext context) => translate(context, AppKeys.name_hint);

  static String currentKmLabel(BuildContext context) => translate(context, AppKeys.current_km_label);

  /// Labels
  static String lastChangedAtLabel(BuildContext context) => translate(context, AppKeys.last_changed_at_label);

  static String changeIntervalLabel(BuildContext context) => translate(context, AppKeys.change_interval_label);

  static String remainingKmNormalWarningLabel(BuildContext context) => translate(context, AppKeys.remaining_km_normal_warning_label);

  static String remainingKmErrorLabel(BuildContext context) => translate(context, AppKeys.remaining_km_error_label);

  static String advice(BuildContext context) => translate(context, AppKeys.advice);

  static String severity(BuildContext context) => translate(context, AppKeys.severity);

  static String skip(BuildContext context) => translate(context, AppKeys.skip);

  /// Validators
  static String requiredField(BuildContext context) => translate(context, AppKeys.required_field);

  static String yearMatchesLength(BuildContext context) => translate(context, AppKeys.year_matches_length);

  static String yearInvalid(BuildContext context) => translate(context, AppKeys.year_invalid);

  static String invalidInput(BuildContext context) => translate(context, AppKeys.invalid_input);

  static String normalAndWarningText(BuildContext context) => translate(context, AppKeys.normal_warning_text);

  static String considerText(BuildContext context) => translate(context, AppKeys.consider_text);

  static String errorText(BuildContext context) => translate(context, AppKeys.error_text);

  static String remaining(BuildContext context) => translate(context, AppKeys.remaining);

  static String km(BuildContext context) => translate(context, AppKeys.km);

  /// Dialogs
  static String changedDataMsg(BuildContext context) => translate(context, AppKeys.changed_data_msg);

  static String sureToDeleteMsg(BuildContext context) => translate(context, AppKeys.sure_to_delete);

  static String sureToExitMsg(BuildContext context) => translate(context, AppKeys.sure_to_exit);

  static String saveData(BuildContext context) => translate(context, AppKeys.save_data).toUpperCase();

  static String exitWithoutSaving(BuildContext context) => translate(context, AppKeys.exit_without_saving).toUpperCase();

  static String removingItem(BuildContext context, int index) =>
      "${translate(context, AppKeys.removing_item)}\n'${DatabaseHelper.consumableBox.get(AppKeys.consumableBox)![index].name}'";

  static String removeItem(BuildContext context) => translate(context, AppKeys.remove_item);

  static String cancel(BuildContext context) => translate(context, AppKeys.cancel);

  static String removeAllDataConfirmationDialogTitle(BuildContext context) => translate(context, AppKeys.remove_all_data_confirmation_dialog_title);

  static String removeAllDataConfirmationDialogContent(BuildContext context) =>
      translate(context, AppKeys.remove_all_data_confirmation_dialog_content);

  static String proceed(BuildContext context) => translate(context, AppKeys.proceed);

  static String removeAllDataAssuringDialogTitle(BuildContext context) => translate(context, AppKeys.remove_all_data_assuring_dialog_title);

  static String removeAllDataAssuringDialogContent(BuildContext context) => translate(context, AppKeys.remove_all_data_assuring_dialog_content);

  static String eraseData(BuildContext context) => translate(context, AppKeys.erase_data);

  static String invalidDataDialogTitle(BuildContext context) => translate(context, AppKeys.invalid_data_dialog_title);

  static String invalidDataDialogContent(BuildContext context) => translate(context, AppKeys.invalid_data_dialog_content);

  /// AppBar titles
  static String addConsumable(BuildContext context) => translate(context, AppKeys.add_an_item);

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

  static String dailyNotificationTitle(BuildContext context) => translate(context, AppKeys.daily_notif_title);

  static String dailyNotificationBody(BuildContext context) => translate(context, AppKeys.daily_notif_body);

  static String dailyNotificationTimePickerHelperText(BuildContext context) => translate(context, AppKeys.daily_notif_time_picker_helper_text);

  /// Tooltips
  static String toggleModeTooltip(BuildContext context) => translate(context, AppKeys.toggle_mode_tooltip);

  static String switchLangTooltip(BuildContext context) => translate(context, AppKeys.switch_language_tooltip);

  static String createFileTooltip(BuildContext context) => translate(context, AppKeys.create_file_tooltip);

  static String infoTooltip(BuildContext context) => translate(context, AppKeys.info_tooltip);

  static String switchToGridView(BuildContext context) => translate(context, AppKeys.switch_to_grid_view);

  static String switchToListView(BuildContext context) => translate(context, AppKeys.switch_to_list_view);

  static String switchedToGridView(BuildContext context) => translate(context, AppKeys.switched_to_grid_view);

  static String switchedToListView(BuildContext context) => translate(context, AppKeys.switched_to_list_view);

  static String sortByAlphaTooltip(BuildContext context) => translate(context, AppKeys.sort_by_alpha_tooltip);

  static String sortByCategoryTooltip(BuildContext context) => translate(context, AppKeys.sort_by_category_tooltip);

  static String sortBySeverityTooltip(BuildContext context) => translate(context, AppKeys.sort_by_severity_tooltip);

  static String eraseDataTooltip(BuildContext context) => translate(context, AppKeys.erase_data_tooltip);

  /// Lists
  static List<String> warningTitles(BuildContext context) => translateList(context, AppKeys.warning_titles);

  static List<String> advisoryTitles(BuildContext context) => translateList(context, AppKeys.advisory_titles);

  static List<String> infoTitles(BuildContext context) => translateList(context, AppKeys.info_titles);

  static List<String> warningDescriptions(BuildContext context) => translateList(context, AppKeys.warning_descriptions);

  static List<String> advisoryDescriptions(BuildContext context) => translateList(context, AppKeys.advisory_descriptions);

  static List<String> infoDescriptions(BuildContext context) => translateList(context, AppKeys.info_descriptions);

  static List<String> warningAdvices(BuildContext context) => translateList(context, AppKeys.warning_advices);

  static List<String> advisoryAdvices(BuildContext context) => translateList(context, AppKeys.advisory_advices);

  static List<String> infoAdvices(BuildContext context) => translateList(context, AppKeys.info_advices);

  static String nothingHere(BuildContext context) => translate(context, AppKeys.nothing_here);

  static String tryToAddItems(BuildContext context) => translate(context, AppKeys.try_to_add_items);

  /// App Tour
  static String tourTargetAppBarTextField(BuildContext context) => translate(context, AppKeys.tour_target_app_bar_text_field);

  static String tourTargetList(BuildContext context) => translate(context, AppKeys.tour_target_list);

  static String tourTargetCard(BuildContext context) => translate(context, AppKeys.tour_target_card);

  static String tourTargetEditName(BuildContext context) => translate(context, AppKeys.tour_target_edit_name);

  static String tourTargetDeleteCard(BuildContext context) => translate(context, AppKeys.tour_target_delete_card);

  static String tourTargetTextFieldLastChanged(BuildContext context) => translate(context, AppKeys.tour_target_text_field_last_changed);

  static String tourTargetTextFieldChangeInterval(BuildContext context) => translate(context, AppKeys.tour_target_text_field_change_interval);

  static String tourTargetTextFieldRemaining(BuildContext context) => translate(context, AppKeys.tour_target_text_field_remaining);

  static String tourTargetCardReorder(BuildContext context) => translate(context, AppKeys.tour_target_card_reorder);

  static String tourTargetSaveData(BuildContext context) => translate(context, AppKeys.tour_target_save_data);

  static String tourTargetAddItem(BuildContext context) => translate(context, AppKeys.tour_target_add_item);

  static String tourTargetSwitchLang(BuildContext context) => translate(context, AppKeys.tour_target_switch_lang);

  static String tourTargetToggleDetailedMode(BuildContext context) => translate(context, AppKeys.tour_target_toggle_detailed_mode);

  static String tourTargetSaveToFile(BuildContext context) => translate(context, AppKeys.tour_target_save_to_file);

  static String tourTargetDeleteAll(BuildContext context) => translate(context, AppKeys.tour_target_delete_all);

  static String tourTargetInfo(BuildContext context) => translate(context, AppKeys.tour_target_info);

  static String tourTargetGridItem(BuildContext context) => translate(context, AppKeys.tour_target_grid_item);

  static String tourTargetSwitchListGrid(BuildContext context) => translate(context, AppKeys.tour_target_switch_list_grid);

  /// Error handling
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';
}
