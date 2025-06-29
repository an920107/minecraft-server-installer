import 'package:minecraft_server_installer/vanila/application/repository/vanila_repository.dart';
import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

class GetGameVersionListUseCase {
  final VanilaRepository _gameVersionRepository;

  GetGameVersionListUseCase(this._gameVersionRepository);

  Future<List<GameVersion>> call() => _gameVersionRepository.getGameVersionList();
}
