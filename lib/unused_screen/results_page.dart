import 'package:flutter_ui/headers.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final controller = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    final results = controller.myUser!.results;
    return Scaffold(
      appBar: AppBar(
        title: Text("Resutls"),
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
