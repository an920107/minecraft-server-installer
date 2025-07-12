import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/adapter/presenter/installation_state.dart';
import 'package:minecraft_server_installer/main/adapter/presenter/progress_view_model.dart';
import 'package:minecraft_server_installer/main/adapter/presenter/range_view_model.dart';
import 'package:minecraft_server_installer/main/application/use_case/install_server_use_case.dart';
import 'package:minecraft_server_installer/properties/adapter/presenter/server_properties_view_model.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presenter/game_version_view_model.dart';

class InstallationBloc extends Bloc<InstallationEvent, InstallationState> {
  InstallationBloc(
    InstallServerUseCase installServerUseCase,
  ) : super(const InstallationState.empty()) {
    on<InstallationStartedEvent>((event, emit) async {
      if (!state.canStartToInstall) {
        return;
      }

      emit(state.copyWith(isLocked: true, downloadProgress: const ProgressViewModel.start()));

      await installServerUseCase(
        gameVersion: state.gameVersion!.toEntity(),
        savePath: state.savePath!,
        maxRam: state.ramSize.max,
        minRam: state.ramSize.min,
        isGuiEnabled: state.isGuiEnabled,
        serverProperties: event.serverProperties.toEntity(),
        onProgressChanged: (progressValue) => add(_InstallationProgressValueChangedEvent(progressValue)),
      );

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
      if (event.customRamSize != null && !event.customRamSize!.isValid) {
        return;
      }

      final newState = state.copyWith(
        gameVersion: event.gameVersion,
        savePath: event.savePath,
        isEulaAgreed: event.isEulaAgreed,
        isGuiEnabled: event.isGuiEnabled,
        isCustomRamSizeEnabled: event.isCustomRamSizeEnabled,
        customRamSize: event.customRamSize,
      );
      emit(newState);
    });
  }
}

sealed class InstallationEvent {}

class InstallationStartedEvent extends InstallationEvent {
  final ServerPropertiesViewModel serverProperties;

  InstallationStartedEvent(this.serverProperties);
}

class _InstallationProgressValueChangedEvent extends InstallationEvent {
  final double progressValue;

  _InstallationProgressValueChangedEvent(this.progressValue);
}

class InstallationConfigurationUpdatedEvent extends InstallationEvent {
  final GameVersionViewModel? gameVersion;
  final String? savePath;
  final bool? isEulaAgreed;
  final bool? isGuiEnabled;
  final bool? isCustomRamSizeEnabled;
  final RangeViewModel? customRamSize;

  InstallationConfigurationUpdatedEvent({
    this.gameVersion,
    this.savePath,
    this.isEulaAgreed,
    this.isGuiEnabled,
    this.isCustomRamSizeEnabled,
    this.customRamSize,
  });
}
