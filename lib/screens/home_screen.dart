import 'package:flutter_ui/headers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Action Profile
    // Action Logout
    // Action Image

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          AppBarActionBtn(
            onTap: () {
              Get.toNamed(AppRoutes.rProfile);
            },
            icon: Icons.person,
            text: 'Profile',
          )
        ],
      ),
    );
  }
}

class AppBarActionBtn extends StatelessWidget {
  const AppBarActionBtn({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
  });
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 4, right: 16),
        child: Column(
          children: [
            Icon(icon),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
