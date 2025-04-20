import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_ui/my_firebas.dart';
import 'package:flutter_ui/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class AppController extends GetxController {
  final firebase = MyFirebase();
  // Splash Screen
  Future<void> onInitialize() async {
    // Check is Login
    if (firebase.currentUser == null) {
      Get.offAndToNamed(AppRoutes.rOnboarding);
    } else {
      // try to login it //
      final user = await firebase.getUser(firebase.currentUser!.uid);
      if (user != null) {
        // Home
        Get.offAndToNamed(AppRoutes.rOnboarding);
      } else {
        // Onboarding;
        Get.offAndToNamed(AppRoutes.rOnboarding);
      }
    }

    // C
  }

  // Auth
  Future<void> login({
    required String email,
    required String password,
  }) async {}
  Future<void> register({
    required String email,
    required String password,
  }) async {}
  Future<void> logout() async {}
}
