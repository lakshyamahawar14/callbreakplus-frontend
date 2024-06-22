import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'menu.dart';
import 'constants.dart';
import 'button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Call Break Plus',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFFEFFE3),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: containerWidth * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Your Name',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Button(
                    icon: FontAwesomeIcons.rightToBracket,
                    buttonText: "Enter",
                    onPressed: () {
                    },
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