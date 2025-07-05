import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/features/info/domain/entities/dashboard_item.dart';
import 'package:dartz/dartz.dart';

abstract class InfoRepository {
  Either<Failure, List<DashboardItem>> getDashboardItems();
  Either<Failure, List<DashboardItem>> getDashboardItemsByCategory(int category);
  Either<Failure, List<DashboardItem>> searchDashboardItems(String query);
  Either<Failure, List<DashboardItem>> sortDashboardItems(List<DashboardItem> items, String sortBy);
}
