
import 'package:equatable/equatable.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/game_version_view_model.dart';

class VanilaState with EquatableMixin {
  final List<GameVersionViewModel> gameVersions;
  final GameVersionViewModel? selectedGameVersion;

  const VanilaState({required this.gameVersions, required this.selectedGameVersion});

  const VanilaState.empty() : this(gameVersions: const [], selectedGameVersion: null);

  @override
  List<Object?> get props => [gameVersions, selectedGameVersion];

  bool get isGameVersionSelected => selectedGameVersion != null;

  VanilaState copyWith({List<GameVersionViewModel>? gameVersions, GameVersionViewModel? selectedGameVersion}) =>
      VanilaState(
        gameVersions: gameVersions ?? this.gameVersions,
        selectedGameVersion: selectedGameVersion ?? this.selectedGameVersion,
      );
}