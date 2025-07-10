import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/installation_bloc.dart';
import 'package:minecraft_server_installer/main/framework/ui/path_browsing_field.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/vanilla_bloc.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/game_version_view_model.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/vanilla_state.dart';
import 'package:minecraft_server_installer/vanilla/framework/ui/game_version_dropdown.dart';

class BasicConfigurationTab extends StatefulWidget {
  const BasicConfigurationTab({super.key});

  @override
  State<BasicConfigurationTab> createState() => _BasicConfigurationTabState();
}

class _BasicConfigurationTabState extends State<BasicConfigurationTab> {
  GameVersionViewModel? selectedGameVersion;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const GameVersionDropdown(),
          const Gap(16),
          const PathBrowsingField(),
          const Spacer(),
          _bottomControl,
        ],
      );

  Widget get _bottomControl => BlocConsumer<VanillaBloc, VanillaState>(
        listener: (_, __) {},
        builder: (_, state) => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (state.isDownloading) Expanded(child: LinearProgressIndicator(value: state.downloadProgress)),
            const Gap(32),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
              onPressed: context.watch<InstallationBloc>().state.isGameVersionSelected ? _downloadServerFile : null,
              icon: const Icon(Icons.download),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(Strings.buttonStartToInstall),
              ),
            ),
          ],
        ),
      );

  void _downloadServerFile() {
    final savePath = context.read<InstallationBloc>().state.savePath;
    context.read<VanillaBloc>().add(VanillaServerFileDownloadedEvent(savePath!));
  }
}
