import 'dart:io';
import 'dart:typed_data';

import 'package:minecraft_server_installer/vanila/adapter/gateway/game_version_file_storage.dart';

class GameVersionFileStorageImpl implements GameVersionFileStorage {
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
