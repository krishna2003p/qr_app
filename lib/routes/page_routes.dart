import 'package:get/get_navigation/src/routes/get_route.dart';
import '../splash/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/';

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),

  ];
}
