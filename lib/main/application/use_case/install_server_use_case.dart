import 'package:minecraft_server_installer/main/application/use_case/download_file_use_case.dart';
import 'package:minecraft_server_installer/main/application/use_case/grant_file_permission_use_case.dart';
import 'package:minecraft_server_installer/main/application/use_case/write_file_use_case.dart';
import 'package:minecraft_server_installer/main/constants.dart';
import 'package:minecraft_server_installer/properties/application/use_case/write_server_properties_use_case.dart';
import 'package:minecraft_server_installer/properties/domain/entity/server_properties.dart';
import 'package:minecraft_server_installer/vanilla/domain/entity/game_version.dart';
import 'package:path/path.dart' as path;

class InstallServerUseCase {
  final DownloadFileUseCase _downloadFileUseCase;
  final WriteFileUseCase _writeFileUseCase;
  final GrantFilePermissionUseCase _grantFilePermissionUseCase;
  final WriteServerPropertiesUseCase _writeServerPropertiesUseCase;

  InstallServerUseCase(
    this._downloadFileUseCase,
    this._writeFileUseCase,
    this._grantFilePermissionUseCase,
    this._writeServerPropertiesUseCase,
  );

  Future<void> call({
    required GameVersion gameVersion,
    required String savePath,
    required int maxRam,
    required int minRam,
    required bool isGuiEnabled,
    required ServerProperties serverProperties,
    required void Function(double) onProgressChanged,
  }) async {
    // 1. Download server file
    await _downloadFileUseCase(
      gameVersion.url,
      path.join(savePath, Constants.serverFileName),
      onProgressChanged: onProgressChanged,
    );

    // 2. Write start script
    final startScriptFilePath = path.join(savePath, Constants.startScriptFileName);
    final serverFilePath = path.join('.', Constants.serverFileName);
    final startScriptContent = 'java -Xmx${maxRam}M -Xms${minRam}M -jar $serverFilePath ${isGuiEnabled ? '' : 'nogui'}';
    await _writeFileUseCase(startScriptFilePath, startScriptContent);
    await _grantFilePermissionUseCase(startScriptFilePath);

    // 3. Write EULA file
    final eulaFilePath = path.join(savePath, Constants.eulaFileName);
    await _writeFileUseCase(eulaFilePath, Constants.eulaFileContent);

    // 4. Write server.properties file
    await _writeServerPropertiesUseCase(serverProperties, savePath);
  }
}
