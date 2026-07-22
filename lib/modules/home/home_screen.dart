import 'package:bhabhi_thulla/modules/home/home_controller.dart';
import 'package:bhabhi_thulla/modules/ui_widgets/friends_room.dart';
import 'package:bhabhi_thulla/modules/ui_widgets/solo_room.dart';

import '../../constant/export_file.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return BackgroundWidget(
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
                                AppImages.arrowBack,
                                height: 45,
                                width: 55,
                              ),
                              MyText(
                                text: "Solo Mode",
                                fontSize: 23,
                                color: Colors.white,
                                borderColor: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        Container(
                          width: Get.width * 0.06,
                          height: Get.width * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.yellowAccent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 2, color: Colors.black),
                          ),
                          child: Image.asset(AppImages.p8),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: Get.width / 3 - 150,
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              MyText(text: "Arun Kumar", fontSize: 12),
                              SizedBox(height: 2),
                              LinearProgressIndicator(value: .8),
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
              ] else if (controller.isFriendMode)
                ...[
                  Center(child: FriendRoomScreen())

                ]
              else ...[
                Positioned(
                  bottom: 50,
                  left: 10,
                  child: Column(
                    children: [
                      chipWithTxt(
                        size: 50,
                        iconImage: AppImages.lottery,
                        text: "Daily Spin",
                        onTap: () {},
                      ),
                      const SizedBox(height: 15),
                      chipWithTxt(
                        size: 50,
                        iconImage: AppImages.settings,
                        text: "Settings",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 1,
                  left: 0,
                  right: 0,
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
                Positioned(
                  bottom: 50,
                  right: 5,
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

  Widget headerChip(String icon, String value, Color iconColor) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.centerLeft,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 12),
          padding: const EdgeInsets.only(left: 30, right: 5),
          decoration: BoxDecoration(
            color: Colors.black87.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 20,
                width: 20,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          child: SizedBox(height: 30, width: 35, child: Image.asset(icon)),
        ),
      ],
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
