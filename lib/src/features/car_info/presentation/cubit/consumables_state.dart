part of 'consumables_cubit.dart';

@immutable
abstract class ConsumablesState {}

class ConsumablesInitial extends ConsumablesState {}

class AddingChangeKilometer extends ConsumablesState {}

class AddedChangeKilometer extends ConsumablesState {}
