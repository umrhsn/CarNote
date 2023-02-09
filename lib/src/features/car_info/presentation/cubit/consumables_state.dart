part of 'consumables_cubit.dart';

@immutable
abstract class ConsumablesState {}

class ConsumablesInitial extends ConsumablesState {}

class AddingChangeKilometer extends ConsumablesState {}

class AddedChangeKilometer extends ConsumablesState {}

class Validating extends ConsumablesState {}

class ValidatingComplete extends ConsumablesState {}

class ValidatingChangeKm extends ConsumablesState {}

class ValidatingChangeKmComplete extends ConsumablesState {}

class ValidatingLastChangedKm extends ConsumablesState {}

class ValidatingLastChangedKmComplete extends ConsumablesState {}
