import 'package:flutter_ui/headers.dart';
import 'package:flutter_ui/screens/home_screen.dart';
import 'package:flutter_ui/screens/profile.dart';
import 'package:flutter_ui/screens/terms_page.dart';

class AppRoutes {
  static const rInitial = '/';
  static const rOnboarding = '/onboarding';
  static const rHome = '/home';
  static const rProfile = '/profile';
  static const rLogin = '/login';
  static const rTermsAndConditions = '/terms';
  static const rRegister = '/register';

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
          name: rHome,
          page: () => HomeScreen(),
        ),
        GetPage(
          name: rProfile,
          page: () => ProfileScreen(),
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
          name: rLogin,
          page: () => LoginScreen(),
        ),
      ];
}
