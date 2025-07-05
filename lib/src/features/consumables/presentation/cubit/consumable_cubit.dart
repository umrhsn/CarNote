// lib/src/features/consumables/presentation/cubit/consumable_cubit.dart
import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/services/notification/notifications_helper.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/app_texts.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/car_info/domain/use_cases/get_car_use_case.dart';
import 'package:car_note/src/features/car_info/domain/use_cases/save_car_use_case.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/add_consumable_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/get_consumables_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/remove_all_consumables_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/remove_consumable_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/reorder_consumables_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/reset_all_consumables_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/reset_consumable_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/save_consumables_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/update_consumable_name_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

part 'consumable_state.dart';

class ConsumableCubit extends Cubit<ConsumableState> {
  final GetConsumablesUseCase getConsumablesUseCase;
  final SaveConsumablesUseCase saveConsumablesUseCase;
  final AddConsumableUseCase addConsumableUseCase;
  final RemoveConsumableUseCase removeConsumableUseCase;
  final ResetConsumableUseCase resetConsumableUseCase;
  final ResetAllConsumablesUseCase resetAllConsumablesUseCase;
  final RemoveAllConsumablesUseCase removeAllConsumablesUseCase;
  final ReorderConsumablesUseCase reorderConsumablesUseCase;
  final UpdateConsumableNameUseCase updateConsumableNameUseCase;
  final GetCarUseCase getCarUseCase;
  final SaveCarUseCase saveCarUseCase;

  ConsumableCubit({
    required this.getConsumablesUseCase,
    required this.saveConsumablesUseCase,
    required this.addConsumableUseCase,
    required this.removeConsumableUseCase,
    required this.resetConsumableUseCase,
    required this.resetAllConsumablesUseCase,
    required this.removeAllConsumablesUseCase,
    required this.reorderConsumablesUseCase,
    required this.updateConsumableNameUseCase,
    required this.getCarUseCase,
    required this.saveCarUseCase,
  }) : super(AppInitial()) {
    _initializeConsumables();
  }

  /// Easy access object of Cubit
  static ConsumableCubit get(BuildContext context) =>
      BlocProvider.of<ConsumableCubit>(context);

  /// Main fields
  final TextEditingController currentKmController = TextEditingController();
  final List<TextEditingController> lastChangedAtControllers = [];
  final List<TextEditingController> changeIntervalControllers = [];
  final List<TextEditingController> remainingKmControllers = [];

  final FocusNode currentKmFocus = FocusNode();
  final List<FocusNode> lastChangedAtFocuses = [];
  final List<FocusNode> changeIntervalFocuses = [];
  final List<FocusNode> remainingKmFocuses = [];

  /// Add Consumable Widget
  TextEditingController consumableNameController = TextEditingController();
  TextEditingController lastChangedController = TextEditingController();
  TextEditingController changeIntervalController = TextEditingController();
  FocusNode lastChangedFocus = FocusNode();
  FocusNode changeIntervalFocus = FocusNode();

  List<Consumable> _consumables = [];
  Car? _currentCar;

  void _initializeConsumables() async {
    await _loadCar();
    await _loadConsumables();
  }

  Future<void> _loadCar() async {
    final result = await getCarUseCase(NoParams());
    result.fold(
      (failure) => null,
      (car) {
        _currentCar = car;
        if (car != null) {
          currentKmController.text =
              car.currentKm != 0 ? car.currentKm.toThousands() : '';
        }
      },
    );
  }

  Future<void> _loadConsumables() async {
    final result = await getConsumablesUseCase(NoParams());
    result.fold(
      (failure) => emit(AppError(failure.message)),
      (consumables) {
        _consumables = consumables;
        _initializeControllers();
        emit(AppInitial());
      },
    );
  }

  void _initializeControllers() {
    // Clear existing controllers
    lastChangedAtControllers.clear();
    changeIntervalControllers.clear();
    remainingKmControllers.clear();
    lastChangedAtFocuses.clear();
    changeIntervalFocuses.clear();
    remainingKmFocuses.clear();

    for (int index = 0; index < _consumables.length; index++) {
      Consumable item = _consumables[index];

      lastChangedAtControllers.add(TextEditingController(
          text:
              item.lastChangedAt != 0 ? item.lastChangedAt.toThousands() : ''));
      changeIntervalControllers.add(TextEditingController(
          text: item.changeInterval != 0
              ? item.changeInterval.toThousands()
              : ''));
      remainingKmControllers.add(TextEditingController(
          text: item.remainingKm != 0
              ? item.remainingKm.toThousands()
              : lastChangedAtControllers[index].text.isNotEmpty &&
                      changeIntervalControllers[index].text.isNotEmpty
                  ? ''
                  : '0'));

      lastChangedAtFocuses.add(FocusNode());
      changeIntervalFocuses.add(FocusNode());
      remainingKmFocuses.add(FocusNode());
    }
  }

