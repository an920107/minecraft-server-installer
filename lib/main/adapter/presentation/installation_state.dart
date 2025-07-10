import 'package:equatable/equatable.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/game_version_view_model.dart';

class InstallationState with EquatableMixin {
  final GameVersionViewModel? gameVersion;
  final String? savePath;

  const InstallationState({
    this.gameVersion,
    this.savePath,
  });

  const InstallationState.empty()
      : this(
          gameVersion: null,
          savePath: null,
        );

  @override
  List<Object?> get props => [
        gameVersion,
        savePath,
      ];

  InstallationState copyWith({
    GameVersionViewModel? gameVersion,
    String? savePath,
  }) =>
      InstallationState(
        gameVersion: gameVersion ?? this.gameVersion,
        savePath: savePath ?? this.savePath,
      );

  bool get isGameVersionSelected => gameVersion != null;

  bool get isSavePathSelected => savePath != null && savePath!.isNotEmpty;

  bool get canStartToInstall => isGameVersionSelected && isSavePathSelected;
}
