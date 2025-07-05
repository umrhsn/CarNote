// lib/src/features/consumables/domain/use_cases/reorder_consumables_use_case.dart
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/consumables/domain/repositories/consumable_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ReorderConsumablesParams extends Equatable {
  final int oldIndex;
  final int newIndex;

  const ReorderConsumablesParams(
      {required this.oldIndex, required this.newIndex});

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class ReorderConsumablesUseCase
    implements UseCase<void, ReorderConsumablesParams> {
  final ConsumableRepository repository;

  ReorderConsumablesUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(ReorderConsumablesParams params) async {
    return Future.value(
        repository.reorderConsumables(params.oldIndex, params.newIndex));
  }
}
