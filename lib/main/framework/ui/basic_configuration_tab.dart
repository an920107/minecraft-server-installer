import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/installation_bloc.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/installation_state.dart';
import 'package:minecraft_server_installer/main/constants.dart';
import 'package:minecraft_server_installer/main/framework/ui/path_browsing_field.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';
import 'package:minecraft_server_installer/vanilla/framework/ui/game_version_dropdown.dart';
import 'package:url_launcher/url_launcher.dart';

class BasicConfigurationTab extends StatelessWidget {
  const BasicConfigurationTab({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const GameVersionDropdown(),
          const Gap(16),
          const PathBrowsingField(),
          const Gap(16),
          _eulaCheckbox,
          const Spacer(),
          _bottomControl,
        ],
      );

  Widget get _eulaCheckbox => Row(
        children: [
          Expanded(
            child: BlocConsumer<InstallationBloc, InstallationState>(
                listener: (_, __) {},
                builder: (context, state) => CheckboxListTile(
                      title: const Text('${Strings.fieldEula} *'),
                      value: state.isEulaAgreed,
                      onChanged: (value) => context
                          .read<InstallationBloc>()
                          .add(InstallationConfigurationUpdatedEvent(isEulaAgreed: value ?? false)),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    )),
          ),
          IconButton(
            onPressed: () => launchUrl(Uri.parse(Constants.eulaUrl)),
            tooltip: Strings.tooltipEulaInfo,
            icon: const Icon(Icons.info_outline),
          ),
        ],
      );

  Widget get _bottomControl => BlocConsumer<InstallationBloc, InstallationState>(
        listener: (_, __) {},
        builder: (context, state) => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (state.downloadProgress.isInProgress)
              Expanded(child: LinearProgressIndicator(value: state.downloadProgress.value)),
            const Gap(32),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
              onPressed:
                  context.watch<InstallationBloc>().state.canStartToInstall ? () => _downloadServerFile(context) : null,
              icon: const Icon(Icons.download),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(Strings.buttonStartToInstall),
              ),
            ),
          ],
        ),
      );

  void _downloadServerFile(BuildContext context) {
    context.read<InstallationBloc>().add((InstallationStartedEvent()));
  }
}
