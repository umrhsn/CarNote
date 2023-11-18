import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/services/file_creator/file_creator.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';

class AppStrings {
  /// Core
  static String appName(BuildContext context) => _translate(context, AppKeys.app_name);

  static const String fontFamilyEn = 'DIN Next'; // Product Sans
  static const String fontFamilyAr = 'ArabicTwo';

  static String get fontFamily => LocaleCubit.currentLangCode == en ? fontFamilyEn : fontFamilyAr;

  /// Localization
  static const String locale = 'locale';
  static const String en = 'en';
  static const String ar = 'ar';

  static String _translate(context, String stringKey) => AppLocalizations.of(context)!.translate(stringKey)!;

  /// Buttons
  static String btnContinue(BuildContext context) => _translate(context, AppKeys.btn_continue).toUpperCase();

  static String btnSave(BuildContext context) => _translate(context, AppKeys.btn_save).toUpperCase();

  static String btnAddItem(BuildContext context) => _translate(context, AppKeys.add_item).toUpperCase();

  /// Toasts
  static String dataSavedSuccessfully(BuildContext context) => _translate(context, AppKeys.data_saved_successfully);

  static String somethingWentWrong(BuildContext context) => _translate(context, AppKeys.something_went_wrong);

  static String detailedModeOn(BuildContext context) => _translate(context, AppKeys.detailed_mode_on);

  static String detailedModeOff(BuildContext context) => _translate(context, AppKeys.detailed_mode_off);

  static String notifTimeMsg(BuildContext context) => _translate(context, AppKeys.notif_time_msg);

  static String getNotifTime(TimeOfDay scheduleTime) =>
      scheduleTime.toString().substring(scheduleTime.toString().indexOf('(') + 1, scheduleTime.toString().lastIndexOf(')'));

  static String dailyNotificationOff(BuildContext context) => _translate(context, AppKeys.daily_notif_off);

  static String notificationTimeNotSet(BuildContext context) => _translate(context, AppKeys.notif_time_not_set);

  static String tapBackAgainToExit(BuildContext context) => _translate(context, AppKeys.tap_back_again_to_exit);

  static String langChangedToast(BuildContext context) => _translate(context, AppKeys.lang_changed_toast);

  static String fileCreated(BuildContext context) =>
      "${_translate(context, AppKeys.file_named)}\n${FileCreator.fileName}.txt\n${_translate(context, AppKeys.file_created)}";

  static String fileNotCreated(BuildContext context) => _translate(context, AppKeys.file_not_created);

  static String nameNotEmpty(BuildContext context) => _translate(context, AppKeys.name_not_empty);

  static String resetItemSuccessfully(BuildContext context) => _translate(context, AppKeys.reset_item_successfully);

  static String removedItemSuccessfully(BuildContext context) => _translate(context, AppKeys.removed_item_successfully);

  static String resetAllCards(BuildContext context) => _translate(context, AppKeys.reset_all_data);

  static String removedAllCards(BuildContext context) => _translate(context, AppKeys.removed_all_cards);

  static String itemAdded(BuildContext context) => _translate(context, AppKeys.item_added);

  /// Hints
  static String carTypeHint(BuildContext context) => _translate(context, AppKeys.car_type_hint);

  static String modelYearHint(BuildContext context) => _translate(context, AppKeys.model_year_hint);

  static String currentKmCarInfoScreenHint(BuildContext context) =>
      "${AppStrings.currentKmHint(context)} ${100000.toThousands()} ${AppStrings.km(context)}";

  static String currentKmHint(BuildContext context) => _translate(context, AppKeys.current_km_hint);

  static String nameHint(BuildContext context) => _translate(context, AppKeys.name_hint);

  static String currentKmLabel(BuildContext context) => _translate(context, AppKeys.current_km_label);

  /// Labels
  static String lastChangedAtLabel(BuildContext context) => _translate(context, AppKeys.last_changed_at_label);

  static String changeIntervalLabel(BuildContext context) => _translate(context, AppKeys.change_interval_label);

  static String remainingKmNormalWarningLabel(BuildContext context) => _translate(context, AppKeys.remaining_km_normal_warning_label);

  static String remainingKmErrorLabel(BuildContext context) => _translate(context, AppKeys.remaining_km_error_label);

