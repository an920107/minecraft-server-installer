import 'dart:typed_data';

abstract interface class VanillaFileStorage {
  Future<void> saveFile(Uint8List fileBytes, String savePath);
}
