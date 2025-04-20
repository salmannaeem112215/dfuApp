import 'package:flutter_ui/headers.dart';

class AppController extends GetxController {
  final firebase = MyFirebase();

  MyUser? myUser;
  // Splash Screen
  Future<void> onInitialize() async {
    if (firebase.currentUser == null ||
        (myUser = await firebase.getUser(firebase.currentUser!.uid)) == null) {
      Get.offAndToNamed(AppRoutes.rOnboarding);
    } else {
      _onUserLogedIn(myUser!);
    }

    // C
  }

  void _onUserLogedIn(MyUser user, {bool isRegister = false}) {
    if (isRegister) {
      Get.offAndToNamed(AppRoutes.rTermsAndConditions);
    } else if (user.questionaries == null) {
      Get.offAndToNamed(AppRoutes.rQuestionaires);
    } else {
      Get.offAndToNamed(AppRoutes.rHome);
    }
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
    _onUserLogedIn(myUser!);
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
    _onUserLogedIn(
      myUser!,
      isRegister: true,
    );
  }
}
