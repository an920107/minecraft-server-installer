import 'package:minecraft_server_installer/vanilla/domain/entity/game_version.dart';

abstract interface class VanillaRepository {
  Future<List<GameVersion>> getGameVersionList();
}
