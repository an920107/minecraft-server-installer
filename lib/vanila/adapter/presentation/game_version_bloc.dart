import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/game_version_view_model.dart';
import 'package:minecraft_server_installer/vanila/application/use_case/get_game_version_list_use_case.dart';

class GameVersionBloc extends Bloc<GameVersionEvent, List<GameVersionViewModel>> {
  final GetGameVersionListUseCase _getGameVersionListUseCase;

  GameVersionBloc(this._getGameVersionListUseCase) : super(const []) {
    on<GameVersionLoadedEvent>((_, emit) async {
      try {
        final gameVersions = await _getGameVersionListUseCase();
        emit(gameVersions.map((entity) => GameVersionViewModel.from(entity)).toList());
      } on Exception {
        emit(const []);
      }
    });
  }
}

sealed class GameVersionEvent {}

class GameVersionLoadedEvent extends GameVersionEvent {}
