import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'button.dart';
import 'card.dart';
import 'constants.dart';
import 'onlineplayers.dart';

class Multiplayer extends StatefulWidget {
  const Multiplayer({Key? key}) : super(key: key);

  @override
  _MultiplayerState createState() => _MultiplayerState();
}

class _MultiplayerState extends State<Multiplayer> {
  late Future<String> _playerName;
  String? _roomId;
  List<String> _otherPlayerNames = [];

  @override
  void initState() {
    super.initState();
    _playerName = _getPlayerName();
    _joinRoom();
  }

  Future<void> _joinRoom() async {
    String playerName = await _playerName;
    final url = Uri.parse('http://192.168.226.234:8080/api/room/join?name=$playerName');
    final response = await http.get(url);

    final jsonResponse = jsonDecode(response.body);
    
    setState(() {
      if (jsonResponse['status'] == 200) {
        _roomId = jsonResponse['data']['roomId'];
      }
    });

    await _fetchRoomDetails();
  }

  Future<void> _fetchRoomDetails() async {
    if (_roomId != null) {
      final url = Uri.parse('http://192.168.226.234:8080/api/room/$_roomId');
      final response = await http.get(url);

      final jsonResponse = jsonDecode(response.body);
      setState(() {
        List<dynamic> players = jsonResponse['data']['players'];
        _otherPlayerNames.clear();
        for (var player in players) {
          _otherPlayerNames.add(player['playerName']);
        }
      });
    }
  }

  Future<String> _getPlayerName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('playerName') ?? '';
  }

  Future<void> _leaveRoom(String playerName, String? roomId) async {
    if (roomId != null) {
      final url = Uri.parse('http://192.168.226.234:8080/api/room/leave?name=$playerName&roomId=$roomId');
      final response = await http.get(url);

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status'] == 200) {
        setState(() {
          _roomId = null;
          _otherPlayerNames.clear();
        });

      }
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth;
    double cardHeight;

    return FutureBuilder<String>(
      future: _playerName,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            String playerName = snapshot.data ?? '';

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
                                _leaveRoom(playerName, _roomId);
                              },
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Matchmaking...',
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

                            List<Widget> playerCards = [];
                            for (int i = 0; i < 4; i++) {
                              playerCards.add(CardWidget(
                                cardWidth: cardWidth,
                                cardHeight: cardHeight,
                                playerName: i < _otherPlayerNames.length ? _otherPlayerNames[i] : '',
                              ));
                              if (i < 3) {
                                playerCards.add(const SizedBox(width: 20));
                              }
                            }

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                child: Row(
                                  children: playerCards,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Center(
                        child: OnlinePlayers(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
