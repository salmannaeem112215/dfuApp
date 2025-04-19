import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screens/first_page.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request camera permission
  final status = await Permission.camera.request();
  if (status.isGranted) {
    try {
      cameras = await availableCameras();
    } catch (e) {
      debugPrint('Failed to initialize cameras: $e');
    }
  }

  runApp(const FlutterUiApp());
}

class FlutterUiApp extends StatelessWidget {
  const FlutterUiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF4A90E2),
        scaffoldBackgroundColor: Color(0xFFEFF3F6),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
              fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
      home: FirstPage(),
    );
  }
}
