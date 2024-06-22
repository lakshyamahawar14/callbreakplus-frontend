import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          body: Center(
            child: HomePage(), // Use HomePage widget here
          ),
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
        color: Color(0xFFC0FFC0), // Light green color
        borderRadius: BorderRadius.circular(10), // Optional: Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Inner padding for content
        child: Center(
          child: Text(
            'Call Break',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 32,
              fontWeight: FontWeight.w800,
              backgroundColor: Colors.transparent, // Make text background transparent
            ),
          ),
        ),
      ),
    );
  }
}
