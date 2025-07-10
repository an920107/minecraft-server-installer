import 'package:minecraft_server_installer/vanilla/adapter/gateway/vanilla_api_service.dart';
import 'package:minecraft_server_installer/vanilla/adapter/gateway/vanilla_file_storage.dart';
import 'package:minecraft_server_installer/vanilla/application/repository/vanilla_repository.dart';
import 'package:minecraft_server_installer/vanilla/application/use_case/download_server_file_use_case.dart';
import 'package:minecraft_server_installer/vanilla/domain/entity/game_version.dart';

class VanillaRepositoryImpl implements VanillaRepository {
  final VanillaApiService _gameVersionApiService;
  final VanillaFileStorage _gameVersionFileStorage;

  VanillaRepositoryImpl(this._gameVersionApiService, this._gameVersionFileStorage);

  @override
  Future<List<GameVersion>> getGameVersionList() => _gameVersionApiService.fetchGameVersionList();

  @override
  Future<void> downloadServerFile(
    GameVersion version,
    String savePath, {
    DownloadProgressCallback? onProgressChanged,
  }) async {
    final fileBytes = await _gameVersionApiService.fetchServerFile(
      version.url,
      onProgressChanged: onProgressChanged,
    );
    await _gameVersionFileStorage.saveFile(fileBytes, savePath);
  }
}
