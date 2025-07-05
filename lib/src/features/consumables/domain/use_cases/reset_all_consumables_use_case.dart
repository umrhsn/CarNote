// lib/src/features/consumables/domain/use_cases/reset_all_consumables_use_case.dart
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/consumables/domain/repositories/consumable_repository.dart';
import 'package:dartz/dartz.dart';

class ResetAllConsumablesUseCase implements UseCase<void, NoParams> {
  final ConsumableRepository repository;

  ResetAllConsumablesUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return Future.value(repository.resetAllConsumables());
  }
}
