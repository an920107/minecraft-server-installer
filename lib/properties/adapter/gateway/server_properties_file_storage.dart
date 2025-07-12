import 'package:minecraft_server_installer/properties/adapter/gateway/server_properties_dto.dart';

abstract interface class ServerPropertiesFileStorage {
  Future<void> writeServerProperties(ServerPropertiesDto serverPropertiesDto, String directoryPath);
}
