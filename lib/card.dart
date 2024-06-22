import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;

  const CardWidget({
    Key? key,
    required this.cardWidth,
    required this.cardHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
