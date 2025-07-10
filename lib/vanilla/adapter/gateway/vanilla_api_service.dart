import 'package:minecraft_server_installer/vanilla/domain/entity/game_version.dart';

abstract interface class VanillaApiService {
  Future<List<GameVersion>> fetchGameVersionList();
}
