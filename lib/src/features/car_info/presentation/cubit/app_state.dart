part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AddingChangeKm extends AppState {}

class AddedChangeKm extends AppState {}

class ValidatingItem extends AppState {}

class ValidatingComplete extends AppState {}

// class DbInitialized extends AppState {}
//
// class DbLoading extends AppState {}
//
// class DbLoaded extends AppState {}
//
// class DbConsumableCreated extends AppState {}
