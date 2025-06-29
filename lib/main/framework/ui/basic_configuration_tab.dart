import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/vanila_bloc.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/game_version_view_model.dart';
import 'package:minecraft_server_installer/vanila/framework/ui/game_version_dropdown.dart';

class BasicConfigurationTab extends StatefulWidget {
  const BasicConfigurationTab({super.key});

  @override
  State<BasicConfigurationTab> createState() => _BasicConfigurationTabState();
}

class _BasicConfigurationTabState extends State<BasicConfigurationTab> {
  GameVersionViewModel? selectedGameVersion;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const GameVersionDropdown(),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: context.watch<VanilaBloc>().state.isGameVersionSelected ? _downloadServerFile : null,
          icon: const Icon(Icons.download),
          label: const Text(Strings.buttonStartToInstall),
        ),
      ],
    );
  }

  void _downloadServerFile() {
    context.read<VanilaBloc>().add(VanilaServerFileDownloadedEvent());
  }
}