  bool shouldEnableButtons(BuildContext context) {
    for (int index = 0; index < lastChangedAtControllers.length; index++) {
      if (currentKmController.text.isEmpty ||
          AppTexts.getLastChangedKmValidatingText(context,
                      cubit: this, index: index)
                  .data !=
              '') {
        return false;
      }
    }
    return true;
  }

  /// Save consumables with current car
  Future<void> saveConsumablesData(BuildContext context) async {
    emit(SavingData());

    if (_currentCar != null) {
      // Update car with current km
      final updatedCar = Car(
        type: _currentCar!.type,
        modelYear: _currentCar!.modelYear,
        currentKm: int.parse(
            currentKmController.text.trim().removeThousandSeparator()),
      );

      await saveCarUseCase(updatedCar);
    }

    // Create updated consumables list
    List<Consumable> updatedConsumables = [];
    for (int index = 0; index < _consumables.length; index++) {
      updatedConsumables.add(Consumable(
        id: index,
        name: _consumables[index].name,
        lastChangedAt: lastChangedAtControllers[index].text.isNotEmpty
            ? int.parse(
                lastChangedAtControllers[index].text.removeThousandSeparator())
            : 0,
        changeInterval: changeIntervalControllers[index].text.isNotEmpty
            ? int.parse(
                changeIntervalControllers[index].text.removeThousandSeparator())
            : 0,
        remainingKm: remainingKmControllers[index].text.isNotEmpty
            ? int.parse(
                remainingKmControllers[index].text.removeThousandSeparator())
            : 0,
      ));
    }

    final result = await saveConsumablesUseCase(updatedConsumables);
    result.fold(
      (failure) {
        emit(AppError(failure.message));
        BotToast.showText(text: AppStrings.somethingWentWrong(context));
      },
      (_) {
        _consumables = updatedConsumables;
        emit(DataSaved());
        BotToast.showText(text: AppStrings.dataSavedSuccessfully(context));
      },
    );
  }

  /// Add consumable
  Future<void> addConsumable(
    BuildContext context, {
    required String name,
    required int lastChangedAt,
    required int changeInterval,
  }) async {
    if (name.isEmpty || lastChangedAt == 0 || changeInterval == 0) {
      BotToast.showText(text: AppStrings.invalidInput(context));
      return;
    }

    final consumable = Consumable(
      id: _consumables.length,
      name: name.trim(),
      lastChangedAt: lastChangedAt,
      changeInterval: changeInterval,
      remainingKm: 0,
    );

    final result = await addConsumableUseCase(consumable);
    result.fold(
      (failure) {
        emit(AppError(failure.message));
        BotToast.showText(text: AppStrings.somethingWentWrong(context));
      },
      (success) {
        if (success) {
          _consumables.add(consumable);

          // Add new controllers
          lastChangedAtControllers
              .add(TextEditingController(text: lastChangedAt.toThousands()));
          changeIntervalControllers
              .add(TextEditingController(text: changeInterval.toThousands()));
          remainingKmControllers.add(TextEditingController());

          lastChangedAtFocuses.add(FocusNode());
          changeIntervalFocuses.add(FocusNode());
          remainingKmFocuses.add(FocusNode());

          emit(ConsumableAdded());
          BotToast.showText(text: AppStrings.itemAdded(context));
        } else {
          emit(AppError('Failed to add consumable'));
          BotToast.showText(text: AppStrings.invalidInput(context));
        }
      },
    );
  }

