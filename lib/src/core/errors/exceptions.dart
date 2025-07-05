// lib/src/core/errors/exceptions.dart
import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class DatabaseException extends ServerException {
  const DatabaseException([String? message])
      : super(message ?? "Database operation failed");
}

class CacheException extends ServerException {
  const CacheException([String? message])
      : super(message ?? "Cache operation failed");
}

class ValidationException extends ServerException {
  const ValidationException([String? message])
      : super(message ?? "Validation failed");
}

class NotificationException extends ServerException {
  const NotificationException([String? message])
      : super(message ?? "Notification operation failed");
}

class FileException extends ServerException {
  const FileException([String? message])
      : super(message ?? "File operation failed");
}

// Keep existing exceptions for backward compatibility
class FetchDataException extends ServerException {
  const FetchDataException([message]) : super("Error During Communication");
}

class BadRequestException extends ServerException {
  const BadRequestException([message]) : super("Bad Request");
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([message]) : super("Unauthorized");
}

class NotFoundException extends ServerException {
  const NotFoundException([message]) : super("Requested Info Not Found");
}

class ConflictException extends ServerException {
  const ConflictException([message]) : super("Conflict Occurred");
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([message])
      : super("Internal Server Error");
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([message])
      : super("No Internet Connection");
}
