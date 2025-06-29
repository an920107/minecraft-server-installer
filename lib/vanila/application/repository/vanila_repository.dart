import 'package:minecraft_server_installer/vanila/application/use_case/download_server_file_use_case.dart';
import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

abstract interface class VanilaRepository {
  Future<List<GameVersion>> getGameVersionList();

  Future<void> downloadServerFile(GameVersion version, String savePath, {DownloadProgressCallback? onProgressChanged});
}
