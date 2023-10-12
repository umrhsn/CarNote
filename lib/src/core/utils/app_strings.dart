import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/services/file_creator/file_creator.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';

class AppStrings {
  /// Core
  static String appName(context) => _translate(context, AppKeys.app_name);

  static const String fontFamilyEn = 'DIN Next'; // Product Sans
  static const String fontFamilyAr = 'ArabicTwo';

  static String get fontFamily => LocaleCubit.currentLangCode == en ? fontFamilyEn : fontFamilyAr;

  /// Localization
  static const String locale = 'locale';
  static const String en = 'en';
  static const String ar = 'ar';

  static String _translate(context, String stringKey) => AppLocalizations.of(context)!.translate(stringKey)!;

  /// Buttons
  static String btnContinue(context) => _translate(context, AppKeys.btn_continue).toUpperCase();

  static String btnSave(context) => _translate(context, AppKeys.btn_save).toUpperCase();

  static String btnAddItem(context) => _translate(context, AppKeys.add_item).toUpperCase();

  /// Toasts
  static String dataSavedSuccessfully(context) => _translate(context, AppKeys.data_saved_successfully);

  static String somethingWentWrong(context) => _translate(context, AppKeys.something_went_wrong);

  static String detailedModeOn(context) => _translate(context, AppKeys.detailed_mode_on);

  static String detailedModeOff(context) => _translate(context, AppKeys.detailed_mode_off);

  static String notifTimeMsg(context) => _translate(context, AppKeys.notif_time_msg);

  static String getNotifTime(TimeOfDay scheduleTime) =>
      scheduleTime.toString().substring(scheduleTime.toString().indexOf('(') + 1, scheduleTime.toString().lastIndexOf(')'));

  static String dailyNotificationOff(context) => _translate(context, AppKeys.daily_notif_off);

  static String notificationTimeNotSet(context) => _translate(context, AppKeys.notif_time_not_set);

  static String tapBackAgainToExit(context) => _translate(context, AppKeys.tap_back_again_to_exit);

  static String langChangedToast(context) => _translate(context, AppKeys.lang_changed_toast);

  static String fileCreated(context) =>
      "${_translate(context, AppKeys.file_named)}\n${FileCreator.fileName}.txt\n${_translate(context, AppKeys.file_created)}";

  static String fileNotCreated(context) => _translate(context, AppKeys.file_not_created);

  static String nameNotEmpty(context) => _translate(context, AppKeys.name_not_empty);

  static String removedItem(context) => _translate(context, AppKeys.removed_item_successfully);

  static String removedAllData(context) => _translate(context, AppKeys.removed_all_data);

  static String itemAdded(context) => _translate(context, AppKeys.item_added);

  /// Hints
  static String carTypeHint(context) => _translate(context, AppKeys.car_type_hint);

  static String modelYearHint(context) => _translate(context, AppKeys.model_year_hint);

  static String currentKmCarInfoScreenHint(context) =>
      "${AppStrings.currentKmHint(context)} ${100000.toThousands()} ${AppStrings.km(context)}";

  static String currentKmHint(context) => _translate(context, AppKeys.current_km_hint);

  static String nameHint(context) => _translate(context, AppKeys.name_hint);

  static String currentKmLabel(context) => _translate(context, AppKeys.current_km_label);

  /// Labels
  static String lastChangedAtLabel(context) => _translate(context, AppKeys.last_changed_at_label);

  static String changeIntervalLabel(context) => _translate(context, AppKeys.change_interval_label);

  static String remainingKmNormalWarningLabel(context) => _translate(context, AppKeys.remaining_km_normal_warning_label);

  static String remainingKmErrorLabel(context) => _translate(context, AppKeys.remaining_km_error_label);

  static String advice(context) => _translate(context, AppKeys.advice);

  static String severity(context) => _translate(context, AppKeys.severity);

  static String skip(context) => _translate(context, AppKeys.skip);

  /// Validators
  static String requiredField(context) => _translate(context, AppKeys.required_field);

  static String yearMatchesLength(context) => _translate(context, AppKeys.year_matches_length);

  static String yearInvalid(context) => _translate(context, AppKeys.year_invalid);

  static String invalidInput(context) => _translate(context, AppKeys.invalid_input);

  static String normalAndWarningText(context) => _translate(context, AppKeys.normal_warning_text);

  static String considerText(context) => _translate(context, AppKeys.consider_text);

  static String errorText(context) => _translate(context, AppKeys.error_text);

  static String remaining(context) => _translate(context, AppKeys.remaining);

  static String km(context) => _translate(context, AppKeys.km);

  /// Dialogs
  static String changedDataMsg(context) => _translate(context, AppKeys.changed_data_msg);

  static String sureToDeleteMsg(context) => _translate(context, AppKeys.sure_to_delete);

  static String sureToExitMsg(context) => _translate(context, AppKeys.sure_to_exit);

  static String saveData(context) => _translate(context, AppKeys.save_data).toUpperCase();

