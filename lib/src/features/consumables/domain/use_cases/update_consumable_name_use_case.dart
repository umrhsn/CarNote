// lib/src/features/consumables/domain/use_cases/update_consumable_name_use_case.dart
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/consumables/domain/repositories/consumable_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateConsumableNameParams extends Equatable {
  final int index;
  final String name;

  const UpdateConsumableNameParams({required this.index, required this.name});

  @override
  List<Object?> get props => [index, name];
}

class UpdateConsumableNameUseCase
    implements UseCase<bool, UpdateConsumableNameParams> {
  final ConsumableRepository repository;

  UpdateConsumableNameUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(UpdateConsumableNameParams params) async {
    return Future.value(
        repository.updateConsumableName(params.index, params.name));
  }
}
