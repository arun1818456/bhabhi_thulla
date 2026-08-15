import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import '../../constant/export_file.dart';

class SplashController extends GetxController {
  bool isAssetsLoaded = false;
  static ui.Image? coinUiImage;

  Future<void> precacheAllAssets(BuildContext context) async {
    final startTime = DateTime.now();

    final List<String> allImages = [
      AppImages.background,
      AppImages.diamonds,
      AppImages.moneyBag,
      AppImages.settings,
      AppImages.tutorial,
      AppImages.friends,
      AppImages.leaderboard,
      AppImages.store,
      AppImages.gift,
      AppImages.friendPlay,
      AppImages.soloPlay,
      AppImages.arrowBackBox,
      AppImages.coin,
      AppImages.cloud,
      AppImages.profile,
      AppImages.avatar,
      AppImages.emojis,
      AppImages.theme,
      AppImages.cards,
      AppImages.profileCard,
      AppImages.profileBgCard,
      AppImages.arrowFor,
      AppImages.starCard,
      AppImages.game,
      AppImages.won,
      AppImages.winTarget,
      AppImages.exit,
      AppImages.bhabhi,
      AppImages.thulla,
      AppImages.winStreak,
      AppImages.bestWin,
      AppImages.spinBg,
      AppImages.gameBg,
      // Profiles
      AppImages.p1, AppImages.p2, AppImages.p3, AppImages.p4, AppImages.p5,
      AppImages.p6, AppImages.p7, AppImages.p8, AppImages.p9, AppImages.p10,
      AppImages.p11, AppImages.p12, AppImages.p13, AppImages.p14, AppImages.p15,
      AppImages.p16, AppImages.p17, AppImages.p18, AppImages.p19, AppImages.p20,
      // Gifs
      AppImages.lockedGif,
      AppImages.loadingGif,
      AppImages.spinner,
    ];

    // 1. Precache standard images
    await Future.wait(
      allImages.map((imagePath) {
        return precacheImage(AssetImage(imagePath), context).catchError((e) {
          debugPrint("Failed to precache: $imagePath -> $e");
        });
      }),
    );

    // 2. Load UI Image for Spinner specifically (to avoid delay in SpinnerScreen)
    try {
      final ByteData data = await rootBundle.load(AppImages.coin);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      coinUiImage = frame.image;
    } catch (e) {
      debugPrint("Failed to load coin UI image: $e");
    }

    final endTime = DateTime.now();
    final elapsed = endTime.difference(startTime).inMilliseconds;
    
    if (elapsed < 1500) {
      await Future.delayed(Duration(milliseconds: 1500 - elapsed));
    }

    isAssetsLoaded = true;
    update();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Get.offAllNamed(AppRoutes.homeRoute);
  }
}
