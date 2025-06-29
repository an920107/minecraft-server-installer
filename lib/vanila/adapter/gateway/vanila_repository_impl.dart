import 'package:minecraft_server_installer/vanila/adapter/gateway/vanila_api_service.dart';
import 'package:minecraft_server_installer/vanila/adapter/gateway/vanila_file_storage.dart';
import 'package:minecraft_server_installer/vanila/application/repository/vanila_repository.dart';
import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

class VanilaRepositoryImpl implements VanilaRepository {
  final VanilaApiService _gameVersionApiService;
  final VanilaFileStorage _gameVersionFileStorage;

  VanilaRepositoryImpl(this._gameVersionApiService, this._gameVersionFileStorage);

  @override
  Future<List<GameVersion>> getGameVersionList() => _gameVersionApiService.fetchGameVersionList();

  @override
  Future<void> downloadServerFile(GameVersion version, String savePath) async {
    final fileBytes = await _gameVersionApiService.fetchServerFile(version.url);
    await _gameVersionFileStorage.saveFile(fileBytes, savePath);
  }
}
