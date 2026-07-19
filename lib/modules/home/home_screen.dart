import 'package:bhabhi_thulla/modules/home/home_controller.dart';
import 'package:bhabhi_thulla/widgets/solo_room.dart';

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
                      if (controller.isSoloMode) ...[
                        InkWell(
                          onTap: () {
                            controller.isSoloMode = false;
                            controller.update();
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.arrowBack,
                                height: 50,
                                width: 60,
                              ),
                              MyText(
                                text: "Solo Mode",
                                fontSize: 25,
                                color: Colors.yellow,
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
                          child: Image.asset(AppImages.p4),
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
                          headerChip(AppImages.moneyBag, "990"),
                          const SizedBox(width: 12),
                          headerChip(AppImages.diamond, "17"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              if (!controller.isSoloMode) ...[
                Positioned(
                  bottom: 50,
                  left: 10,
                  child: Column(
                    children: [
                      chipWithTxt(
                        iconImage: AppImages.lottery,
                        text: "Daily Spin",
                        onTap: () {},
                      ),
                      const SizedBox(height: 15),
                      chipWithTxt(
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
                      const SizedBox(width: 15),
                      chipWithTxt(
                        iconImage: AppImages.tutorial,
                        text: "Tutorial",
                        onTap: () {},
                      ),
                      const SizedBox(width: 15),

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
                        iconImage: AppImages.gift,
                        text: "Rewards",
                        onTap: () {},
                      ),
                      const SizedBox(height: 15),
                      chipWithTxt(
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
                        gameCards(image: AppImages.friendPlay, onTap: () {}),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                Center(child: SoloRoom()),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget headerChip(String icon, String value) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.centerLeft,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 22),
          padding: const EdgeInsets.only(left: 30, right: 5),
          decoration: BoxDecoration(
            color: Colors.black87,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 25,
                width: 25,
                child: Icon(Icons.add, color: Colors.black),
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
            Image.asset(iconImage, width: 45, height: 45),
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
