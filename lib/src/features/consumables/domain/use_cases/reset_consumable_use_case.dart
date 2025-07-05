// lib/src/features/consumables/domain/use_cases/reset_consumable_use_case.dart
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/consumables/domain/repositories/consumable_repository.dart';
import 'package:dartz/dartz.dart';

class ResetConsumableUseCase implements UseCase<void, int> {
  final ConsumableRepository repository;

  ResetConsumableUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(int params) async {
    return Future.value(repository.resetConsumable(params));
  }
}
