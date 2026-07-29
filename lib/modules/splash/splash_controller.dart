import '../../constant/export_file.dart';

class SplashController extends GetxController {
  late Timer timer;
  @override
  void onInit() {
    _navigateToNextScreen();
    super.onInit();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  //*===================================================================== Check App validity ==========================================================*
  void _navigateToNextScreen() {
    timer = Timer(const Duration(seconds: 3), () async {
      Get.offAllNamed(AppRoutes.homeRoute);
    });
  }
}
