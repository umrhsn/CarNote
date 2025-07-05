// lib/src/features/car_info/presentation/cubit/car_state.dart
part of 'car_cubit.dart';

abstract class CarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarLoaded extends CarState {
  final Car? car;

  CarLoaded(this.car);

  @override
  List<Object?> get props => [car];
}

class CarSaved extends CarState {}

class CarError extends CarState {
  final String message;

  CarError(this.message);

  @override
  List<Object?> get props => [message];
}
