import 'dart:typed_data';

import 'package:minecraft_server_installer/vanilla/application/use_case/download_server_file_use_case.dart';
import 'package:minecraft_server_installer/vanilla/domain/entity/game_version.dart';

abstract interface class VanillaApiService {
  Future<List<GameVersion>> fetchGameVersionList();

  Future<Uint8List> fetchServerFile(Uri url, {DownloadProgressCallback? onProgressChanged});
}
