import 'package:minecraft_server_installer/vanila/adapter/gateway/game_version_api_service.dart';
import 'package:minecraft_server_installer/vanila/adapter/gateway/game_version_file_storage.dart';
import 'package:minecraft_server_installer/vanila/application/repository/game_version_repository.dart';
import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

class GameVersionRepositoryImpl implements GameVersionRepository {
  final GameVersionApiService _gameVersionApiService;
  final GameVersionFileStorage _gameVersionFileStorage;

  GameVersionRepositoryImpl(this._gameVersionApiService, this._gameVersionFileStorage);

  @override
  Future<List<GameVersion>> getGameVersionList() => _gameVersionApiService.fetchGameVersionList();

  @override
  Future<void> downloadServerFile(GameVersion version, String savePath) async {
    final fileBytes = await _gameVersionApiService.fetchServerFile(version.url);
    await _gameVersionFileStorage.saveFile(fileBytes, savePath);
  }
}
