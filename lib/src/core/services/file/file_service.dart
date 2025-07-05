// lib/src/core/services/file/file_service.dart
abstract class FileService {
  Future<bool> writeDataToFile(String fileName, String data);
}
