// lib/src/features/consumables/domain/use_cases/add_consumable_use_case.dart
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/domain/repositories/consumable_repository.dart';
import 'package:dartz/dartz.dart';

class AddConsumableUseCase implements UseCase<bool, Consumable> {
  final ConsumableRepository repository;

  AddConsumableUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Consumable params) async {
    return await repository.addConsumable(params);
  }
}
