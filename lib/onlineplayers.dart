import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OnlinePlayers extends StatefulWidget {
  const OnlinePlayers({Key? key}) : super(key: key);

  @override
  _OnlinePlayersState createState() => _OnlinePlayersState();
}

class _OnlinePlayersState extends State<OnlinePlayers> {
  late Future<int> _activePlayerCount;

  @override
  void initState() {
    super.initState();
    _activePlayerCount = _fetchActivePlayerCount();
  }

  Future<int> _fetchActivePlayerCount() async {
    final url = Uri.parse('http://192.168.226.234:8080/api/session/');
    final response = await http.get(url);

    final jsonResponse = jsonDecode(response.body);
    int activePlayerCount = jsonResponse['data']['activePlayerCount'];
    return activePlayerCount;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _activePlayerCount,
      builder: (context, snapshot) {
        String activePlayersText = "Active Players: ";
        if (snapshot.connectionState == ConnectionState.waiting) {
          activePlayersText += "-";
        } else if (snapshot.hasError) {
          activePlayersText += "Error";
        } else {
          int activePlayerCount = snapshot.data ?? 0;
          activePlayersText += activePlayerCount.toString();
        }

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Text(
              activePlayersText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