  static String advice(BuildContext context) => _translate(context, AppKeys.advice);

  static String severity(BuildContext context) => _translate(context, AppKeys.severity);

  static String skip(BuildContext context) => _translate(context, AppKeys.skip);

  /// Validators
  static String requiredField(BuildContext context) => _translate(context, AppKeys.required_field);

  static String yearMatchesLength(BuildContext context) => _translate(context, AppKeys.year_matches_length);

  static String yearInvalid(BuildContext context) => _translate(context, AppKeys.year_invalid);

  static String invalidInput(BuildContext context) => _translate(context, AppKeys.invalid_input);

  static String normalAndWarningText(BuildContext context) => _translate(context, AppKeys.normal_warning_text);

  static String considerText(BuildContext context) => _translate(context, AppKeys.consider_text);

  static String errorText(BuildContext context) => _translate(context, AppKeys.error_text);

  static String remaining(BuildContext context) => _translate(context, AppKeys.remaining);

  static String km(BuildContext context) => _translate(context, AppKeys.km);

  /// Dialogs
  static String changedDataMsg(BuildContext context) => _translate(context, AppKeys.changed_data_msg);

  static String sureToResetMsg(BuildContext context) => _translate(context, AppKeys.sure_to_reset);

  static String sureToRemoveMsg(BuildContext context) => _translate(context, AppKeys.sure_to_remove);

  static String sureToExitMsg(BuildContext context) => _translate(context, AppKeys.sure_to_exit);

  static String saveData(BuildContext context) => _translate(context, AppKeys.save_data).toUpperCase();

  static String exitWithoutSaving(BuildContext context) => _translate(context, AppKeys.exit_without_saving).toUpperCase();

  static String resettingItem(context, int index) =>
      "${_translate(context, AppKeys.resetting_item)}\n'${DatabaseHelper.consumableBox.get(AppKeys.consumableBox)![index].name}'";

  static String removingItem(context, int index) =>
      "${_translate(context, AppKeys.removing_item)}\n'${DatabaseHelper.consumableBox.get(AppKeys.consumableBox)![index].name}'";

  static String resetItem(BuildContext context) => _translate(context, AppKeys.reset_item);

  static String removeItem(BuildContext context) => _translate(context, AppKeys.remove_item);

  static String cancel(BuildContext context) => _translate(context, AppKeys.cancel);

  static String resetAllCardsConfirmationDialogTitle(BuildContext context) => _translate(context, AppKeys.reset_all_cards_confirmation_dialog_title);

  static String resetAllCardsConfirmationDialogContent(BuildContext context) =>
      _translate(context, AppKeys.reset_all_cards_confirmation_dialog_content);

  static String removeAllCardsConfirmationDialogTitle(BuildContext context) =>
      _translate(context, AppKeys.remove_all_cards_confirmation_dialog_title);

  static String removeAllCardsConfirmationDialogContent(BuildContext context) =>
      _translate(context, AppKeys.remove_all_cards_confirmation_dialog_content);

  static String proceed(BuildContext context) => _translate(context, AppKeys.proceed);

  static String resetAllCardsAssuringDialogTitle(BuildContext context) => _translate(context, AppKeys.reset_all_cards_assuring_dialog_title);

  static String resetAllCardsAssuringDialogContent(BuildContext context) => _translate(context, AppKeys.reset_all_cards_assuring_dialog_content);

  static String removeAllCardsAssuringDialogTitle(BuildContext context) => _translate(context, AppKeys.remove_all_cards_assuring_dialog_title);

  static String removeAllCardsAssuringDialogContent(BuildContext context) => _translate(context, AppKeys.remove_all_cards_assuring_dialog_content);

  static String eraseData(BuildContext context) => _translate(context, AppKeys.erase_data);

  static String removeCards(BuildContext context) => _translate(context, AppKeys.remove_cards);

  static String invalidDataDialogTitle(BuildContext context) => _translate(context, AppKeys.invalid_data_dialog_title);

  static String invalidDataDialogContent(BuildContext context) => _translate(context, AppKeys.invalid_data_dialog_content);

  /// AppBar titles
  static String addConsumable(BuildContext context) => _translate(context, AppKeys.add_an_item);

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

  static String dailyNotificationTitle(BuildContext context) => _translate(context, AppKeys.daily_notif_title);

