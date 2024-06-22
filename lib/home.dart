import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'menu.dart';
import 'constants.dart';
import 'button.dart';
import 'status.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String playerName = '';
  bool showError = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _setPlayerName() async {
    setState(() {
      playerName = _controller.text.trim();
      if (playerName.isNotEmpty) {
        showError = false;
        _createSession(playerName); // Call the function to create a session
      } else {
        showError = true;
      }
    });
  }

  Future<void> _createSession(String name) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/session/create?name=$name'),
    );

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
    } else {
      print('Failed to create session');
    }
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
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Call Break Plus',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFFEFFE3),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: playerName.isEmpty,
                    child: Container(
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
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: playerName.isEmpty,
                    child: Button(
                      icon: FontAwesomeIcons.rightToBracket,
                      buttonText: "Enter",
                      onPressed: () {
                        if (_controller.text.trim().isNotEmpty) {
                          _setPlayerName();
                        } else {
                          setState(() {
                            showError = true;
                          });
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: playerName.isEmpty && showError,
                    child: const SizedBox(height: 10),
                  ),
                  Visibility(
                    visible: playerName.isEmpty && showError,
                    child: const Status(
                      message: "*Please enter a valid name",
                      color: AppColors.redColor,
                    ),
                  ),
                  Visibility(
                    visible: playerName.isNotEmpty,
                    child: RichText(
                      text: TextSpan(
                        text: 'Welcome, ',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: '$playerName!',
                            style: const TextStyle(
                              color: AppColors.greenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
