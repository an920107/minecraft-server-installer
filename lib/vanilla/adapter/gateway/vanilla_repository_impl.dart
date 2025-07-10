import 'package:minecraft_server_installer/vanilla/adapter/gateway/vanilla_api_service.dart';
import 'package:minecraft_server_installer/vanilla/application/repository/vanilla_repository.dart';
import 'package:minecraft_server_installer/vanilla/domain/entity/game_version.dart';

class VanillaRepositoryImpl implements VanillaRepository {
  final VanillaApiService _gameVersionApiService;

  VanillaRepositoryImpl(this._gameVersionApiService);

  @override
  Future<List<GameVersion>> getGameVersionList() => _gameVersionApiService.fetchGameVersionList();
}
