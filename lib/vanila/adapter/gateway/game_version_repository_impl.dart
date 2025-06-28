import 'package:minecraft_server_installer/vanila/adapter/gateway/game_version_api_service.dart';
import 'package:minecraft_server_installer/vanila/application/repository/game_version_repository.dart';
import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

class GameVersionRepositoryImpl implements GameVersionRepository {
  final GameVersionApiService _gameVersionApiService;

  GameVersionRepositoryImpl(this._gameVersionApiService);

  @override
  Future<List<GameVersion>> getGameVersionList() => _gameVersionApiService.fetchGameVersionList();
}
