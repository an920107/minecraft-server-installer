import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/adapter/presenter/installation_bloc.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presenter/vanilla_bloc.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presenter/game_version_view_model.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presenter/vanilla_state.dart';

class GameVersionDropdown extends StatelessWidget {
  const GameVersionDropdown({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<VanillaBloc, VanillaState>(
        listener: (_, __) {},
        builder: (_, state) => DropdownMenu<GameVersionViewModel>(
          initialSelection: context.read<InstallationBloc>().state.gameVersion,
          enabled: state.gameVersions.isNotEmpty,
          requestFocusOnTap: false,
          expandedInsets: EdgeInsets.zero,
          inputDecorationTheme: Theme.of(context)
              .inputDecorationTheme
              .copyWith(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          label: const Text('${Strings.fieldGameVersion} *'),
          onSelected: (value) {
            if (value != null) {
              context.read<InstallationBloc>().add(InstallationConfigurationUpdatedEvent(gameVersion: value));
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
