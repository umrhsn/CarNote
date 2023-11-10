import 'package:car_note/src/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class LangRepository {
  Future<Either<Failure, bool>> changeLang({required String langCode});

  Future<Either<Failure, String>> getSavedLang();
}
