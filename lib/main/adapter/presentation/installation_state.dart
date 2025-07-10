import 'package:equatable/equatable.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/progress_view_model.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/game_version_view_model.dart';

class InstallationState with EquatableMixin {
  final GameVersionViewModel? gameVersion;
  final String? savePath;
  final ProgressViewModel downloadProgress;
  final bool isLocked;

  const InstallationState({
    required this.gameVersion,
    required this.savePath,
    required this.downloadProgress,
    required this.isLocked,
  });

  const InstallationState.empty()
      : this(
          gameVersion: null,
          savePath: null,
          downloadProgress: const ProgressViewModel.zero(),
          isLocked: false,
        );

  @override
  List<Object?> get props => [
        gameVersion,
        savePath,
        downloadProgress,
        isLocked,
      ];

  InstallationState copyWith({
    GameVersionViewModel? gameVersion,
    String? savePath,
    ProgressViewModel? downloadProgress,
    bool? isLocked,
  }) =>
      InstallationState(
        gameVersion: gameVersion ?? this.gameVersion,
        savePath: savePath ?? this.savePath,
        downloadProgress: downloadProgress ?? this.downloadProgress,
        isLocked: isLocked ?? this.isLocked,
      );

  bool get isGameVersionSelected => gameVersion != null;

  bool get isSavePathSelected => savePath != null && savePath!.isNotEmpty;

  bool get canStartToInstall => isGameVersionSelected && isSavePathSelected && !isLocked;
}
