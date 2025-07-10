import 'dart:io';
import 'dart:typed_data';

import 'package:minecraft_server_installer/main/adapter/gateway/installation_file_storage.dart';

class InstallationFileStorageImpl implements InstallationFileStorage {
  @override
  Future<void> saveFile(Uint8List fileBytes, String path) async {
    final file = File(path);
    await file.create(recursive: true, exclusive: false);
    await file.writeAsBytes(fileBytes, flush: true);
  }

  @override
  Future<void> writeFile(String path, String content) async {
    File file = File(path);
    await file.create(recursive: true, exclusive: false);
    await file.writeAsString(content, flush: true);
  }
}
