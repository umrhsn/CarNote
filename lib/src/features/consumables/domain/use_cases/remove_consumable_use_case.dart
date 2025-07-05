// lib/src/features/consumables/domain/use_cases/remove_consumable_use_case.dart
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/consumables/domain/repositories/consumable_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveConsumableUseCase implements UseCase<void, int> {
  final ConsumableRepository repository;

  RemoveConsumableUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(int params) async {
    return Future.value(repository.removeConsumable(params));
  }
}
