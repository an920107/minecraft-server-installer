import 'package:equatable/equatable.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/game_version_view_model.dart';

class VanillaState with EquatableMixin {
  final List<GameVersionViewModel> gameVersions;

  const VanillaState({
    required this.gameVersions,
  });

  const VanillaState.empty()
      : this(
          gameVersions: const [],
        );

  @override
  List<Object?> get props => [
        gameVersions,
      ];

  VanillaState copyWith({
    bool? isLocked,
    double? downloadProgress,
    List<GameVersionViewModel>? gameVersions,
    GameVersionViewModel? selectedGameVersion,
  }) =>
      VanillaState(
        gameVersions: gameVersions ?? this.gameVersions,
      );
}
