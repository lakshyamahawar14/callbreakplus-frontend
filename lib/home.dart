import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'menu.dart';
import 'constants.dart';
import 'button.dart';
import 'status.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String playerName = '';
  String statusMessage = '';
  bool isLoggedIn = false;
  Color statusColor = AppColors.redColor;

  @override
  void initState() {
    super.initState();
    _loadPlayerName();
  }

  Future<void> _loadPlayerName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      playerName = prefs.getString('playerName') ?? '';
      isLoggedIn = playerName.isNotEmpty;
    });
  }

  Future<void> _savePlayerName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('playerName', name);
    setState(() {
      playerName = name;
      isLoggedIn = true;
    });
  }

  Future<void> _removePlayerName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String playerName = prefs.getString('playerName') ?? '';

    final response = await _destroySession(playerName);

    if (response['status'] == 200) {
      await prefs.remove('playerName');
      setState(() {
        playerName = '';
        isLoggedIn = false;
        statusMessage = response['message'];
        _controller.clear();
      });
    } else {
      setState(() {
        statusMessage = response['message'];
      });
    }
  }

  Future<Map<String, dynamic>> _createSession(String playerName) async {
    final url = Uri.parse('http://192.168.226.234:8080/api/session/create?name=$playerName');
    final response = await http.post(url);

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> _destroySession(String playerName) async {
    final url = Uri.parse('http://192.168.226.234:8080/api/session/destroy?name=$playerName');
    final response = await http.get(url);

    return jsonDecode(response.body);
  }

  void _setPlayerName() async {
    String inputText = _controller.text.trim();

    if (inputText.isEmpty) {
      setState(() {
        statusMessage = "Please enter a name!";
        statusColor = AppColors.redColor;
      });
      return;
    }

    final response = await _createSession(inputText);

    setState(() {
      if (response['status'] == 200) {
        playerName = response['data']['playerName'];
        statusMessage = response['message'];
        _savePlayerName(playerName);
      } else {
        statusMessage = response['message'];
      }

      bool isError = response['status'] != 200;
      statusColor = isError ? AppColors.redColor : Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double menuWidth = 200;
    final double containerWidth = screenWidth - menuWidth - 30;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AppColors.homeColor,
      ),
      child: Row(
        children: [
          Container(
            width: menuWidth,
            margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Menu(),
          ),
          Container(
            width: containerWidth,
            padding: const EdgeInsets.all(0),
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Call Break Plus',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFFEFFE3),
                    ),
                  ),
                ),
                if (statusMessage.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    constraints: BoxConstraints(
                      maxWidth: containerWidth * 0.5,
                    ),
                    child: Status(
                      text: statusMessage,
                      color: statusColor,
                    ),
                  ),
                if (!isLoggedIn)
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    width: containerWidth * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _setPlayerName(),
                      decoration: const InputDecoration(
                        hintText: 'Enter Your Name',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),
                if (!isLoggedIn)
                  Button(
                    icon: FontAwesomeIcons.rightToBracket,
                    buttonText: "Enter",
                    onPressed: _setPlayerName,
                  ),
                if (isLoggedIn)
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                            children: [
                              const TextSpan(text: 'Welcome, '),
                              TextSpan(
                                text: playerName,
                                style: const TextStyle(color: AppColors.greenColor),
                              ),
                              const TextSpan(text: '!'),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Button(
                          icon: FontAwesomeIcons.trash,
                          buttonText: "Leave Server",
                          onPressed: _removePlayerName,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
