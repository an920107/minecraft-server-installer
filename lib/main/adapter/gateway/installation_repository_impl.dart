import 'package:minecraft_server_installer/main/adapter/gateway/installation_api_service.dart';
import 'package:minecraft_server_installer/main/adapter/gateway/installation_file_storage.dart';
import 'package:minecraft_server_installer/main/application/repository/installation_repository.dart';

class InstallationRepositoryImpl implements InstallationRepository {
  final InstallationApiService _apiService;
  final InstallationFileStorage _fileStorage;

  InstallationRepositoryImpl(this._apiService, this._fileStorage);

  @override
  Future<void> downloadServerFile(Uri url, String path, {DownloadProgressCallback? onProgressChanged}) async {
    final fileBytes = await _apiService.fetchRemoteFile(url, onProgressChanged: onProgressChanged);
    await _fileStorage.saveFile(fileBytes, path);
  }
}
