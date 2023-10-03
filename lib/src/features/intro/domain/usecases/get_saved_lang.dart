import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/usecases/usecase.dart';
import 'package:car_note/src/features/intro/domain/repositories/lang_repository.dart';
import 'package:dartz/dartz.dart';

class GetSavedLangUseCase implements UseCase<String, NoParams> {
  final LangRepository langRepository;

  GetSavedLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async => await langRepository.getSavedLang();
}
