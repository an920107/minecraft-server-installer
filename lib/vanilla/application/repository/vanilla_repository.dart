import 'package:minecraft_server_installer/vanilla/application/use_case/download_server_file_use_case.dart';
import 'package:minecraft_server_installer/vanilla/domain/entity/game_version.dart';

abstract interface class VanillaRepository {
  Future<List<GameVersion>> getGameVersionList();

  Future<void> downloadServerFile(GameVersion version, String savePath, {DownloadProgressCallback? onProgressChanged});
}
