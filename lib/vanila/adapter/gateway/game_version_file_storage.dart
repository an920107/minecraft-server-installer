import 'dart:typed_data';

abstract interface class GameVersionFileStorage {
  Future<void> saveFile(Uint8List fileBytes, String savePath);
}
