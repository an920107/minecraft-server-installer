import 'package:equatable/equatable.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/game_version_view_model.dart';

class VanilaState with EquatableMixin {
  final bool isLocked;
  final double downloadProgress;
  final List<GameVersionViewModel> gameVersions;
  final GameVersionViewModel? selectedGameVersion;

  const VanilaState({
    required this.isLocked,
    required this.downloadProgress,
    required this.gameVersions,
    required this.selectedGameVersion,
  });

  const VanilaState.empty()
    : this(isLocked: false, downloadProgress: 0, gameVersions: const [], selectedGameVersion: null);

  @override
  List<Object?> get props => [isLocked, downloadProgress, gameVersions, selectedGameVersion];

  bool get isGameVersionSelected => selectedGameVersion != null;

  bool get isDownloading => downloadProgress > 0 && downloadProgress < 1;

  VanilaState copyWith({
    bool? isLocked,
    double? downloadProgress,
    List<GameVersionViewModel>? gameVersions,
    GameVersionViewModel? selectedGameVersion,
  }) => VanilaState(
    isLocked: isLocked ?? this.isLocked,
    downloadProgress: downloadProgress ?? this.downloadProgress,
    gameVersions: gameVersions ?? this.gameVersions,
    selectedGameVersion: selectedGameVersion ?? this.selectedGameVersion,
  );
}
