import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screens/first_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
    return GetMaterialApp(
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
