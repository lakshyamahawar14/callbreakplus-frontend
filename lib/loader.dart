import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final double size;
  final Color color;

  const Loader({
    Key? key,
    this.size = 50.0,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
