
import '../constant/export_file.dart';

class AppPages {
  static const init = AppRoutes.splashRoute;

  static final routes = [
    GetPage(name: AppRoutes.splashRoute, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.homeRoute, page: () => const HomeScreen()),
  ];
}
