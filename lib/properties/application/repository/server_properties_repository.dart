import 'package:minecraft_server_installer/properties/domain/entity/server_properties.dart';

abstract interface class ServerPropertiesRepository {
  Future<void> writeServerProperties(ServerProperties serverProperties, String savePath);
}
