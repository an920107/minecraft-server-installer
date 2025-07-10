import 'package:minecraft_server_installer/vanilla/application/repository/vanilla_repository.dart';
import 'package:minecraft_server_installer/vanilla/domain/entity/game_version.dart';

class GetGameVersionListUseCase {
  final VanillaRepository _gameVersionRepository;

  GetGameVersionListUseCase(this._gameVersionRepository);

  Future<List<GameVersion>> call() => _gameVersionRepository.getGameVersionList();
}
