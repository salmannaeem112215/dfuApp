import 'package:flutter_ui/controller/app_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AppController(),
      permanent: true,
    );
  }
}
