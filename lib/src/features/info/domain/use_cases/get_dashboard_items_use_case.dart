import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/info/domain/entities/dashboard_item.dart';
import 'package:car_note/src/features/info/domain/repositories/info_repository.dart';
import 'package:dartz/dartz.dart';

class GetDashboardItemsUseCase
    implements UseCase<List<DashboardItem>, NoParams> {
  final InfoRepository repository;

  GetDashboardItemsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<DashboardItem>>> call(NoParams params) async {
    return Future.value(repository.getDashboardItems());
  }
}
