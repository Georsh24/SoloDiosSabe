import 'package:flutter/cupertino.dart';

Future<String?> showInputDialog(
  BuildContext context, {
  String? title,
  String? initialValue,
}) async {
  String value = initialValue ?? '';
  TextEditingController controller = TextEditingController();
  controller.text = value;
  final result = await showCupertinoDialog<String>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: title != null ? Text(title) : null,
      content: CupertinoTextField(
        controller: controller,
        onChanged: (text) {
          value = text;
        },
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('Save'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, value);
          },
        ),
        CupertinoDialogAction(
          child: Text('Cancel'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        )
      ],
    ),
  );

  // controller.dispose();

  if (result != null && result.trim().isEmpty) {
    return null;
  }

  return result;
}
