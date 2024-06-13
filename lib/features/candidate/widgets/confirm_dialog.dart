import 'package:flutter/material.dart';
import 'package:trackify/core/extensions/context_extension.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String? confirmButtonText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final ShapeBorder? shapeBorder;

  const ConfirmationDialog({super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.shapeBorder,
    this.confirmButtonText,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: shapeBorder,
      backgroundColor:  context.color.settingsBackColor,

      title: Text(
        title,
      ),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Cancel',

          ),
          onPressed: onCancel,
        ),
        TextButton(
          child: Text(confirmButtonText ?? 'Proceed',

              ),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
