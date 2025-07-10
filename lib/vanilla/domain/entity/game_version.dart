import 'package:equatable/equatable.dart';

class GameVersion with EquatableMixin {
  final String name;
  final Uri url;

  const GameVersion({
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [name, url];
}
