import 'dart:typed_data';

abstract interface class VanilaFileStorage {
  Future<void> saveFile(Uint8List fileBytes, String savePath);
}
