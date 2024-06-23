import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  final String message;
  final Color color;
  final double maxWidth;

  const Status({
    Key? key,
    required this.message,
    required this.color,
    required this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 12,
          color: color,
        ),
      ),
    );
  }
}
