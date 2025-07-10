import 'package:equatable/equatable.dart';
import 'package:minecraft_server_installer/vanilla/domain/entity/game_version.dart';

class GameVersionViewModel with EquatableMixin {
  final String name;
  final Uri url;

  const GameVersionViewModel({required this.name, required this.url});

  GameVersionViewModel.from(GameVersion gameVersion) : name = gameVersion.name, url = gameVersion.url;

  GameVersion toEntity() {
    return GameVersion(name: name, url: url);
  }

  @override
  List<Object?> get props => [name, url];
}
