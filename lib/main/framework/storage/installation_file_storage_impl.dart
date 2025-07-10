import 'dart:io';
import 'dart:typed_data';

import 'package:minecraft_server_installer/main/adapter/gateway/installation_file_storage.dart';

class InstallationFileStorageImpl implements InstallationFileStorage {
  @override
  Future<void> saveFile(Uint8List fileBytes, String path) async {
    final file = File(path);

    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }

    await file.create();
    await file.writeAsBytes(fileBytes, flush: true);
  }
}
