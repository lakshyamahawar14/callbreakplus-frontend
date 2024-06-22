import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'links.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Menu',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Links(
          icon: FontAwesomeIcons.users,
          title: 'Multiplayer',
          onTap: () {
            Navigator.pushNamed(context, '/multiplayer');
          },
        ),
        Links(
          icon: FontAwesomeIcons.userFriends,
          title: 'Local',
          onTap: () {
            Navigator.pushNamed(context, '/local');
          },
        ),
        const Links(
          icon: FontAwesomeIcons.cogs,
          title: 'Settings',
        ),
        Links(
          icon: FontAwesomeIcons.signOutAlt,
          title: 'Exit',
          onTap: () {
            SystemNavigator.pop();
          },
        ),
      ],
    );
  }
}
