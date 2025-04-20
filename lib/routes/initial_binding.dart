import 'package:flutter_ui/headers.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AppController(),
      permanent: true,
    );
  }
}
