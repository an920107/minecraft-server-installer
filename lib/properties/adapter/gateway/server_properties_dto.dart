import 'package:minecraft_server_installer/properties/domain/entity/server_properties.dart';
import 'package:minecraft_server_installer/properties/domain/enum/difficulty.dart';
import 'package:minecraft_server_installer/properties/domain/enum/game_mode.dart';

class ServerPropertiesDto {
  final int serverPort;
  final int maxPlayers;
  final int spawnProtection;
  final int viewDistance;
  final bool pvp;
  final String gameMode;
  final String difficulty;
  final bool enableCommandBlock;
  final bool onlineMode;
  final String motd;

  const ServerPropertiesDto({
    required this.serverPort,
    required this.maxPlayers,
    required this.spawnProtection,
    required this.viewDistance,
    required this.pvp,
    required this.gameMode,
    required this.difficulty,
    required this.enableCommandBlock,
    required this.onlineMode,
    required this.motd,
  });

  ServerPropertiesDto.fromEntity(ServerProperties serverProperties)
      : this(
          serverPort: serverProperties.serverPort,
          maxPlayers: serverProperties.maxPlayers,
          spawnProtection: serverProperties.spawnProtection,
          viewDistance: serverProperties.viewDistance,
          pvp: serverProperties.pvp,
          gameMode: serverProperties.gameMode.value,
          difficulty: serverProperties.difficulty.value,
          enableCommandBlock: serverProperties.enableCommandBlock,
          onlineMode: serverProperties.onlineMode,
          motd: serverProperties.motd,
        );

  Map<String, String> toStringMap() => {
        'server-port': serverPort.toString(),
        'max-players': maxPlayers.toString(),
        'spawn-protection': spawnProtection.toString(),
        'view-distance': viewDistance.toString(),
        'pvp': pvp.toString(),
        'gamemode': gameMode,
        'difficulty': difficulty,
        'enable-command-block': enableCommandBlock.toString(),
        'online-mode': onlineMode.toString(),
        'motd': motd,
      };
}

extension _GameModeExtension on GameMode {
  String get value {
    switch (this) {
      case GameMode.survival:
        return 'survival';
      case GameMode.creative:
        return 'creative';
      case GameMode.adventure:
        return 'adventure';
      case GameMode.spectator:
        return 'spectator';
    }
  }
}

extension _DifficultyExtension on Difficulty {
  String get value {
    switch (this) {
      case Difficulty.peaceful:
        return 'peaceful';
      case Difficulty.easy:
        return 'easy';
      case Difficulty.normal:
        return 'normal';
      case Difficulty.hard:
        return 'hard';
    }
  }
}
