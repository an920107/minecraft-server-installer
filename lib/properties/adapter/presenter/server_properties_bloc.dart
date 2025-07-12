import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/properties/adapter/presenter/server_properties_view_model.dart';
import 'package:minecraft_server_installer/properties/domain/enum/difficulty.dart';
import 'package:minecraft_server_installer/properties/domain/enum/game_mode.dart';

class ServerPropertiesBloc extends Bloc<ServerPropertiesEvent, ServerPropertiesViewModel> {
  ServerPropertiesBloc() : super(ServerPropertiesViewModel.defaultValue) {
    on<ServerPropertiesUpdatedEvent>((event, emit) => emit(
          state.copyWith(
            serverPort: event.serverPort ?? state.serverPort,
            maxPlayers: event.maxPlayers ?? state.maxPlayers,
            spawnProtection: event.spawnProtection ?? state.spawnProtection,
            viewDistance: event.viewDistance ?? state.viewDistance,
            pvp: event.pvp ?? state.pvp,
            gameMode: event.gameMode ?? state.gameMode,
            difficulty: event.difficulty ?? state.difficulty,
            enableCommandBlock: event.enableCommandBlock ?? state.enableCommandBlock,
            onlineMode: event.onlineMode ?? state.onlineMode,
            motd: event.motd ?? state.motd,
          ),
        ));
  }
}

sealed class ServerPropertiesEvent {}

class ServerPropertiesUpdatedEvent extends ServerPropertiesEvent {
  final int? serverPort;
  final int? maxPlayers;
  final int? spawnProtection;
  final int? viewDistance;
  final bool? pvp;
  final GameMode? gameMode;
  final Difficulty? difficulty;
  final bool? enableCommandBlock;
  final bool? onlineMode;
  final String? motd;

  ServerPropertiesUpdatedEvent({
    this.serverPort,
    this.maxPlayers,
    this.spawnProtection,
    this.viewDistance,
    this.pvp,
    this.gameMode,
    this.difficulty,
    this.enableCommandBlock,
    this.onlineMode,
    this.motd,
  });
}
