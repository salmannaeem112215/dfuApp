import 'package:flutter/material.dart';
import 'package:flutter_ui/headers.dart';
import 'package:flutter_ui/screens/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.find<AppController>();
  // Logout Button
  // Verify Button
  // Questionaires Update Button
  // Info View
  // Results List
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          AppBarActionBtn(
            onTap: controller.logout,
            icon: Icons.logout,
            text: 'Logout',
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [],
      ),
    );
  }
}
