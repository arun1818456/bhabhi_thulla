import 'package:bhabhi_thulla/modules/profile/profile_screen.dart';
import 'package:bhabhi_thulla/modules/ui_widgets/spinner_screen.dart';

import '../../constant/export_file.dart';
import '../../widgets/animaton_effect.dart';
import '../ui_widgets/setting_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return BackgroundWidget(
          image: controller.spinPage ? AppImages.spinBg : null,
          opacity: controller.spinPage ? 1.0 : null,
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      if (controller.isSoloMode || controller.isFriendMode) ...[
                        InkWell(
                          onTap: () {
                            controller.isSoloMode = false;
                            controller.isFriendMode = false;
                            controller.update();
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.arrowBackBox,
                                height: 45,
                                width: 55,
                              ),
                              MyText(
                                text: controller.isFriendMode
                                    ? "Custom Room"
                                    : "Solo Mode",
                                fontSize: 23,
                                color: Colors.white,
                                borderColor: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ] else if (controller.isProfileMode) ...[
                        InkWell(
                          onTap: () {
                            controller.isProfileMode = false;
                            controller.update();
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.arrowBackBox,
                                height: 45,
                                width: 55,
                              ),
                              MyText(text: "My Profile", fontSize: 23),
                            ],
                          ),
                        ),
                      ] else if (controller.spinPage) ...[
                        InkWell(
                          onTap: () {
                            controller.spinPage = false;
                            controller.update();
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          child: Image.asset(
                            AppImages.arrowBackBox,
                            height: 45,
                            width: 55,
                          ),
                        ),
                      ] else ...[
                        InkWell(
                          onTap: controller.onTapToProfile,
                          child: Container(
                            width: Get.width * 0.07,
                            height: Get.width * 0.07,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages.profileBgCard),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: Image.asset(
                              AppImages.p9,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          width: Get.width / 3-100,
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              MyText(
                                text: "Arun Kumar",
                                fontSize: 17,
                                borderWidth: 4,
                              ),
                              SizedBox(height: 1),
                              Padding(
                                padding: EdgeInsets.only(right: 80),
                                child: LinearProgressIndicator(value: .8),
                              ),
                            ],
                          ),
                        ),
                      ],
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          headerChip(AppImages.moneyBag, "990", Colors.orange),
                          const SizedBox(width: 12),
                          headerChip(
                            AppImages.diamond,
                            "17",
                            Colors.lightBlueAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              if (controller.isSoloMode) ...[
                Center(child: SoloRoom()),
              ] else if (controller.isProfileMode) ...[
                Center(child: ProfileScreen()),
              ] else if (controller.isFriendMode) ...[
                Center(child: FriendRoomScreen()),
              ] else if (controller.spinPage) ...[
                Center(child: SpinnerScreen()),
              ] else ...[
                Positioned(
                  bottom: 50,
                  left: 10,
                  child: AnimatorWidget(
                    effect: AnimationEffect.leftToRight,
                    child: Column(
                      children: [
                        chipWithTxt(
                          size: 70,
                          iconImage: AppImages.spinner,
                          text: "Daily Spin",
                          onTap: controller.onTapToSpinPage,
                        ),
                        const SizedBox(height: 15),
                        chipWithTxt(
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
                              pageBuilder: (_, __, ___) {
                                return const Center(
                                  child: SettingsDialog(),
                                );
                              },
                              transitionBuilder: (context, animation, secondary, child) {
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
                ),
                Positioned(
                  bottom: 1,
                  left: 0,
                  right: 0,
                  child: AnimatorWidget(
                    effect: AnimationEffect.bottomToTop,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        chipWithTxt(
                          iconImage: AppImages.leaderboard,
                          text: "Ranks",
                          onTap: () {},
                        ),
                        const SizedBox(width: 25),
                        chipWithTxt(
                          iconImage: AppImages.tutorial,
                          text: "Training",
                          onTap: () {},
                        ),
                        const SizedBox(width: 25),

                        chipWithTxt(
                          iconImage: AppImages.friends,
                          text: "Friends",
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  right: 5,
                  child: AnimatorWidget(
                    effect: AnimationEffect.rightToLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        chipWithTxt(
                          size: 55,
                          iconImage: AppImages.gift,
                          text: "Rewards",
                          onTap: () {},
                        ),
                        const SizedBox(height: 15),
                        chipWithTxt(
                          size: 50,
                          iconImage: AppImages.store,
                          text: "Shop",
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 25),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        gameCards(
                          image: AppImages.soloPlay,
                          onTap: controller.onTapSoloPlay,
                        ),
                        SizedBox(width: 20),
                        gameCards(
                          image: AppImages.friendPlay,
                          onTap: controller.onTapFriendPlay,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget chipWithTxt({
    required String iconImage,
    required String text,
    required GestureTapCallback onTap,
    double? size,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Image.asset(iconImage, width: size ?? 45, height: size ?? 45),
            MyText(text: text, fontSize: 15),
          ],
        ),
      ),
    );
  }

  Widget gameCards({required String image, required GestureTapCallback onTap}) {
    return TweenAnimationBuilder(
      tween: Tween(begin: -5.0, end: 5.0),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.translate(offset: Offset(0, value), child: child);
      },
      child: InkWell(
        onTap: onTap,
        child: Image.asset(image, height: Get.height / 2),
      ),
    );
  }
}
