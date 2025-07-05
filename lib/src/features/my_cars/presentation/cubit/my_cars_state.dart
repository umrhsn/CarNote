part of 'my_cars_cubit.dart';

abstract class MyCarsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MyCarsInitial extends MyCarsState {}

class MyCarsLoading extends MyCarsState {}

class MyCarsLoaded extends MyCarsState {
  final List<CarListItem> cars;

  MyCarsLoaded(this.cars);

  @override
  List<Object?> get props => [cars];
}

class MyCarsError extends MyCarsState {
  final String message;

  MyCarsError(this.message);

  @override
  List<Object?> get props => [message];
}

class MyCarsActiveCarLoaded extends MyCarsState {
  final CarListItem? activeCar;

  MyCarsActiveCarLoaded(this.activeCar);

  @override
  List<Object?> get props => [activeCar];
}

class MyCarsAdding extends MyCarsState {}

class MyCarsCarAdded extends MyCarsState {
  final CarListItem car;

  MyCarsCarAdded(this.car);

  @override
  List<Object?> get props => [car];
}

class MyCarsDeleting extends MyCarsState {}

class MyCarsCarDeleted extends MyCarsState {
  final String carId;

  MyCarsCarDeleted(this.carId);

  @override
  List<Object?> get props => [carId];
}

class MyCarsCarSelected extends MyCarsState {
  final CarListItem car;

  MyCarsCarSelected(this.car);

  @override
  List<Object?> get props => [car];
}
