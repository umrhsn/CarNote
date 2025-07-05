// lib/src/core/errors/failures.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([String message = 'Database operation failed'])
      : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache operation failed'])
      : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure([String message = 'Validation failed'])
      : super(message);
}

class NotificationFailure extends Failure {
  const NotificationFailure([String message = 'Notification operation failed'])
      : super(message);
}

class FileFailure extends Failure {
  const FileFailure([String message = 'File operation failed'])
      : super(message);
}
