// lib/src/features/consumables/domain/repositories/consumable_repository.dart
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:dartz/dartz.dart';

abstract class ConsumableRepository {
  Future<Either<Failure, void>> saveConsumables(List<Consumable> consumables);

  Either<Failure, List<Consumable>> getConsumables();

  Future<Either<Failure, bool>> addConsumable(Consumable consumable);

  Either<Failure, void> removeConsumable(int index);

  Either<Failure, void> resetConsumable(int index);

  Either<Failure, void> resetAllConsumables();

  Either<Failure, void> removeAllConsumables();

  Either<Failure, void> reorderConsumables(int oldIndex, int newIndex);

  Either<Failure, bool> updateConsumableName(int index, String name);
}
