import 'package:equatable/equatable.dart';
import 'package:minecraft_server_installer/properties/domain/enum/difficulty.dart';
import 'package:minecraft_server_installer/properties/domain/enum/game_mode.dart';

class ServerProperties with EquatableMixin {
  final int serverPort;
  final int maxPlayers;
  final int spawnProtection;
  final int viewDistance;
  final bool pvp;
  final GameMode gameMode;
  final Difficulty difficulty;
  final bool enableCommandBlock;
  final bool onlineMode;
  final String motd;

  const ServerProperties({
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

  @override
  List<Object?> get props => [
        serverPort,
        maxPlayers,
        spawnProtection,
        viewDistance,
        pvp,
        gameMode,
        difficulty,
        enableCommandBlock,
        onlineMode,
        motd,
      ];
}
