import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'multiplayer.dart';
import 'local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure the app starts and remains in full-screen mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Set preferred orientations to landscape
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void _enableFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _enableFullScreen,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Scaffold(
                backgroundColor: Colors.white,
                body: HomePage(),
              ),
          '/multiplayer': (context) => const Multiplayer(),
          '/local': (context) => const Local(),
        },
      ),
    );
  }
}
