import 'dart:io';
import 'dart:typed_data';

import 'package:minecraft_server_installer/vanilla/adapter/gateway/vanilla_file_storage.dart';

class VanillaFileStorageImpl implements VanillaFileStorage {
  @override
  Future<void> saveFile(Uint8List fileBytes, String savePath) async {
    final file = File(savePath);

    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }

    await file.create();
    await file.writeAsBytes(fileBytes, flush: true);
  }
}
