import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/vanilla_bloc.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/game_version_view_model.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/vanilla_state.dart';

class GameVersionDropdown extends StatelessWidget {
  const GameVersionDropdown({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<VanillaBloc, VanillaState>(
        listener: (_, __) {},
        builder: (_, state) => DropdownMenu(
          initialSelection: state.selectedGameVersion,
          enabled: state.gameVersions.isNotEmpty,
          requestFocusOnTap: false,
          expandedInsets: EdgeInsets.zero,
          label: const Text('${Strings.fieldGameVersion} *'),
          onSelected: (value) {
            if (value != null) {
              context.read<VanillaBloc>().add(VanillaGameVersionSelectedEvent(value));
            }
          },
          dropdownMenuEntries: state.gameVersions
              .map((gameVersion) => DropdownMenuEntry<GameVersionViewModel>(
                    value: gameVersion,
                    label: gameVersion.name,
                  ))
              .toList(),
        ),
      );
}
