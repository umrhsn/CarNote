part of 'car_cubit.dart';

abstract class CarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CarInitial extends CarState {}

// TODO: move to Bloc instead of Provider

// class ValidatingItem extends CarState {}

// class ValidatingComplete extends CarState {}

// class CheckingBtnStatus extends CarState {}

// class CheckingBtnStatusComplete extends CarState {}

// class GettingValidatingText extends CarState {}
