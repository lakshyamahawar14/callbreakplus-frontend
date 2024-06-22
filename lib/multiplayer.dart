import 'package:flutter/material.dart';
import 'leave.dart';
import 'card.dart';

class Multiplayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double cardWidth;
    double cardHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFFFE4E1),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: LeaveButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Finding Room...',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth;
                  cardWidth = (screenWidth - 2 * 40 - 3 * 20) / 4;
                  double multiplayerHeight = MediaQuery.of(context).size.height - 112 - 68 - 20;
                  cardHeight = multiplayerHeight - 2 * 10;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CardWidget(cardWidth: cardWidth, cardHeight: cardHeight),
                        SizedBox(width: 20),
                        CardWidget(cardWidth: cardWidth, cardHeight: cardHeight),
                        SizedBox(width: 20),
                        CardWidget(cardWidth: cardWidth, cardHeight: cardHeight),
                        SizedBox(width: 20),
                        CardWidget(cardWidth: cardWidth, cardHeight: cardHeight),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
