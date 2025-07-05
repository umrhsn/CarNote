// lib/src/features/consumables/data/repositories/consumable_repository_impl.dart
import 'package:car_note/src/core/errors/exceptions.dart';
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/features/consumables/data/data_sources/consumable_local_data_source.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/domain/repositories/consumable_repository.dart';
import 'package:dartz/dartz.dart';

class ConsumableRepositoryImpl implements ConsumableRepository {
  final ConsumableLocalDataSource localDataSource;

  ConsumableRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> saveConsumables(
      List<Consumable> consumables) async {
    try {
      await localDataSource.saveConsumables(consumables);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message ?? 'Failed to save consumables'));
    } catch (e) {
      return Left(DatabaseFailure(
          'Unexpected error occurred while saving consumables'));
    }
  }

  @override
  Either<Failure, List<Consumable>> getConsumables() {
    try {
      final consumables = localDataSource.getConsumables();
      return Right(consumables);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message ?? 'Failed to get consumables'));
    } catch (e) {
      return Left(DatabaseFailure(
          'Unexpected error occurred while getting consumables'));
    }
  }

  @override
  Future<Either<Failure, bool>> addConsumable(Consumable consumable) async {
    try {
      final result = await localDataSource.addConsumable(consumable);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message ?? 'Failed to add consumable'));
    } catch (e) {
      return Left(
          DatabaseFailure('Unexpected error occurred while adding consumable'));
    }
  }

  @override
  Either<Failure, void> removeConsumable(int index) {
    try {
      localDataSource.removeConsumable(index);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message ?? 'Failed to remove consumable'));
    } catch (e) {
      return Left(DatabaseFailure(
          'Unexpected error occurred while removing consumable'));
    }
  }

  @override
  Either<Failure, void> resetConsumable(int index) {
    try {
      localDataSource.resetConsumable(index);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message ?? 'Failed to reset consumable'));
    } catch (e) {
      return Left(DatabaseFailure(
          'Unexpected error occurred while resetting consumable'));
    }
  }

  @override
  Either<Failure, void> resetAllConsumables() {
    try {
      localDataSource.resetAllConsumables();
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(
          DatabaseFailure(e.message ?? 'Failed to reset all consumables'));
    } catch (e) {
      return Left(DatabaseFailure(
          'Unexpected error occurred while resetting all consumables'));
    }
  }

  @override
  Either<Failure, void> removeAllConsumables() {
    try {
      localDataSource.removeAllConsumables();
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(
          DatabaseFailure(e.message ?? 'Failed to remove all consumables'));
    } catch (e) {
      return Left(DatabaseFailure(
          'Unexpected error occurred while removing all consumables'));
    }
  }

  @override
  Either<Failure, void> reorderConsumables(int oldIndex, int newIndex) {
    try {
      localDataSource.reorderConsumables(oldIndex, newIndex);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(
          DatabaseFailure(e.message ?? 'Failed to reorder consumables'));
    } catch (e) {
      return Left(DatabaseFailure(
          'Unexpected error occurred while reordering consumables'));
    }
  }

  @override
  Either<Failure, bool> updateConsumableName(int index, String name) {
    try {
      final result = localDataSource.updateConsumableName(index, name);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(
          DatabaseFailure(e.message ?? 'Failed to update consumable name'));
    } catch (e) {
      return Left(DatabaseFailure(
          'Unexpected error occurred while updating consumable name'));
    }
  }
}
