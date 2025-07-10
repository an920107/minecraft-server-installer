import 'package:minecraft_server_installer/main/application/repository/installation_repository.dart';

class DownloadFileUseCase {
  final InstallationRepository _installationRepository;

  DownloadFileUseCase(this._installationRepository);

  Future<void> call(Uri url, String path, {DownloadProgressCallback? onProgressChanged}) =>
      _installationRepository.downloadServerFile(url, path, onProgressChanged: onProgressChanged);
}
