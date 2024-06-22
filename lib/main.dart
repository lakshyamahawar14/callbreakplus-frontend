import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import the FontAwesome package

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FullScreenWidget(
        child: Scaffold(
          backgroundColor: Colors.white, // Set Scaffold background color to white
          body: HomePage(), // Use HomePage widget directly here
        ),
      ),
    );
  }
}

class FullScreenWidget extends StatefulWidget {
  final Widget child;

  const FullScreenWidget({Key? key, required this.child}) : super(key: key);

  @override
  _FullScreenWidgetState createState() => _FullScreenWidgetState();
}

class _FullScreenWidgetState extends State<FullScreenWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _enableFullScreen();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Optionally handle when app resumes from background
    }
  }

  void _enableFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _enableFullScreen();
      },
      child: widget.child,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10), // Margin of 10px from all sides
      decoration: BoxDecoration(
        color: Color(0xFFC0FFC0), // Light green color for the whole HomePage background
      ),
      child: Row(
        children: [
          Container(
            width: 200, // Fixed width for the Menu section
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Margin around the Menu widget
            decoration: BoxDecoration(
              color: Colors.white, // White background color for the Menu section
              borderRadius: BorderRadius.circular(10), // Optional: Rounded corners
            ),
            child: Menu(),
          ),
          Expanded(
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
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0), // Added padding from the top
          child: Text(
            'Menu',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 10),
        MenuLinks(icon: FontAwesomeIcons.users, title: 'Multiplayer'),
        MenuLinks(icon: FontAwesomeIcons.userFriends, title: 'Local'),
        MenuLinks(icon: FontAwesomeIcons.cogs, title: 'Settings'),
      ],
    );
  }
}

class MenuLinks extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuLinks({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        children: [
          FaIcon(icon, size: 18), // Use FaIcon for FontAwesome icons
          SizedBox(width: 10), // Space between icon and text
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
