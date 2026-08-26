import '../../constant/export_file.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xff1c4db7),
          body: Stack(
            children: [
              // Hidden Warm-up Layer
              if (!controller.isAssetsLoaded)
                Opacity(
                  opacity: 0.001,
                  child: Stack(
                    children: [
                      Image.asset(AppImages.background),
                      Image.asset(AppImages.cloud),
                      Image.asset(AppImages.spinBg),
                      Image.asset(AppImages.gameBg),
                      Image.asset(AppImages.spinner),
                      // Image.asset(AppImages.spinGif),
                    ],
                  ),
                ),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyText(
                      text: "BHABHI THULLA",
                      fontSize: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    if (!controller.isAssetsLoaded)
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
