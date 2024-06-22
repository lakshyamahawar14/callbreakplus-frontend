import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  final String message;
  final Color color;

  const Status({
    super.key,
    required this.message,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 8),
      color: Colors.white,
      child: Text(
        message,
        style: TextStyle(
          fontSize: 14,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
