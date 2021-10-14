import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?> showInputDialog(
  BuildContext context, {
  String? title,
  String? initialValue,
}) async {
  String value = initialValue ?? '';
  TextEditingController controller = TextEditingController();
  controller.text = value;
  final result = await showDialog<String>(
    context: context,
    builder: (context) =>  AlertDialog(
      title: title != null ? Text(title) : null,
      content: TextField(
        controller: controller,
        onChanged: (text) {
          value = text;
        },
      ),
      actions: [
        TextButton(
          child: Text('Save'),
          //isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, value);
          },
        ),
       TextButton(
          child: Text('Cancel'),
         // isDefaultAction: true,
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
