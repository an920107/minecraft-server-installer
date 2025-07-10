import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/installation_state.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/progress_view_model.dart';
import 'package:minecraft_server_installer/main/application/use_case/download_file_use_case.dart';
import 'package:minecraft_server_installer/main/application/use_case/grant_file_permission_use_case.dart';
import 'package:minecraft_server_installer/main/application/use_case/write_file_use_case.dart';
import 'package:minecraft_server_installer/main/constants.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/game_version_view_model.dart';
import 'package:path/path.dart' as path;

class InstallationBloc extends Bloc<InstallationEvent, InstallationState> {
  InstallationBloc(
    DownloadFileUseCase downloadFileUseCase,
    WriteFileUseCase writeFileUseCase,
    GrantFilePermissionUseCase grantFilePermissionUseCase,
  ) : super(const InstallationState.empty()) {
    on<InstallationStartedEvent>((_, emit) async {
      if (!state.canStartToInstall) {
        return;
      }

      final gameVersion = state.gameVersion!;
      final savePath = state.savePath!;

      emit(state.copyWith(isLocked: true, downloadProgress: const ProgressViewModel.start()));

      await downloadFileUseCase(
        gameVersion.url,
        path.join(savePath, Constants.serverFileName),
        onProgressChanged: (progressValue) => add(_InstallationProgressValueChangedEvent(progressValue)),
      );

      final startScriptFilePath = path.join(savePath, Constants.startScriptFileName);
      final startScriptContent = Platform.isWindows
          ? 'java -jar .\\${Constants.serverFileName}\r\n'
          : 'java -jar ./${Constants.serverFileName}\n';
      await writeFileUseCase(startScriptFilePath, startScriptContent);
      await grantFilePermissionUseCase(startScriptFilePath);

      emit(state.copyWith(isLocked: false, downloadProgress: const ProgressViewModel.complete()));
    });

    on<_InstallationProgressValueChangedEvent>((event, emit) {
      ProgressViewModel newProgress;

      if (event.progressValue < 0) {
        newProgress = state.downloadProgress.copyWith(value: 0.0);
      } else if (event.progressValue > 1) {
        newProgress = state.downloadProgress.copyWith(value: 1.0);
      } else {
        newProgress = state.downloadProgress.copyWith(value: event.progressValue);
      }

      emit(state.copyWith(downloadProgress: newProgress));
    });

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

class InstallationStartedEvent extends InstallationEvent {}

class _InstallationProgressValueChangedEvent extends InstallationEvent {
  final double progressValue;

  _InstallationProgressValueChangedEvent(this.progressValue);
}

class InstallationConfigurationUpdatedEvent extends InstallationEvent {
  final GameVersionViewModel? gameVersion;
  final String? savePath;

  InstallationConfigurationUpdatedEvent({
    this.gameVersion,
    this.savePath,
  });
}
