import 'package:equatable/equatable.dart';
import 'package:minecraft_server_installer/properties/domain/entity/server_properties.dart';
import 'package:minecraft_server_installer/properties/domain/enum/difficulty.dart';
import 'package:minecraft_server_installer/properties/domain/enum/game_mode.dart';

class ServerPropertiesViewModel with EquatableMixin {
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

  const ServerPropertiesViewModel({
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

  const ServerPropertiesViewModel.defaultValue()
      : this(
          serverPort: 25565,
          maxPlayers: 20,
          spawnProtection: 16,
          viewDistance: 10,
          pvp: true,
          gameMode: GameMode.survival,
          difficulty: Difficulty.normal,
          enableCommandBlock: false,
          onlineMode: true,
          motd: 'A Minecraft Server',
        );

  ServerProperties toEntity() => ServerProperties(
        serverPort: serverPort,
        maxPlayers: maxPlayers,
        spawnProtection: spawnProtection,
        viewDistance: viewDistance,
        pvp: pvp,
        gameMode: gameMode,
        difficulty: difficulty,
        enableCommandBlock: enableCommandBlock,
        onlineMode: onlineMode,
        motd: motd,
      );

  ServerPropertiesViewModel copyWith({
    int? serverPort,
    int? maxPlayers,
    int? spawnProtection,
    int? viewDistance,
    bool? pvp,
    GameMode? gameMode,
    Difficulty? difficulty,
    bool? enableCommandBlock,
    bool? onlineMode,
    String? motd,
  }) =>
      ServerPropertiesViewModel(
        serverPort: serverPort ?? this.serverPort,
        maxPlayers: maxPlayers ?? this.maxPlayers,
        spawnProtection: spawnProtection ?? this.spawnProtection,
        viewDistance: viewDistance ?? this.viewDistance,
        pvp: pvp ?? this.pvp,
        gameMode: gameMode ?? this.gameMode,
        difficulty: difficulty ?? this.difficulty,
        enableCommandBlock: enableCommandBlock ?? this.enableCommandBlock,
        onlineMode: onlineMode ?? this.onlineMode,
        motd: motd ?? this.motd,
      );

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
