import 'package:flutter/material.dart';
import 'package:flutter_ui/controller/app_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Get.find<AppController>();

  @override
  void initState() {
    _onInit();
    super.initState();
  }

  _onInit() async {
    await controller.onInitialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200, // نسوي العرض نسبي
            ),
            SizedBox(height: 40),
            Text(
              'Diabetes-Foot-Ulcer Care',
              textAlign: TextAlign.center,
              style: TextStyle(
                // fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Color(0xFF182F3A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
