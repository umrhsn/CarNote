// lib/src/core/services/file/file_service_impl.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:car_note/src/core/services/file/file_service.dart';
import 'package:file_saver/file_saver.dart';

class FileServiceImpl implements FileService {
  final FileSaver fileSaver;

  FileServiceImpl({required this.fileSaver});

  @override
  Future<bool> writeDataToFile(String fileName, String data) async {
    try {
      await fileSaver.saveFile(
        name: fileName,
        bytes: Uint8List.fromList(utf8.encode(data)),
        ext: 'txt',
        mimeType: MimeType.text,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
