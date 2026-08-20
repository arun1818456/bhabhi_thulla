
import 'package:bhabhi_thulla/modules/auth/auth_screen.dart';
import '../constant/export_file.dart';

class AppPages {
  static const init = AppRoutes.splashRoute;

  static final routes = [
    GetPage(name: AppRoutes.splashRoute, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.homeScreen, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.authScreen, page: () => const AuthScreen()),
  ];
}
