import 'dart:typed_data';

abstract interface class InstallationFileStorage {
  Future<void> saveFile(Uint8List fileBytes, String path);

  Future<void> writeFile(String path, String content);

  Future<void> grantFileExecutePermission(String path);
}
