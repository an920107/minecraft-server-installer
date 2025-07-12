import 'package:minecraft_server_installer/properties/application/repository/server_properties_repository.dart';
import 'package:minecraft_server_installer/properties/domain/entity/server_properties.dart';

class WriteServerPropertiesUseCase {
  final ServerPropertiesRepository _serverPropertiesRepository;

  WriteServerPropertiesUseCase(this._serverPropertiesRepository);

  Future<void> call(ServerProperties serverProperties, String savePath) =>
      _serverPropertiesRepository.writeServerProperties(serverProperties, savePath);
}
