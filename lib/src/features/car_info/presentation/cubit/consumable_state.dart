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

// class DbInitialized extends AppState {}
//
// class DbLoading extends AppState {}
//
// class DbLoaded extends AppState {}
//
// class DbConsumableCreated extends AppState {}
