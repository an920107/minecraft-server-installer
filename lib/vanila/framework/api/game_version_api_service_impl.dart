import 'package:http/http.dart' as http;
import 'package:minecraft_server_installer/vanila/adapter/gateway/game_version_api_service.dart';
import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

class GameVersionApiServiceImpl implements GameVersionApiService {
  @override
  Future<List<GameVersion>> fetchGameVersionList() async {
    final sourceUrl = Uri.parse('https://www.dropbox.com/s/mtz3moc9dpjtz7s/GameVersions.txt?dl=1');
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
