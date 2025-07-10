import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:minecraft_server_installer/main/constants.dart';
import 'package:minecraft_server_installer/vanilla/adapter/gateway/vanilla_api_service.dart';
import 'package:minecraft_server_installer/vanilla/domain/entity/game_version.dart';

class VanillaApiServiceImpl implements VanillaApiService {
  @override
  Future<List<GameVersion>> fetchGameVersionList() async {
    final sourceUrl = Uri.parse(Constants.gameVersionListUrl);
    final response = await http.get(sourceUrl);

    final rawGameVersionList = response.body.split('\n');
    final gameVersionList =
        rawGameVersionList.map((line) => line.split(' ')).where((parts) => parts.length == 2).map((parts) {
          final [name, url] = parts;
          return GameVersion(name: name, url: Uri.parse(url));
        }).toList();

    return gameVersionList;
  }
}
