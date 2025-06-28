import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

abstract interface class GameVersionRepository {
  Future<List<GameVersion>> getGameVersionList();
}
