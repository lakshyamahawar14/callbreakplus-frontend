import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'links.dart';
import 'alert.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  Future<String> _getPlayerName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('playerName') ?? '';
  }

  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Alert(
          message: message,
          onOk: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _handleNavigation(BuildContext context, String route) async {
    String playerName = await _getPlayerName();
    if (playerName.isEmpty) {
      _showAlert(context, 'Please Log In to server.');
    } else {
      Navigator.pushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            _handleNavigation(context, '/multiplayer');
          },
        ),
        Links(
          icon: FontAwesomeIcons.userFriends,
          title: 'Local',
          onTap: () {
            _handleNavigation(context, '/local');
          },
        ),
        const Links(
          icon: FontAwesomeIcons.cogs,
          title: 'Settings',
        ),
        const Links(
          icon: FontAwesomeIcons.book,
          title: 'Rules',
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
