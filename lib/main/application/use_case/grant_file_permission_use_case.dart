import 'package:minecraft_server_installer/main/application/repository/installation_repository.dart';

class GrantFilePermissionUseCase {
  final InstallationRepository _installationRepository;

  GrantFilePermissionUseCase(this._installationRepository);

  Future<void> call(String path) => _installationRepository.grantFileExecutePermission(path);
}