typedef DownloadProgressCallback = void Function(double progress);

abstract interface class InstallationRepository {
  Future<void> downloadFile(Uri url, String path, {DownloadProgressCallback? onProgressChanged});

  Future<void> writeFile(String path, String content);
}
