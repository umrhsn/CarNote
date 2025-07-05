// lib/src/features/consumables/presentation/cubit/consumable_state.dart
part of 'consumable_cubit.dart';

@immutable
abstract class ConsumableState extends Equatable {
  const ConsumableState();

  @override
  List<Object> get props => [];
}

class AppInitial extends ConsumableState {}

class AppLoading extends ConsumableState {}

class AppError extends ConsumableState {
  final String message;

  const AppError(this.message);

  @override
  List<Object> get props => [message];
}

class SavingData extends ConsumableState {}

class DataSaved extends ConsumableState {}

class ConsumableAdded extends ConsumableState {}

class ConsumableRemoved extends ConsumableState {}

class ConsumableReset extends ConsumableState {}

class AllConsumablesReset extends ConsumableState {}

class AllConsumablesRemoved extends ConsumableState {}

class ConsumablesReordered extends ConsumableState {}

class ConsumableNameUpdated extends ConsumableState {}

class AddingRemainingKm extends ConsumableState {}

class AddedRemainingKm extends ConsumableState {}

class ValidatingItem extends ConsumableState {}

class ValidatingComplete extends ConsumableState {}

class Calculating extends ConsumableState {}

class VisibilityChanging extends ConsumableState {}

class VisibilityChanged extends ConsumableState {}
