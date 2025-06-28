import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';
import 'package:minecraft_server_installer/vanila/adapter/gateway/game_version_repository_impl.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/game_version_bloc.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/game_version_view_model.dart';
import 'package:minecraft_server_installer/vanila/application/use_case/get_game_version_list_use_case.dart';
import 'package:minecraft_server_installer/vanila/framework/api/game_version_api_service_impl.dart';

class GameVersionDropdown extends StatelessWidget {
  const GameVersionDropdown({super.key, required this.onChanged});

  final void Function(GameVersionViewModel?) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameVersionBloc>(
      create: (_) {
        final gameVersionApiService = GameVersionApiServiceImpl();
        final gameVersionRepository = GameVersionRepositoryImpl(gameVersionApiService);
        final getGameVersionListUseCase = GetGameVersionListUseCase(gameVersionRepository);
        return GameVersionBloc(getGameVersionListUseCase);
      },
      child: _GameVersionDropdown(key: key, onChanged: onChanged),
    );
  }
}

class _GameVersionDropdown extends StatefulWidget {
  const _GameVersionDropdown({super.key, required this.onChanged});

  final void Function(GameVersionViewModel?) onChanged;

  @override
  State<_GameVersionDropdown> createState() => _GameVersionDropdownState();
}

class _GameVersionDropdownState extends State<_GameVersionDropdown> {
  @override
  void initState() {
    super.initState();
    context.read<GameVersionBloc>().add(GameVersionLoadedEvent());
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<GameVersionBloc, List<GameVersionViewModel>>(
    listener: (_, __) {},
    builder:
        (_, gameVersions) => DropdownMenu(
          enabled: gameVersions.isNotEmpty,
          requestFocusOnTap: false,
          expandedInsets: EdgeInsets.zero,
          label: const Text(Strings.fieldGameVersion),
          onSelected: widget.onChanged,
          dropdownMenuEntries:
              gameVersions
                  .map(
                    (gameVersion) =>
                        DropdownMenuEntry<GameVersionViewModel>(value: gameVersion, label: gameVersion.name),
                  )
                  .toList(),
        ),
  );
}
