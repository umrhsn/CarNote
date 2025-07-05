// lib/src/features/consumables/domain/use_cases/save_consumables_use_case.dart
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/domain/repositories/consumable_repository.dart';
import 'package:dartz/dartz.dart';

class SaveConsumablesUseCase implements UseCase<void, List<Consumable>> {
  final ConsumableRepository repository;

  SaveConsumablesUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(List<Consumable> params) async {
    return await repository.saveConsumables(params);
  }
}
