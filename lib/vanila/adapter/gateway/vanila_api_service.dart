import 'dart:typed_data';

import 'package:minecraft_server_installer/vanila/application/use_case/download_server_file_use_case.dart';
import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

abstract interface class VanilaApiService {
  Future<List<GameVersion>> fetchGameVersionList();

  Future<Uint8List> fetchServerFile(Uri url, {DownloadProgressCallback? onProgressChanged});
}
