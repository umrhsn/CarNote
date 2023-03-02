part of 'consumable_cubit.dart';

@immutable
abstract class ConsumableState extends Equatable {
  const ConsumableState();

  @override
  List<Object> get props => [];
}

class AppInitial extends ConsumableState {}

class AddingChangeKm extends ConsumableState {}

class AddedChangeKm extends ConsumableState {}

class ValidatingItem extends ConsumableState {}

class ValidatingComplete extends ConsumableState {}

class Calculating extends ConsumableState {}

class VisibilityChanging extends ConsumableState {}

class VisibilityChanged extends ConsumableState {}
