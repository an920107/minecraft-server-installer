import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:minecraft_server_installer/main/constants.dart';
import 'package:minecraft_server_installer/vanila/adapter/gateway/vanila_api_service.dart';
import 'package:minecraft_server_installer/vanila/application/use_case/download_server_file_use_case.dart';
import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

class VanilaApiServiceImpl implements VanilaApiService {
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

  @override
  Future<Uint8List> fetchServerFile(Uri url, {DownloadProgressCallback? onProgressChanged}) async {
    final client = http.Client();
    final request = http.Request('GET', url);
    final response = await client.send(request);

    final contentLength = response.contentLength;
    final completer = Completer<Uint8List>();
    final bytes = <int>[];
    var receivedBytes = 0;

    response.stream.listen(
      (chunk) {
        bytes.addAll(chunk);
        receivedBytes += chunk.length;
        if (onProgressChanged != null && contentLength != null) {
          onProgressChanged(receivedBytes / contentLength);
        }
      },
      onDone: () {
        if (onProgressChanged != null) {
          onProgressChanged(1);
        }
        completer.complete(Uint8List.fromList(bytes));
      },
      onError: completer.completeError,
      cancelOnError: true,
    );

    return completer.future;
  }
}
