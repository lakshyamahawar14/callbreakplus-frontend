import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OnlineRooms extends StatefulWidget {
  const OnlineRooms({Key? key}) : super(key: key);

  @override
  _OnlineRoomsState createState() => _OnlineRoomsState();
}

class _OnlineRoomsState extends State<OnlineRooms> {
  late Future<int> _activeRoomCount;

  @override
  void initState() {
    super.initState();
    _activeRoomCount = _fetchActiveRoomCount();
  }

  Future<int> _fetchActiveRoomCount() async {
    final url = Uri.parse('http://192.168.226.234:8080/api/room/');
    final response = await http.get(url);

    final jsonResponse = jsonDecode(response.body);
    int activeRoomCount = jsonResponse['data']['roomCount'];
    return activeRoomCount;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _activeRoomCount,
      builder: (context, snapshot) {
        String activeRoomsText = "Active Rooms: ";
        if (snapshot.connectionState == ConnectionState.waiting) {
          activeRoomsText += "-";
        } else if (snapshot.hasError) {
          activeRoomsText += "Error";
        } else {
          int activeRoomCount = snapshot.data ?? 0;
          activeRoomsText += activeRoomCount.toString();
        }

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Text(
              activeRoomsText,
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
