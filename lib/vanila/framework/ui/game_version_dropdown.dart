import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/vanila_bloc.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/game_version_view_model.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/vanila_state.dart';

class GameVersionDropdown extends StatefulWidget {
  const GameVersionDropdown({super.key});

  @override
  State<GameVersionDropdown> createState() => _GameVersionDropdownState();
}

class _GameVersionDropdownState extends State<GameVersionDropdown> {
  @override
  void initState() {
    super.initState();
    context.read<VanilaBloc>().add(VanilaGameVersionListLoadedEvent());
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<VanilaBloc, VanilaState>(
    listener: (_, __) {},
    builder:
        (_, state) => DropdownMenu(
          enabled: state.gameVersions.isNotEmpty,
          requestFocusOnTap: false,
          expandedInsets: EdgeInsets.zero,
          label: const Text(Strings.fieldGameVersion),
          onSelected: (value) {
            if (value != null) {
              context.read<VanilaBloc>().add(VanilaGameVersionSelectedEvent(value));
            }
          },
          dropdownMenuEntries:
              state.gameVersions
                  .map(
                    (gameVersion) =>
                        DropdownMenuEntry<GameVersionViewModel>(value: gameVersion, label: gameVersion.name),
                  )
                  .toList(),
        ),
  );
}