  /// Remove consumable
  Future<void> removeConsumable(int index, BuildContext context) async {
    final result = await removeConsumableUseCase(index);
    result.fold(
      (failure) => emit(AppError(failure.message)),
      (_) {
        _consumables.removeAt(index);

        lastChangedAtControllers.removeAt(index);
        changeIntervalControllers.removeAt(index);
        remainingKmControllers.removeAt(index);

        lastChangedAtFocuses.removeAt(index);
        changeIntervalFocuses.removeAt(index);
        remainingKmFocuses.removeAt(index);

        emit(ConsumableRemoved());
        BotToast.showText(text: AppStrings.removedItemSuccessfully(context));
      },
    );
  }

  /// Reset consumable
  Future<void> resetConsumable(int index, BuildContext context) async {
    final result = await resetConsumableUseCase(index);
    result.fold(
      (failure) => emit(AppError(failure.message)),
      (_) {
        _consumables[index] = Consumable(
          id: _consumables[index].id,
          name: _consumables[index].name,
          lastChangedAt: 0,
          changeInterval: 0,
          remainingKm: 0,
        );

        lastChangedAtControllers[index].text = '';
        changeIntervalControllers[index].text = '';
        remainingKmControllers[index].text = '';

        emit(ConsumableReset());
        BotToast.showText(text: AppStrings.resetItemSuccessfully(context));
      },
    );
  }

  /// Reset all consumables
  Future<void> resetAllConsumables(BuildContext context) async {
    final result = await resetAllConsumablesUseCase(NoParams());
    result.fold(
      (failure) => emit(AppError(failure.message)),
      (_) {
        for (int index = 0; index < _consumables.length; index++) {
          _consumables[index] = Consumable(
            id: _consumables[index].id,
            name: _consumables[index].name,
            lastChangedAt: 0,
            changeInterval: 0,
            remainingKm: 0,
          );
          lastChangedAtControllers[index].text = '';
          changeIntervalControllers[index].text = '';
          remainingKmControllers[index].text = '';
        }

        emit(AllConsumablesReset());
        BotToast.showText(text: AppStrings.resetAllCards(context));
      },
    );
  }

  /// Remove all consumables
  Future<void> removeAllConsumables(BuildContext context) async {
    final result = await removeAllConsumablesUseCase(NoParams());
    result.fold(
      (failure) => emit(AppError(failure.message)),
      (_) {
        _consumables.clear();

        lastChangedAtControllers.clear();
        changeIntervalControllers.clear();
        remainingKmControllers.clear();

        lastChangedAtFocuses.clear();
        changeIntervalFocuses.clear();
        remainingKmFocuses.clear();

        emit(AllConsumablesRemoved());
        BotToast.showText(text: AppStrings.removedAllCards(context));
      },
    );
  }

  /// Reorder consumables
  Future<void> reorderConsumables(
      BuildContext context, int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) newIndex -= 1;

    final params =
        ReorderConsumablesParams(oldIndex: oldIndex, newIndex: newIndex);
    final result = await reorderConsumablesUseCase(params);

