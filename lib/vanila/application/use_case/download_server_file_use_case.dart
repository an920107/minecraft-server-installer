import 'package:minecraft_server_installer/vanila/application/repository/vanila_repository.dart';
import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

typedef DownloadProgressCallback = void Function(double progress);

class DownloadServerFileUseCase {
  final VanilaRepository _gameVersionRepository;

  DownloadServerFileUseCase(this._gameVersionRepository);

  Future<void> call(GameVersion version, String savePath, {DownloadProgressCallback? onProgressChanged}) =>
      _gameVersionRepository.downloadServerFile(version, savePath, onProgressChanged: onProgressChanged);
}
