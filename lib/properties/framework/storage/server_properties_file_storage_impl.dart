import 'dart:io';

import 'package:minecraft_server_installer/properties/adapter/gateway/server_properties_dto.dart';
import 'package:minecraft_server_installer/properties/adapter/gateway/server_properties_file_storage.dart';

class ServerPropertiesFileStorageImpl implements ServerPropertiesFileStorage {
  @override
  Future<void> writeServerProperties(ServerPropertiesDto serverPropertiesDto, String directoryPath) async {
    File file = File('$directoryPath/server.properties');
    await file.create(recursive: true);

    final propertiesMap = serverPropertiesDto.toStringMap();
    await file.writeAsString(propertiesMap.entries.map((e) => '${e.key}=${e.value}').join('\n'));
  }
}
