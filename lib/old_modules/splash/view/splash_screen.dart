import '../../../constant/export_file.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: body(),
          );
        });
  }

  Widget body() {
    return const Center(
      child: Text(
        "Splash Screen",
        // style: w_700,
        textAlign: TextAlign.center,
      ),
    );
  }
}
