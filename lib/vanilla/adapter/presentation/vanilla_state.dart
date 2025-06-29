import 'package:equatable/equatable.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/game_version_view_model.dart';

class VanillaState with EquatableMixin {
  final bool isLocked;
  final double downloadProgress;
  final List<GameVersionViewModel> gameVersions;
  final GameVersionViewModel? selectedGameVersion;

  const VanillaState({
    required this.isLocked,
    required this.downloadProgress,
    required this.gameVersions,
    required this.selectedGameVersion,
  });

  const VanillaState.empty()
    : this(isLocked: false, downloadProgress: 0, gameVersions: const [], selectedGameVersion: null);

  @override
  List<Object?> get props => [isLocked, downloadProgress, gameVersions, selectedGameVersion];

  bool get isGameVersionSelected => selectedGameVersion != null;

  bool get isDownloading => downloadProgress > 0 && downloadProgress < 1;

  VanillaState copyWith({
    bool? isLocked,
    double? downloadProgress,
    List<GameVersionViewModel>? gameVersions,
    GameVersionViewModel? selectedGameVersion,
  }) => VanillaState(
    isLocked: isLocked ?? this.isLocked,
    downloadProgress: downloadProgress ?? this.downloadProgress,
    gameVersions: gameVersions ?? this.gameVersions,
    selectedGameVersion: selectedGameVersion ?? this.selectedGameVersion,
  );
}
