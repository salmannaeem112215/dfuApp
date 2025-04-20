import 'package:flutter_ui/headers.dart';

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
        itemBuilder: (context, index) => ListTile(
          title: Text(results[index].result),
        ),
      ),
    );
  }
}
