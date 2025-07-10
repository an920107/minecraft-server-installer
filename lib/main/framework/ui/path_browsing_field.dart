import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/installation_bloc.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/installation_state.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';

class PathBrowsingField extends StatefulWidget {
  const PathBrowsingField({super.key});

  @override
  State<PathBrowsingField> createState() => _PathBrowsingFieldState();
}

class _PathBrowsingFieldState extends State<PathBrowsingField> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textEditingController.text = context.read<InstallationBloc>().state.savePath ?? '';
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<InstallationBloc, InstallationState>(
        listener: (_, state) {
          if (state.savePath != null) {
            _textEditingController.text = state.savePath!;
          }
        },
        builder: (_, __) => Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textEditingController,
                readOnly: true,
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
                onPressed: _browseDirectory,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: const Text(Strings.buttonBrowse),
              ),
            ),
          ],
        ),
      );

  Future<void> _browseDirectory() async {
    final directory = await FilePicker.platform.getDirectoryPath(
      dialogTitle: Strings.dialogTitleSelectDirectory,
      initialDirectory: _textEditingController.text.isNotEmpty ? _textEditingController.text : null,
    );

    if (!mounted || directory == null) {
      return;
    }

    context.read<InstallationBloc>().add(InstallationConfigurationUpdatedEvent(
          savePath: directory,
        ));
  }
}
