import 'package:flutter_ui/headers.dart';

class AppController extends GetxController {
  final firebase = MyFirebase();

  MyUser? myUser;
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
        Get.offAndToNamed(AppRoutes.rHome);
      } else {
        // Onboarding;
        Get.offAndToNamed(AppRoutes.rOnboarding);
      }
    }

    // C
  }

  Future<void> logout() async {
    try {
      await firebase.logout();
      myUser = null;
      Get.offAndToNamed(AppRoutes.rLogin);
    } catch (e) {
      debugPrint("Error $e");
      MySnackbar.error('Unable To Logout');
    }
  }

  // Auth
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final res = await firebase.loginUser(email, password);
    myUser = res;
    Get.toNamed(AppRoutes.rHome);
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required int age,
  }) async {
    final res = await firebase.registerUser(
      email: email,
      password: password,
      name: name,
      age: age,
    );
    myUser = res;
    Get.toNamed(AppRoutes.rTermsAndConditions);
  }
}
