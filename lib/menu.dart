import 'package:flutter/material.dart';
import 'links.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Menu',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 10),
        Links(
          icon: FontAwesomeIcons.users,
          title: 'Multiplayer',
        ),
        Links(
          icon: FontAwesomeIcons.userFriends,
          title: 'Local',
        ),
        Links(
          icon: FontAwesomeIcons.cogs,
          title: 'Settings',
        ),
      ],
    );
  }
}