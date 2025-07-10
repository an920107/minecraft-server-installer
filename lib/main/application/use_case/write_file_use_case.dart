import 'package:minecraft_server_installer/main/application/repository/installation_repository.dart';

class WriteFileUseCase {
  final InstallationRepository _installationRepository;

  WriteFileUseCase(this._installationRepository);

  Future<void> call(String path, String content) => _installationRepository.writeFile(path, content);
}
