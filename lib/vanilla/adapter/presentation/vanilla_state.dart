import 'package:equatable/equatable.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/game_version_view_model.dart';

class VanillaState with EquatableMixin {
  final bool isLocked;
  final double downloadProgress;
  final List<GameVersionViewModel> gameVersions;

  const VanillaState({
    required this.isLocked,
    required this.downloadProgress,
    required this.gameVersions,
  });

  const VanillaState.empty()
      : this(
          isLocked: false,
          downloadProgress: 0,
          gameVersions: const [],
        );

  @override
  List<Object?> get props => [
        isLocked,
        downloadProgress,
        gameVersions,
      ];

  bool get isDownloading => downloadProgress > 0 && downloadProgress < 1;

  VanillaState copyWith({
    bool? isLocked,
    double? downloadProgress,
    List<GameVersionViewModel>? gameVersions,
    GameVersionViewModel? selectedGameVersion,
  }) =>
      VanillaState(
        isLocked: isLocked ?? this.isLocked,
        downloadProgress: downloadProgress ?? this.downloadProgress,
        gameVersions: gameVersions ?? this.gameVersions,
      );
}
