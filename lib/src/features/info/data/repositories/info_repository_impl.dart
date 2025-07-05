import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/features/info/data/data_sources/info_local_data_source.dart';
import 'package:car_note/src/features/info/domain/entities/dashboard_item.dart';
import 'package:car_note/src/features/info/domain/repositories/info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class InfoRepositoryImpl implements InfoRepository {
  final InfoLocalDataSource localDataSource;
  final BuildContext context;

  InfoRepositoryImpl({
    required this.localDataSource,
    required this.context,
  });

  @override
  Either<Failure, List<DashboardItem>> getDashboardItems() {
    try {
      final dashboardItems = localDataSource.getDashboardItems(context);
      return Right(dashboardItems);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get dashboard items'));
    }
  }

  @override
  Either<Failure, List<DashboardItem>> getDashboardItemsByCategory(int category) {
    try {
      final dashboardItems = localDataSource.getDashboardItemsByCategory(context, category);
      return Right(dashboardItems);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get dashboard items by category'));
    }
  }

  @override
  Either<Failure, List<DashboardItem>> searchDashboardItems(String query) {
    try {
      final dashboardItems = localDataSource.searchDashboardItems(context, query);
      return Right(dashboardItems);
    } catch (e) {
      return Left(DatabaseFailure('Failed to search dashboard items'));
    }
  }

  @override
  Either<Failure, List<DashboardItem>> sortDashboardItems(List<DashboardItem> items, String sortBy) {
    try {
      final sortedItems = localDataSource.sortDashboardItems(items, sortBy);
      return Right(sortedItems);
    } catch (e) {
      return Left(DatabaseFailure('Failed to sort dashboard items'));
    }
  }
}
