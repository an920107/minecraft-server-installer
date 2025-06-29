import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/game_version_bloc.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/game_version_view_model.dart';

class GameVersionDropdown extends StatefulWidget {
  const GameVersionDropdown({super.key, required this.onChanged});

  final void Function(GameVersionViewModel?) onChanged;

  @override
  State<GameVersionDropdown> createState() => _GameVersionDropdownState();
}

class _GameVersionDropdownState extends State<GameVersionDropdown> {
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
