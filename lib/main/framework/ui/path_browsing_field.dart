import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/installation_bloc.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/installation_state.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';

class PathBrowsingField extends StatelessWidget {
  const PathBrowsingField({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<InstallationBloc, InstallationState>(
        listener: (_, __) {},
        builder: (_, state) => Row(
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
}
