import 'package:flutter_ui/headers.dart';
import 'package:flutter_ui/screens/home_screen.dart';
import 'package:flutter_ui/screens/profile.dart';
import 'package:flutter_ui/screens/terms_page.dart';
import 'package:flutter_ui/screens/reports_screen.dart';

class AppRoutes {
  static const rInitial = '/';
  static const rOnboarding = '/onboarding';
  static const rHome = '/home';
  static const rReports = '/reports';
  static const rProfile = '/profile';
  static const rLogin = '/login';
  static const rTermsAndConditions = '/terms';
  static const rRegister = '/register';
  static const rQuestionaires = '/questionaries';

  static const rMedicalAdvice = '/medicalAdvice';
  static const rResultNormal = '/resultNormal';
  static const rResultAbnormal = '/resultAbnormal';
  static const rContactDoctor = '/contactDoctor';

  static List<GetPage> get pages => [
        GetPage(
          name: rInitial,
          page: () => SplashScreen(),
        ),
        GetPage(
          name: rOnboarding,
          page: () => OnboardingPage(),
        ),
        GetPage(
          name: rLogin,
          page: () => LoginScreen(),
        ),
        GetPage(
          name: rRegister,
          page: () => RegisterScreen(),
        ),
        GetPage(
          name: rTermsAndConditions,
          page: () => TermsPage(),
        ),
        GetPage(
          name: rHome,
          page: () => HomeScreen(),
        ),
        GetPage(
          name: rProfile,
          page: () => ProfileScreen(),
        ),
        GetPage(
          name: rQuestionaires,
          page: () => QuestionnairePage(),
        ),
        GetPage(
          name: rReports,
          page: () => ReportsScreen(),
        ),
        GetPage(
          name: rMedicalAdvice,
          page: () => MedicalAdvice(),
        ),
        GetPage(
          name: rContactDoctor,
          page: () => ContactDoctorsPage(),
        ),
        GetPage(
          name: rResultNormal,
          page: () => ResultDiagnosisOfNormalFoot(
            result: Get.arguments,
          ),
        ),
        GetPage(
          name: rResultAbnormal,
          page: () => ResultDiagnosisOfAbnormalFoot(
            result: Get.arguments,
          ),
        ),
      ];
}
