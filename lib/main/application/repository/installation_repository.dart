typedef DownloadProgressCallback = void Function(double progress);

abstract interface class InstallationRepository {
  Future<void> downloadServerFile(Uri url, String path, {DownloadProgressCallback? onProgressChanged});
}
