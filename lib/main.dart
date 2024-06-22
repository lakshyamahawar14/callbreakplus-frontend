import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'multiplayer.dart';
import 'local.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => FullScreenWidget(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: HomePage(),
              ),
            ),
        '/multiplayer': (context) => Multiplayer(),
        '/local': (context) => Local(),
      },
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
