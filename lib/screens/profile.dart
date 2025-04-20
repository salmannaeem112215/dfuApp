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
  @override
  Widget build(BuildContext context) {
    final user = controller.myUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                "Information",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 12),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Name'),
                      subtitle: Text(user.name),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.cake),
                      title: Text('Age'),
                      subtitle: Text(user.age.toString()),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Email'),
                      subtitle: Text(user.email),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "Questionaries",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.rQuestionaires),
                    child: Text("Update Content"),
                  )
                ],
              ),
              SizedBox(height: 12),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.timeline), // for Diabetes Duration
                      title: Text('Diabetes Duration'),
                      subtitle: user.questionaries == null
                          ? null
                          : Text(user.questionaries!.diabetesDuration),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.health_and_safety), // for Foot Care
                      title: Text('Foot Care'),
                      subtitle: user.questionaries == null
                          ? null
                          : Text(user.questionaries!.footCare),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.healing), // for Had Ulcer Before
                      title: Text('Had Ulcer Before'),
                      subtitle: user.questionaries == null
                          ? null
                          : Text(user.questionaries!.hadUlcerBefore),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              _ReportsContent(user.results),
              SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportsContent extends StatelessWidget {
  const _ReportsContent(this.reports);
  final List<MyResults> reports;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              "Reports",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.rReports),
              child: Text("View All"),
            )
          ],
        ),
        SizedBox(height: 16),
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: Column(
            children: [
              ListTile(),
              ListTile(),
              ListTile(),
              // ListTile(
              //   leading: Icon(Icons.timeline), // for Diabetes Duration
              //   title: Text('Diabetes Duration'),
              //   subtitle: user.questionaries == null
              //       ? null
              //       : Text(user.questionaries!.diabetesDuration),
              // ),
              // Divider(),
              // ListTile(
              //   leading: Icon(Icons.health_and_safety), // for Foot Care
              //   title: Text('Foot Care'),
              //   subtitle: user.questionaries == null
              //       ? null
              //       : Text(user.questionaries!.footCare),
              // ),
              // Divider(),
              // ListTile(
              //   leading: Icon(Icons.healing), // for Had Ulcer Before
              //   title: Text('Had Ulcer Before'),
              //   subtitle: user.questionaries == null
              //       ? null
              //       : Text(user.questionaries!.hadUlcerBefore),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
