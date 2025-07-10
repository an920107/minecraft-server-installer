import 'dart:typed_data';

import 'package:minecraft_server_installer/main/application/repository/installation_repository.dart';

abstract interface class InstallationApiService {
  Future<Uint8List> fetchRemoteFile(Uri url, {DownloadProgressCallback? onProgressChanged});
}