  static String dailyNotificationBody(BuildContext context) => _translate(context, AppKeys.daily_notif_body);

  static String dailyNotificationTimePickerHelperText(BuildContext context) => _translate(context, AppKeys.daily_notif_time_picker_helper_text);

  /// Tooltips
  static String toggleModeTooltip(BuildContext context) => _translate(context, AppKeys.toggle_mode_tooltip);

  static String switchLangTooltip(BuildContext context) => _translate(context, AppKeys.switch_language_tooltip);

  static String createFileTooltip(BuildContext context) => _translate(context, AppKeys.create_file_tooltip);

  static String infoTooltip(BuildContext context) => _translate(context, AppKeys.info_tooltip);

  static String switchToGridView(BuildContext context) => _translate(context, AppKeys.switch_to_grid_view);

  static String switchToListView(BuildContext context) => _translate(context, AppKeys.switch_to_list_view);

  static String switchedToGridView(BuildContext context) => _translate(context, AppKeys.switched_to_grid_view);

  static String switchedToListView(BuildContext context) => _translate(context, AppKeys.switched_to_list_view);

  static String sortByAlphaTooltip(BuildContext context) => _translate(context, AppKeys.sort_by_alpha_tooltip);

  static String sortByCategoryTooltip(BuildContext context) => _translate(context, AppKeys.sort_by_category_tooltip);

  static String sortBySeverityTooltip(BuildContext context) => _translate(context, AppKeys.sort_by_severity_tooltip);

  static String eraseDataTooltip(BuildContext context) => _translate(context, AppKeys.erase_data_tooltip);

  /// Lists
  static String nothingHere(BuildContext context) => _translate(context, AppKeys.nothing_here);

  static String tryToAddItems(BuildContext context) => _translate(context, AppKeys.try_to_add_items);

  /// App Tour
  static String tourTargetAppBarTextField(BuildContext context) => _translate(context, AppKeys.tour_target_app_bar_text_field);

  static String tourTargetList(BuildContext context) => _translate(context, AppKeys.tour_target_list);

  static String tourTargetCard(BuildContext context) => _translate(context, AppKeys.tour_target_card);

  static String tourTargetEditName(BuildContext context) => _translate(context, AppKeys.tour_target_edit_name);

  static String tourTargetResetItem(BuildContext context) => _translate(context, AppKeys.tour_target_reset_item);

  static String tourTargetRemoveItem(BuildContext context) => _translate(context, AppKeys.tour_target_remove_item);

  static String tourTargetTextFieldLastChanged(BuildContext context) => _translate(context, AppKeys.tour_target_text_field_last_changed);

  static String tourTargetTextFieldChangeInterval(BuildContext context) => _translate(context, AppKeys.tour_target_text_field_change_interval);

  static String tourTargetTextFieldRemaining(BuildContext context) => _translate(context, AppKeys.tour_target_text_field_remaining);

  static String tourTargetCardReorder(BuildContext context) => _translate(context, AppKeys.tour_target_card_reorder);

  static String tourTargetSaveData(BuildContext context) => _translate(context, AppKeys.tour_target_save_data);

  static String tourTargetAddItem(BuildContext context) => _translate(context, AppKeys.tour_target_add_item);

  static String tourTargetSwitchLang(BuildContext context) => _translate(context, AppKeys.tour_target_switch_lang);

  static String tourTargetToggleDetailedMode(BuildContext context) => _translate(context, AppKeys.tour_target_toggle_detailed_mode);

  static String tourTargetSaveToFile(BuildContext context) => _translate(context, AppKeys.tour_target_save_to_file);

  static String tourTargetResetAllCards(BuildContext context) => _translate(context, AppKeys.tour_target_reset_all_cards);

  static String tourTargetRemoveAllCards(BuildContext context) => _translate(context, AppKeys.tour_target_remove_all_cards);

  static String tourTargetInfo(BuildContext context) => _translate(context, AppKeys.tour_target_info);

  static String tourTargetGridItem(BuildContext context) => _translate(context, AppKeys.tour_target_grid_item);

  static String tourTargetSwitchListGrid(BuildContext context) => _translate(context, AppKeys.tour_target_switch_list_grid);

  /// Error handling
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';
}