    result.fold(
      (failure) => emit(AppError(failure.message)),
      (_) {
        // Update local state
        final item = _consumables.removeAt(oldIndex);
        final lastChangedAt = int.parse(lastChangedAtControllers
            .removeAt(oldIndex)
            .text
            .removeThousandSeparator());
        final changeInterval = int.parse(changeIntervalControllers
            .removeAt(oldIndex)
            .text
            .removeThousandSeparator());
        final remainingKm = int.parse(remainingKmControllers
            .removeAt(oldIndex)
            .text
            .removeThousandSeparator());

        lastChangedAtFocuses.removeAt(oldIndex);
        changeIntervalFocuses.removeAt(oldIndex);
        remainingKmFocuses.removeAt(oldIndex);

        _consumables.insert(newIndex, item);
        lastChangedAtControllers.insert(
            newIndex, TextEditingController(text: lastChangedAt.toThousands()));
        changeIntervalControllers.insert(newIndex,
            TextEditingController(text: changeInterval.toThousands()));
        remainingKmControllers.insert(
            newIndex, TextEditingController(text: remainingKm.toThousands()));

        lastChangedAtFocuses.insert(newIndex, FocusNode());
        changeIntervalFocuses.insert(newIndex, FocusNode());
        remainingKmFocuses.insert(newIndex, FocusNode());

        emit(ConsumablesReordered());
      },
    );
  }

  /// Update consumable name
  Future<bool> updateConsumableName(BuildContext context, int index) async {
    if (consumableNameController.text.isEmpty) {
      return false;
    }

    final params = UpdateConsumableNameParams(
      index: index,
      name: consumableNameController.text,
    );

    final result = await updateConsumableNameUseCase(params);

    return result.fold(
      (failure) {
        emit(AppError(failure.message));
        return false;
      },
      (success) {
        if (success) {
          _consumables[index] = Consumable(
            id: _consumables[index].id,
            name: consumableNameController.text,
            lastChangedAt: _consumables[index].lastChangedAt,
            changeInterval: _consumables[index].changeInterval,
            remainingKm: _consumables[index].remainingKm,
          );
          emit(ConsumableNameUpdated());
          BotToast.showText(text: AppStrings.dataSavedSuccessfully(context));
        }
        return success;
      },
    );
  }

  /// Calculation and validation methods
  int _calculateRemainingKm(TextEditingController lastChangedAtKmController,
      TextEditingController changeIntervalController) {
    if (currentKmController.text.isNotEmpty &&
        lastChangedAtKmController.text.isNotEmpty &&
        changeIntervalController.text.isNotEmpty) {
      int changeKm = int.parse(
              lastChangedAtKmController.text.removeThousandSeparator()) +
          int.parse(changeIntervalController.text.removeThousandSeparator());
      return int.parse(currentKmController.text.removeThousandSeparator()) -
          changeKm;
    }
    return 0;
  }

  void getRemainingKm(int index) {
    emit(AddingRemainingKm());
    remainingKmControllers[index].text = currentKmController.text.isNotEmpty
        ? _calculateRemainingKm(lastChangedAtControllers[index],
                    changeIntervalControllers[index]) !=
                0
            ? _calculateRemainingKm(lastChangedAtControllers[index],
                        changeIntervalControllers[index]) <
                    0
                ? (_calculateRemainingKm(lastChangedAtControllers[index],
                            changeIntervalControllers[index]) *
                        -1)
                    .toThousands()
                : _calculateRemainingKm(lastChangedAtControllers[index],
                        changeIntervalControllers[index])
                    .toThousands()
            : lastChangedAtControllers[index].text.isNotEmpty &&
                    changeIntervalControllers[index].text.isNotEmpty
                ? '0'
                : ''
        : '';
    emit(AddedRemainingKm());
  }

  void validateAllLastChangedKilometerFields(BuildContext context) {
    emit(ValidatingItem());
    for (int index = 0; index < _consumables.length; index++) {
      validateLastChangedKilometer(index, context);
      getRemainingKm(index);
    }
    emit(ValidatingComplete());
  }

  void validateAllChangeKilometerFields(BuildContext context) {
    emit(ValidatingItem());
    for (int index = 0; index < _consumables.length; index++) {
      validateRemainingKilometer(index, context);
      getRemainingKm(index);
    }
    emit(ValidatingComplete());
  }

  String? validateCurrentKilometer(BuildContext context) {
    emit(ValidatingItem());
    if (currentKmController.text.isEmpty) {
      return AppStrings.invalidInput(context);
    }
    emit(ValidatingComplete());
    return null;
  }

  String? validateLastChangedKilometer(int index, BuildContext context) {
    emit(ValidatingItem());
    if (lastChangedAtControllers[index].text.isNotEmpty &&
        currentKmController.text.isNotEmpty) {
      if (int.parse(
              lastChangedAtControllers[index].text.removeThousandSeparator()) >
          int.parse(currentKmController.text.removeThousandSeparator())) {
        return AppStrings.invalidInput(context);
      }
    }
    emit(ValidatingComplete());
    return null;
  }

  int calculateRemainingKmAndCurrentKmDifference(int index) {
    if (currentKmController.text.isNotEmpty &&
        remainingKmControllers[index].text.isNotEmpty) {
      return int.parse(currentKmController.text.removeThousandSeparator()) -
          int.parse(
              remainingKmControllers[index].text.removeThousandSeparator());
    }
    return 0;
  }

  int _calculateChangeKmAndCurrentKmSum(int index) {
    if (currentKmController.text.isNotEmpty &&
        remainingKmControllers[index].text.isNotEmpty) {
      return int.parse(currentKmController.text.removeThousandSeparator()) +
          int.parse(
              remainingKmControllers[index].text.removeThousandSeparator());
    }
    return 0;
  }

  int calculateWarningDifference(int index) {
    if (currentKmController.text.isNotEmpty &&
        remainingKmControllers[index].text.isNotEmpty) {
      if (int.parse(currentKmController.text.removeThousandSeparator()) <
          int.parse(
              remainingKmControllers[index].text.removeThousandSeparator())) {
        return int.parse(
                remainingKmControllers[index].text.removeThousandSeparator()) -
            int.parse(currentKmController.text.removeThousandSeparator());
      }
    }
    return 0;
  }

  bool isNormalText(int index) {
    emit(Calculating());
    return currentKmController.text.isNotEmpty &&
        _calculateRemainingKm(lastChangedAtControllers[index],
                changeIntervalControllers[index]) <
            -500;
  }

  bool isConsiderText(int index) {
    emit(Calculating());
    return currentKmController.text.isNotEmpty &&
        _calculateRemainingKm(lastChangedAtControllers[index],
                changeIntervalControllers[index]) ==
            0 &&
        lastChangedAtControllers[index].text.isNotEmpty &&
        changeIntervalControllers[index].text.isNotEmpty;
  }

  bool isWarningText(int index) {
    emit(Calculating());
    return currentKmController.text.isNotEmpty &&
        _calculateRemainingKm(lastChangedAtControllers[index],
                changeIntervalControllers[index]) >=
            -500 &&
        _calculateRemainingKm(lastChangedAtControllers[index],
                changeIntervalControllers[index]) <
            0;
  }

  bool isErrorText(int index) {
    emit(Calculating());
    return _calculateRemainingKm(
            lastChangedAtControllers[index], changeIntervalControllers[index]) >
        0;
  }

  String? validateRemainingKilometer(int index, BuildContext context) {
    emit(ValidatingItem());
    if (isNormalText(index) || isWarningText(index)) {
      emit(ValidatingComplete());
      return '${AppStrings.normalAndWarningText(context)} ${_calculateChangeKmAndCurrentKmSum(index).toThousands()}';
    }
    if (isConsiderText(index)) {
      emit(ValidatingComplete());
      return AppStrings.considerText(context);
    }
    if (isErrorText(index)) {
      emit(ValidatingComplete());
      return '${AppStrings.errorText(context)} ${calculateRemainingKmAndCurrentKmDifference(index).toThousands()}';
    }
    emit(ValidatingComplete());
    return null;
  }

  /// Control widgets visibility
  void changeVisibility(BuildContext context) {
    bool visible =
        di.sl<SharedPreferences>().getBool(AppKeys.prefsBoolDetailedModeOn) ??
            true;
    emit(VisibilityChanging());
    visible = !visible;
    visible
        ? BotToast.showText(text: AppStrings.detailedModeOn(context))
        : BotToast.showText(text: AppStrings.detailedModeOff(context));
    di
        .sl<SharedPreferences>()
        .setBool(AppKeys.prefsBoolDetailedModeOn, visible);
    emit(VisibilityChanged());
  }

  Text getAddLastChangedKmValidatingText(BuildContext context) => Text(
        _validateAddLastChangedKilometer(context) ?? '',
        style: TextStyle(
          color: AppColors.getErrorColor(context),
          height: _validateAddLastChangedKilometer(context) != null ? 2 : 0,
          fontSize: 11,
        ),
      );

  String? _validateAddLastChangedKilometer(BuildContext context) {
    emit(ValidatingItem());
    if (lastChangedController.text.isNotEmpty) {
      if (int.parse(lastChangedController.text.removeThousandSeparator()) >
          int.parse(currentKmController.text.removeThousandSeparator())) {
        return AppStrings.invalidInput(context);
      }
    }
    emit(ValidatingComplete());
    return null;
  }

  bool shouldEnableAddButton(BuildContext context) {
    if (consumableNameController.text.isEmpty ||
        lastChangedController.text.isEmpty ||
        changeIntervalController.text.isEmpty) {
      return false;
    }
    if (_validateAddLastChangedKilometer(context) != null) return false;
    return true;
  }

// Method to manually trigger notifications (only when explicitly called)
  void triggerNotifications(BuildContext context) {
    debugPrint("🔔 ConsumableCubit: Manual notification trigger requested");
    NotificationsHelper.resetRateLimit(); // Reset rate limit for manual trigger
    NotificationsHelper.showAlarmingNotifications(context, this);
  }

// Getters for compatibility with existing UI
  List<Consumable> get consumables => _consumables;

  int get consumableCount => _consumables.length;
}
