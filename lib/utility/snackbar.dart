import 'package:get/get.dart';

class MySnackbar {
  MySnackbar._();
  static error(String message) {
    Get.showSnackbar(GetSnackBar(
      title: 'Error',
      message: message,
      duration: Duration(
        seconds: 1,
        milliseconds: 500,
      ),
    ));
  }

  static success(String message) {
    Get.showSnackbar(GetSnackBar(
      title: 'Success',
      message: message,
      duration: Duration(
        seconds: 1,
        milliseconds: 500,
      ),
    ));
  }
}
