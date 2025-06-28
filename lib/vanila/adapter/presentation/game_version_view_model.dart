import 'package:equatable/equatable.dart';
import 'package:minecraft_server_installer/vanila/domain/entity/game_version.dart';

class GameVersionViewModel with EquatableMixin {
  final String name;
  final Uri url;

  const GameVersionViewModel({required this.name, required this.url});

  GameVersionViewModel.from(GameVersion gameVersion) : name = gameVersion.name, url = gameVersion.url;

  @override
  List<Object?> get props => [name, url];
}
