import 'package:bhabhi_thulla/modules/ui_widgets/chip_text_card.dart';
import 'package:bhabhi_thulla/modules/ui_widgets/image_card.dart';
import 'package:bhabhi_thulla/modules/ui_widgets/setting_dialog.dart';

import '../../constant/export_file.dart';

class LeftMenuWidget extends StatelessWidget {
  final HomeController controller;

  const LeftMenuWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 10,
      child: AnimatorWidget(
        effect: AnimationEffect.leftToRight,
        child: Column(
          children: [
            ChipWithText(
              size: 70,
              iconImage: AppImages.spinner,
              text: "Daily Spin",
              onTap: controller.onTapToSpinPage,
            ),
            const SizedBox(height: 15),
            ChipWithText(
              size: 50,
              iconImage: AppImages.settings,
              text: "Settings",
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: "",
                  barrierColor: Colors.black54,
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (_, aa, a) =>
                  const Center(child: SettingsDialog()),
                  transitionBuilder:
                      (context, animation, secondary, child) {
                    return ScaleTransition(
                      scale: CurvedAnimation(
                        parent: animation,
                        curve: Curves.elasticOut,
                      ),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomMenuWidget extends StatelessWidget {
  final HomeController controller;

  const BottomMenuWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 1,
      left: 0,
      right: 0,
      child: AnimatorWidget(
        effect: AnimationEffect.bottomToTop,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChipWithText(
              iconImage: AppImages.leaderboard,
              text: "Ranks",
              onTap: controller.onTapToRanks,
            ),
            const SizedBox(width: 25),
            ChipWithText(
              iconImage: AppImages.tutorial,
              text: "Training",
              onTap: () {},
            ),
            const SizedBox(width: 25),
            ChipWithText(
              iconImage: AppImages.friends,
              text: "Friends",
              onTap: controller.onTapToFriends,
            ),
          ],
        ),
      ),
    );
  }
}

class RightMenuWidget extends StatelessWidget {
  final HomeController controller;

  const RightMenuWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      right: 5,
      child: AnimatorWidget(
        effect: AnimationEffect.rightToLeft,
        child: Column(
          children: [
            ChipWithText(
              size: 55,
              iconImage: AppImages.gift,
              text: "Rewards",
              onTap: controller.onTapToRewards,
            ),
            const SizedBox(height: 15),
            ChipWithText(
              size: 50,
              iconImage: AppImages.store,
              text: "Shop",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class CenterGameCards extends StatelessWidget {
  final HomeController controller;

  const CenterGameCards({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GameImageCard(
              image: AppImages.soloPlay,
              onTap: controller.onTapSoloPlay,
            ),
            const SizedBox(width: 20),
            GameImageCard(
              image: AppImages.friendPlay,
              onTap: controller.onTapFriendPlay,
            ),
          ],
        ),
      ),
    );
  }
}