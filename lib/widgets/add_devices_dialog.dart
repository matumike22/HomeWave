import 'package:flutter/material.dart';

class AddDevicesDialog extends StatelessWidget {
  const AddDevicesDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Add New Device'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text('Searching...'),
          SizedBox(height: 10)
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'))
      ],
    );
  }
}
