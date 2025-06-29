import 'package:minecraft_server_installer/vanila/application/repository/game_version_repository.dart';
import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

class DownloadServerFileUseCase {
  final GameVersionRepository _gameVersionRepository;

  DownloadServerFileUseCase(this._gameVersionRepository);

  Future<void> call(GameVersion version, String savePath) => _gameVersionRepository.downloadServerFile(version, savePath);
}
