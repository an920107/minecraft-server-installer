import 'dart:typed_data';

import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

abstract interface class GameVersionApiService {
  Future<List<GameVersion>> fetchGameVersionList();

  Future<Uint8List> fetchServerFile(Uri url);
}
