import 'package:flutter_ui/headers.dart';
import 'package:flutter_ui/screens/profile.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final controller = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    final results = controller.myUser!.results;
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports"),
      ),
      body: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) => ResultTile(
                result: results[index],
              )),
    );
  }
}
