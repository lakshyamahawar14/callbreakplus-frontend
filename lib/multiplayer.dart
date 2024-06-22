import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'button.dart';
import 'card.dart';
import 'constants.dart';

class Multiplayer extends StatelessWidget {
  const Multiplayer({super.key});

  @override
  Widget build(BuildContext context) {
    double cardWidth;
    double cardHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    child: Button(
                      icon: FontAwesomeIcons.arrowLeft,
                      buttonText: "Leave",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Finding Room...',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double screenWidth = constraints.maxWidth;
                    cardWidth = (screenWidth - 2 * 40 - 3 * 20) / 4;
                    double multiplayerHeight =
                        MediaQuery.of(context).size.height - 112 - 68 - 20;
                    cardHeight = multiplayerHeight - 2 * 10;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CardWidget(cardWidth: cardWidth, cardHeight: cardHeight),
                        const SizedBox(width: 20),
                        CardWidget(cardWidth: cardWidth, cardHeight: cardHeight),
                        const SizedBox(width: 20),
                        CardWidget(cardWidth: cardWidth, cardHeight: cardHeight),
                        const SizedBox(width: 20),
                        CardWidget(cardWidth: cardWidth, cardHeight: cardHeight),
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/local');
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'Have a room ID? ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Join here',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
