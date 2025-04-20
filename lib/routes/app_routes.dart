import 'package:flutter_ui/screens/first_page.dart';
import 'package:flutter_ui/screens/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const rOnboarding = '/onboarding';
  static List<GetPage> get pages => [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
        ),
        GetPage(
          name: rOnboarding,
          page: () => OnboardingPage(),
        ),
      ];
}
