import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/installation_bloc.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/installation_state.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/range_view_model.dart';
import 'package:minecraft_server_installer/main/constants.dart';
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
          _pathBrowsingField,
          const Gap(16),
          _eulaCheckbox,
          _guiCheckBox,
          _enableCustomRamSizeCheckbox,
          _customRamSizeControl,
          const Spacer(),
          _bottomControl,
        ],
      );

  Widget get _pathBrowsingField => BlocConsumer<InstallationBloc, InstallationState>(
        listener: (_, __) {},
        builder: (context, state) => Row(
          children: [
            Expanded(
              child: TextField(
                controller: TextEditingController(text: state.savePath ?? ''),
                readOnly: true,
                canRequestFocus: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                  label: const Text('${Strings.fieldPath} *'),
                ),
              ),
            ),
            const Gap(8),
            SizedBox(
              height: 48,
              child: OutlinedButton(
                onPressed: () => _browseDirectory(context, initialPath: state.savePath),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: const Text(Strings.buttonBrowse),
              ),
            ),
          ],
        ),
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

  Widget get _guiCheckBox => BlocConsumer<InstallationBloc, InstallationState>(
        listener: (_, __) {},
        builder: (context, state) => CheckboxListTile(
          title: const Text(Strings.fieldGui),
          value: state.isGuiEnabled,
          onChanged: (value) =>
              context.read<InstallationBloc>().add(InstallationConfigurationUpdatedEvent(isGuiEnabled: value)),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      );

  Widget get _enableCustomRamSizeCheckbox => BlocConsumer<InstallationBloc, InstallationState>(
        listener: (_, __) {},
        builder: (context, state) => CheckboxListTile(
          title: const Text(Strings.fieldCustomRamSize),
          value: state.isCustomRamSizeEnabled,
          onChanged: (value) => context
              .read<InstallationBloc>()
              .add(InstallationConfigurationUpdatedEvent(isCustomRamSizeEnabled: value ?? false)),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      );

  Widget get _customRamSizeControl => BlocConsumer<InstallationBloc, InstallationState>(
        listener: (_, __) {},
        builder: (context, state) {
          if (!state.isCustomRamSizeEnabled) {
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              RangeSlider(
                values: RangeValues(state.ramSize.min.toDouble(), state.ramSize.max.toDouble()),
                min: 512,
                max: 16384,
                divisions: (16384 - 512) ~/ 128,
                labels: RangeLabels(
                  '${state.ramSize.min} MB',
                  '${state.ramSize.max} MB',
                ),
                onChanged: (values) => context.read<InstallationBloc>().add(
                      InstallationConfigurationUpdatedEvent(
                        customRamSize: RangeViewModel(min: values.start.toInt(), max: values.end.toInt()),
                      ),
                    ),
              ),
              const Gap(16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: state.ramSize.min.toString()),
                      canRequestFocus: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        label: const Text('${Strings.fieldMinRamSize} (MB)'),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: state.ramSize.max.toString()),
                      canRequestFocus: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        label: const Text('${Strings.fieldMaxRamSize} (MB)'),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
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

  Future<void> _browseDirectory(BuildContext context, {String? initialPath}) async {
    final hasInitialPath = initialPath?.isNotEmpty ?? false;
    final directory = await FilePicker.platform.getDirectoryPath(
      dialogTitle: Strings.dialogTitleSelectDirectory,
      initialDirectory: hasInitialPath ? initialPath : null,
    );

    if (!context.mounted || directory == null) {
      return;
    }

    context.read<InstallationBloc>().add(InstallationConfigurationUpdatedEvent(
          savePath: directory,
        ));
  }

  void _downloadServerFile(BuildContext context) {
    context.read<InstallationBloc>().add((InstallationStartedEvent()));
  }
}
