import 'package:equatable/equatable.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/progress_view_model.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/range_view_model.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/game_version_view_model.dart';

class InstallationState with EquatableMixin {
  static const _defaultRamSize = RangeViewModel(min: 2048, max: 2048);

  final GameVersionViewModel? gameVersion;
  final String? savePath;
  final bool isEulaAgreed;
  final bool isGuiEnabled;
  final bool isCustomRamSizeEnabled;
  final RangeViewModel? _customRamSize;
  final ProgressViewModel downloadProgress;
  final bool isLocked;

  const InstallationState({
    required this.gameVersion,
    required this.savePath,
    required this.isEulaAgreed,
    required this.isGuiEnabled,
    required this.isCustomRamSizeEnabled,
    required RangeViewModel? customRamSize,
    required this.downloadProgress,
    required this.isLocked,
  }) : _customRamSize = customRamSize;

  const InstallationState.empty()
      : this(
          gameVersion: null,
          savePath: null,
          isEulaAgreed: false,
          isGuiEnabled: false,
          isCustomRamSizeEnabled: false,
          customRamSize: _defaultRamSize,
          downloadProgress: const ProgressViewModel.zero(),
          isLocked: false,
        );

  @override
  List<Object?> get props => [
        gameVersion,
        savePath,
        isEulaAgreed,
        isGuiEnabled,
        isCustomRamSizeEnabled,
        _customRamSize,
        downloadProgress,
        isLocked,
      ];

  InstallationState copyWith({
    GameVersionViewModel? gameVersion,
    String? savePath,
    bool? isEulaAgreed,
    bool? isGuiEnabled,
    bool? isCustomRamSizeEnabled,
    RangeViewModel? customRamSize,
    ProgressViewModel? downloadProgress,
    bool? isLocked,
  }) =>
      InstallationState(
        gameVersion: gameVersion ?? this.gameVersion,
        savePath: savePath ?? this.savePath,
        isEulaAgreed: isEulaAgreed ?? this.isEulaAgreed,
        isGuiEnabled: isGuiEnabled ?? this.isGuiEnabled,
        isCustomRamSizeEnabled: isCustomRamSizeEnabled ?? this.isCustomRamSizeEnabled,
        customRamSize: customRamSize ?? _customRamSize,
        downloadProgress: downloadProgress ?? this.downloadProgress,
        isLocked: isLocked ?? this.isLocked,
      );

  RangeViewModel get ramSize => isCustomRamSizeEnabled ? _customRamSize ?? _defaultRamSize : _defaultRamSize;

  bool get isGameVersionSelected => gameVersion != null;

  bool get isSavePathSelected => savePath != null && savePath!.isNotEmpty;

  bool get canStartToInstall => isGameVersionSelected && isSavePathSelected && isEulaAgreed && !isLocked;
}
