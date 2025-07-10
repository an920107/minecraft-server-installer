import 'dart:io';

abstract class Constants {
  static const gameVersionListUrl = 'https://www.dropbox.com/s/mtz3moc9dpjtz7s/GameVersions.txt?dl=1';
  static const serverFileName = 'server.jar';
  static const eulaFileName = 'eula.txt';
  static const eulaFileContent =
      '#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).\neula=true';
  static const eulaUrl = 'https://account.mojang.com/documents/minecraft_eula';

  static final startScriptFileName = Platform.isWindows ? 'start.bat' : 'start.sh';
}
