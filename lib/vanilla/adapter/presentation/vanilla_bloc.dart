import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/installation_bloc.dart';
import 'package:minecraft_server_installer/main/constants.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/game_version_view_model.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/vanilla_state.dart';
import 'package:minecraft_server_installer/vanilla/application/use_case/download_server_file_use_case.dart';
import 'package:minecraft_server_installer/vanilla/application/use_case/get_game_version_list_use_case.dart';
import 'package:path/path.dart' as path;

class VanillaBloc extends Bloc<VanillaEvent, VanillaState> {
  final InstallationBloc _installationBloc;
  final GetGameVersionListUseCase _getGameVersionListUseCase;
  final DownloadServerFileUseCase _downloadServerFileUseCase;

  VanillaBloc(
    this._installationBloc,
    this._getGameVersionListUseCase,
    this._downloadServerFileUseCase,
  ) : super(const VanillaState.empty()) {
    on<VanillaGameVersionListLoadedEvent>((_, emit) async {
      try {
        final gameVersions = await _getGameVersionListUseCase();
        emit(
          const VanillaState.empty().copyWith(
            gameVersions: gameVersions.map((entity) => GameVersionViewModel.fromEntity(entity)).toList(),
          ),
        );
      } on Exception {
        emit(const VanillaState.empty());
      }
    });

    on<VanillaServerFileDownloadedEvent>((event, emit) async {
      final gameVersion = _installationBloc.state.gameVersion;
      if (gameVersion == null) {
        return;
      }

      emit(state.copyWith(isLocked: true));
      await _downloadServerFileUseCase(
        gameVersion.toEntity(),
        path.join(event.savePath, Constants.serverFileName),
        onProgressChanged: (progress) => add(_VanillaDownloadProgressChangedEvent(progress)),
      );
      emit(state.copyWith(isLocked: false));
    });

    on<_VanillaDownloadProgressChangedEvent>((event, emit) {
      if (event.progress < 0) {
        emit(state.copyWith(downloadProgress: 0));
      } else if (event.progress > 1) {
        emit(state.copyWith(downloadProgress: 1));
      } else {
        emit(state.copyWith(downloadProgress: event.progress));
      }
    });
  }
}

sealed class VanillaEvent {}

class VanillaGameVersionListLoadedEvent extends VanillaEvent {}

class VanillaGameVersionSelectedEvent extends VanillaEvent {
  final GameVersionViewModel gameVersion;

  VanillaGameVersionSelectedEvent(this.gameVersion);
}

class VanillaServerFileDownloadedEvent extends VanillaEvent {
  final String savePath;

  VanillaServerFileDownloadedEvent(this.savePath);
}

class _VanillaDownloadProgressChangedEvent extends VanillaEvent {
  final double progress;

  _VanillaDownloadProgressChangedEvent(this.progress);
}
