import 'package:flutter/material.dart';
import 'menu.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFC0FFC0),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Container(
                width: 200,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Menu(),
              ),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: constraints.maxWidth - 220 - 10,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Call Break Plus',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
