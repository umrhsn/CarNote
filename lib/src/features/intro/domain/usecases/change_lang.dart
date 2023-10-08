import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/usecases/usecase.dart';
import 'package:car_note/src/features/intro/domain/repositories/lang_repository.dart';
import 'package:dartz/dartz.dart';

class ChangeLangUseCase implements UseCase<bool, String> {
  final LangRepository langRepository;

  ChangeLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, bool>> call(String langCode) async => await langRepository.changeLang(langCode: langCode);
}
