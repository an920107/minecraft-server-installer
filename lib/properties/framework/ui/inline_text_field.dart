import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';

class InlineTextField extends StatefulWidget {
  const InlineTextField({
    super.key,
    required this.labelText,
    required this.defaultValue,
    required this.value,
    required this.onChanged,
  });

  final String labelText;
  final String defaultValue;
  final String value;
  final void Function(String) onChanged;

  @override
  State<InlineTextField> createState() => _InlineTextFieldState();
}

class _InlineTextFieldState extends State<InlineTextField> {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    _textEditingController.text = widget.value;
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                labelText: widget.labelText,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (newValue) {
                if (newValue != widget.value) {
                  setState(() => _isEditing = true);
                }
              },
            ),
          ),
          if (_isEditing) ...[
            const Gap(8),
            IconButton.filledTonal(
                tooltip: Strings.tooltipRestoreChanges,
                onPressed: () {
                  _focusNode.unfocus();
                  _textEditingController.text = widget.value;
                  setState(() => _isEditing = false);
                },
                icon: const Icon(Icons.cancel_outlined)),
            const Gap(8),
            IconButton.filled(
              tooltip: Strings.tooltipApplyChanges,
              onPressed: () {
                _focusNode.unfocus();
                widget.onChanged(_textEditingController.text);
                setState(() => _isEditing = false);
              },
              icon: const Icon(Icons.check_circle_outline),
            ),
          ],
          if (!_isEditing && widget.value != widget.defaultValue) ...[
            const Gap(8),
            IconButton.filledTonal(
              tooltip: Strings.tooltipResetToDefault,
              onPressed: () {
                _focusNode.unfocus();
                _textEditingController.text = widget.defaultValue;
                widget.onChanged(widget.defaultValue);
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ],
      );
}
