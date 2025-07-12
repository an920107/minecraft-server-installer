import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presenter/game_version_view_model.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presenter/vanilla_state.dart';
import 'package:minecraft_server_installer/vanilla/application/use_case/get_game_version_list_use_case.dart';

class VanillaBloc extends Bloc<VanillaEvent, VanillaState> {
  VanillaBloc(GetGameVersionListUseCase getGameVersionListUseCase) : super(const VanillaState.empty()) {
    on<VanillaGameVersionListLoadedEvent>((_, emit) async {
      try {
        final gameVersions = await getGameVersionListUseCase();
        emit(
          const VanillaState.empty().copyWith(
            gameVersions: gameVersions.map((entity) => GameVersionViewModel.fromEntity(entity)).toList(),
          ),
        );
      } on Exception {
        emit(const VanillaState.empty());
      }
    });
  }
}

sealed class VanillaEvent {}

class VanillaGameVersionListLoadedEvent extends VanillaEvent {}

class VanillaGameVersionSelectedEvent extends VanillaEvent {
  final GameVersionViewModel gameVersion;

  VanillaGameVersionSelectedEvent(this.gameVersion);
}
