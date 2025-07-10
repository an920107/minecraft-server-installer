import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/installation_state.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/game_version_view_model.dart';

class InstallationBloc extends Bloc<InstallationEvent, InstallationState> {
  InstallationBloc() : super(const InstallationState.empty()) {
    on<InstallationConfigurationUpdatedEvent>((event, emit) {
      final newState = state.copyWith(
        gameVersion: event.gameVersion,
        savePath: event.savePath,
      );
      emit(newState);
    });
  }
}

sealed class InstallationEvent {}

class InstallationConfigurationUpdatedEvent extends InstallationEvent {
  final GameVersionViewModel? gameVersion;
  final String? savePath;

  InstallationConfigurationUpdatedEvent({
    this.gameVersion,
    this.savePath,
  });
}
