// lib/src/features/consumables/domain/use_cases/get_consumables_use_case.dart
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/domain/repositories/consumable_repository.dart';
import 'package:dartz/dartz.dart';

class GetConsumablesUseCase implements UseCase<List<Consumable>, NoParams> {
  final ConsumableRepository repository;

  GetConsumablesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Consumable>>> call(NoParams params) async {
    return Future.value(repository.getConsumables());
  }
}
