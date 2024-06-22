import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Links extends StatelessWidget {
  final String title;
  final IconData icon;

  const Links({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        children: [
          FaIcon(icon, size: 18),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
