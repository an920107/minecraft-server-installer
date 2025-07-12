import 'package:minecraft_server_installer/properties/adapter/gateway/server_properties_dto.dart';
import 'package:minecraft_server_installer/properties/adapter/gateway/server_properties_file_storage.dart';
import 'package:minecraft_server_installer/properties/application/repository/server_properties_repository.dart';
import 'package:minecraft_server_installer/properties/domain/entity/server_properties.dart';

class ServerPropertiesRepositoryImpl implements ServerPropertiesRepository {
  final ServerPropertiesFileStorage _serverPropertiesFileStorage;

  ServerPropertiesRepositoryImpl(this._serverPropertiesFileStorage);

  @override
  Future<void> writeServerProperties(ServerProperties serverProperties, String savePath) =>
      _serverPropertiesFileStorage.writeServerProperties(
        ServerPropertiesDto.fromEntity(serverProperties),
        savePath,
      );
}
