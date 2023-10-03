import 'package:car_note/src/core/errors/exceptions.dart';
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/features/intro/data/data_sources/lang_local_data_source.dart';
import 'package:car_note/src/features/intro/domain/repositories/lang_repository.dart';
import 'package:dartz/dartz.dart';

class LangRepositoryImpl implements LangRepository {
  final LangLocalDataSource langLocalDataSource;

  LangRepositoryImpl({required this.langLocalDataSource});

  @override
  Future<Either<Failure, bool>> changeLang({required String langCode}) async {
    try {
      final langIsChanged = await langLocalDataSource.changeLang(langCode: langCode);
      return Right(langIsChanged);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      final langCode = await langLocalDataSource.getSavedLang();
      return Right(langCode);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
