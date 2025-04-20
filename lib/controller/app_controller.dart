import 'package:flutter_ui/headers.dart';
import 'package:path/path.dart';

class AppController extends GetxController {
  final firebase = MyFirebase();
  bool get isEmailVerified => firebase.isEmailVerified;

  MyUser? myUser;

  Future<void> reload() async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser == null) {
        Get.offAndToNamed(AppRoutes.rLogin);
      } else {
        myUser = await firebase.getUser(firebase.currentUser!.uid);
        if (myUser == null) {
          Get.offAndToNamed(AppRoutes.rLogin);
        }
      }
    } catch (e) {
      debugPrint("Error $e");
      MySnackbar.error("Unable To Relod");
    }
  }

  // Splash Screen
  Future<void> onInitialize() async {
    try {
      if (firebase.currentUser == null ||
          (myUser = await firebase.getUser(firebase.currentUser!.uid)) ==
              null) {
        await Future.delayed(Duration(seconds: 1));
        Get.offAndToNamed(AppRoutes.rOnboarding);
      } else {
        await Future.delayed(Duration(seconds: 1));

        _onUserLogedIn(myUser!);
      }
    } catch (e) {
      Get.offAndToNamed(AppRoutes.rOnboarding);
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

  // Questionaries
  Future<void> updateQuestionaries(MyQuestionaries questionaries) async {
    try {
      print("MY USER ${myUser!.uid}");
      await firebase.updateUser(myUser!.uid, {
        'questionaries': questionaries.toJson(),
      });
      myUser =
          myUser!.copy(questionaries: questionaries, updateQuestionaries: true);
    } catch (e) {
      debugPrint("ERROR ON UPDATE $e");
      throw 'Unable to Update';
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      MySnackbar.success('Link send on your email');
    } catch (e) {
      debugPrint("ERROR $e");
      MySnackbar.error('Unable To Send Verification link');
    }
  }

  //////////////
  // Home

  Future<void> addResult(SimpleResult result) async {
    try {
      final res = await firebase.addResult(
        firebase.currentUser!.uid,
        result.imgUrl,
        result.result,
      );
      myUser!.results.add(res);
    } catch (e) {
      debugPrint("Error $e");
      MySnackbar.error('Result Not Updated');
    }
  }
}
