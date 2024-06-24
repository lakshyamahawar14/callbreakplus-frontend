import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String message;
  final VoidCallback onOk;

  const Alert({Key? key, required this.message, required this.onOk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onOk,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
