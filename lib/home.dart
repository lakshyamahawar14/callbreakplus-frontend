import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'menu.dart';
import 'constants.dart';
import 'button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String playerName = '';
  String errorMessage = '';
  String previousErrorMessage = '';

  Future<Map<String, dynamic>> _createSession(String playerName) async {
    final url = Uri.parse('http://192.168.226.234:8080/api/session/create?name=$playerName');
    final response = await http.post(url);

    return jsonDecode(response.body);
  }

  void _setPlayerName() async {
    String inputText = _controller.text.trim();

    if (inputText.isEmpty) {
      setState(() {
        errorMessage = "Please enter a name";
      });
      return;
    }

    final response = await _createSession(inputText);

    setState(() {
      if (response['status'] == 200) {
        playerName = response['data']['playerName'];
        errorMessage = '';
      } else {
        String newErrorMessage = response['message'];
        if (newErrorMessage != previousErrorMessage) {
          errorMessage = newErrorMessage;
          previousErrorMessage = newErrorMessage;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double menuWidth = 200;
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
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Call Break Plus',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFFEFFE3),
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(0, 0),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: playerName.isEmpty,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    width: containerWidth * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _setPlayerName(),
                      decoration: InputDecoration(
                        hintText: 'Enter Your Name',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: playerName.isEmpty,
                  child: Button(
                    icon: FontAwesomeIcons.rightToBracket,
                    buttonText: "Enter",
                    onPressed: _setPlayerName,
                  ),
                ),
                Visibility(
                  visible: errorMessage.isNotEmpty,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20), // Top margin added here
                    constraints: BoxConstraints(
                      maxWidth: containerWidth * 0.5,
                    ),
                    child: Status(
                      text: errorMessage,
                      color: AppColors.redColor,
                    ),
                  ),
                ),
                Visibility(
                  visible: playerName.isNotEmpty,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                      children: [
                        TextSpan(text: 'Welcome, '),
                        TextSpan(
                          text: playerName,
                          style: TextStyle(color: AppColors.greenColor),
                        ),
                        TextSpan(text: '!'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Status extends StatelessWidget {
  final String text;
  final Color color;

  const Status({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
