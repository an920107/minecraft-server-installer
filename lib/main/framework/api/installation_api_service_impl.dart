import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:minecraft_server_installer/main/adapter/gateway/installation_api_service.dart';
import 'package:minecraft_server_installer/main/application/repository/installation_repository.dart';

class InstallationApiServiceImpl implements InstallationApiService {
  @override
  Future<Uint8List> fetchRemoteFile(Uri url, {DownloadProgressCallback? onProgressChanged}) async {
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
