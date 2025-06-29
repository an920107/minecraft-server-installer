import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/game_version_view_model.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/vanila_state.dart';
import 'package:minecraft_server_installer/vanila/application/use_case/download_server_file_use_case.dart';
import 'package:minecraft_server_installer/vanila/application/use_case/get_game_version_list_use_case.dart';

class VanilaBloc extends Bloc<VanilaEvent, VanilaState> {
  final GetGameVersionListUseCase _getGameVersionListUseCase;
  final DownloadServerFileUseCase _downloadServerFileUseCase;

  VanilaBloc(this._getGameVersionListUseCase, this._downloadServerFileUseCase) : super(const VanilaState.empty()) {
    on<VanilaGameVersionListLoadedEvent>((_, emit) async {
      try {
        final gameVersions = await _getGameVersionListUseCase();
        emit(
          VanilaState(
            gameVersions: gameVersions.map((entity) => GameVersionViewModel.from(entity)).toList(),
            selectedGameVersion: null,
          ),
        );
      } on Exception {
        emit(const VanilaState.empty());
      }
    });

    on<VanilaGameVersionSelectedEvent>((event, emit) {
      emit(state.copyWith(selectedGameVersion: event.gameVersion));
    });

    on<VanilaServerFileDownloadedEvent>((_, emit) async {
      final gameVersion = state.selectedGameVersion;
      if (gameVersion == null) {
        return;
      }

      await _downloadServerFileUseCase(gameVersion.toEntity(), './server.jar');
    });
  }
}

sealed class VanilaEvent {}

class VanilaGameVersionListLoadedEvent extends VanilaEvent {}

class VanilaGameVersionSelectedEvent extends VanilaEvent {
  final GameVersionViewModel gameVersion;

  VanilaGameVersionSelectedEvent(this.gameVersion);
}

class VanilaServerFileDownloadedEvent extends VanilaEvent {}
