import 'package:flutter/material.dart';
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
    return const Column(children: [GameVersionDropdown(onChanged: print)]);
  }
}
