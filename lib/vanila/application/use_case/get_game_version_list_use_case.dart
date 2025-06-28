import 'package:minecraft_server_installer/vanila/application/repository/game_version_repository.dart';
import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

class GetGameVersionListUseCase {
  final GameVersionRepository _gameVersionRepository;

  GetGameVersionListUseCase(this._gameVersionRepository);

  Future<List<GameVersion>> call() => _gameVersionRepository.getGameVersionList();
}