  static String exitWithoutSaving(context) => _translate(context, AppKeys.exit_without_saving).toUpperCase();

  static String removingItem(context, int index) =>
      "${_translate(context, AppKeys.removing_item)}\n'${DatabaseHelper.consumableBox.get(AppKeys.consumableBox)![index].name}'";

  static String removeItem(context) => _translate(context, AppKeys.remove_item);

  static String cancel(context) => _translate(context, AppKeys.cancel);

  static String removeAllDataConfirmationDialogTitle(context) => _translate(context, AppKeys.remove_all_data_confirmation_dialog_title);

  static String removeAllDataConfirmationDialogContent(context) =>
      _translate(context, AppKeys.remove_all_data_confirmation_dialog_content);

  static String proceed(context) => _translate(context, AppKeys.proceed);

  static String removeAllDataAssuringDialogTitle(context) => _translate(context, AppKeys.remove_all_data_assuring_dialog_title);

  static String removeAllDataAssuringDialogContent(context) => _translate(context, AppKeys.remove_all_data_assuring_dialog_content);

  static String eraseData(context) => _translate(context, AppKeys.erase_data);

  static String invalidDataDialogTitle(context) => _translate(context, AppKeys.invalid_data_dialog_title);

  static String invalidDataDialogContent(context) => _translate(context, AppKeys.invalid_data_dialog_content);

  /// AppBar titles
  static String addConsumable(context) => _translate(context, AppKeys.add_an_item);

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

  static String dailyNotificationTitle(context) => _translate(context, AppKeys.daily_notif_title);

  static String dailyNotificationBody(context) => _translate(context, AppKeys.daily_notif_body);

  static String dailyNotificationTimePickerHelperText(context) => _translate(context, AppKeys.daily_notif_time_picker_helper_text);

  /// Tooltips
  static String toggleModeTooltip(context) => _translate(context, AppKeys.toggle_mode_tooltip);

  static String switchLangTooltip(context) => _translate(context, AppKeys.switch_language_tooltip);

  static String createFileTooltip(context) => _translate(context, AppKeys.create_file_tooltip);

  static String infoTooltip(context) => _translate(context, AppKeys.info_tooltip);

  static String switchToGridView(context) => _translate(context, AppKeys.switch_to_grid_view);

  static String switchToListView(context) => _translate(context, AppKeys.switch_to_list_view);

  static String switchedToGridView(context) => _translate(context, AppKeys.switched_to_grid_view);

  static String switchedToListView(context) => _translate(context, AppKeys.switched_to_list_view);

  static String sortByAlphaTooltip(context) => _translate(context, AppKeys.sort_by_alpha_tooltip);

  static String sortByCategoryTooltip(context) => _translate(context, AppKeys.sort_by_category_tooltip);

  static String sortBySeverityTooltip(context) => _translate(context, AppKeys.sort_by_severity_tooltip);

  static String eraseDataTooltip(context) => _translate(context, AppKeys.erase_data_tooltip);

  /// Lists
  static String nothingHere(context) => _translate(context, AppKeys.nothing_here);

  static String tryToAddItems(context) => _translate(context, AppKeys.try_to_add_items);

  /// App Tour
  static String tourTargetAppBarTextField(context) => _translate(context, AppKeys.tour_target_app_bar_text_field);

  static String tourTargetList(context) => _translate(context, AppKeys.tour_target_list);

  static String tourTargetCard(context) => _translate(context, AppKeys.tour_target_card);

  static String tourTargetEditName(context) => _translate(context, AppKeys.tour_target_edit_name);

  static String tourTargetDeleteCard(context) => _translate(context, AppKeys.tour_target_delete_card);

  static String tourTargetTextFieldLastChanged(context) => _translate(context, AppKeys.tour_target_text_field_last_changed);

  static String tourTargetTextFieldChangeInterval(context) => _translate(context, AppKeys.tour_target_text_field_change_interval);

  static String tourTargetTextFieldRemaining(context) => _translate(context, AppKeys.tour_target_text_field_remaining);

  static String tourTargetCardReorder(context) => _translate(context, AppKeys.tour_target_card_reorder);

  static String tourTargetSaveData(context) => _translate(context, AppKeys.tour_target_save_data);

  static String tourTargetAddItem(context) => _translate(context, AppKeys.tour_target_add_item);

  static String tourTargetSwitchLang(context) => _translate(context, AppKeys.tour_target_switch_lang);

  static String tourTargetToggleDetailedMode(context) => _translate(context, AppKeys.tour_target_toggle_detailed_mode);

  static String tourTargetSaveToFile(context) => _translate(context, AppKeys.tour_target_save_to_file);

  static String tourTargetDeleteAll(context) => _translate(context, AppKeys.tour_target_delete_all);

  static String tourTargetInfo(context) => _translate(context, AppKeys.tour_target_info);

  static String tourTargetGridItem(context) => _translate(context, AppKeys.tour_target_grid_item);

  static String tourTargetSwitchListGrid(context) => _translate(context, AppKeys.tour_target_switch_list_grid);

  /// Error handling
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';
}
