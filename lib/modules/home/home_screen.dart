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
                                text:controller.isFriendMode?"Custom Room": "Solo Mode",
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
                      ] else ...[
                        GestureDetector(
                          onTap: controller.onTapToProfile,
                          child: Container(
                            width: Get.width * 0.06,
                            height: Get.width * 0.06,
                            decoration: BoxDecoration(
                              color: Colors.yellowAccent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 2, color: Colors.black),
                            ),
                            child: Image.asset(AppImages.p8),
                          ),
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
              ] else if (controller.isProfileMode)
                ...[]
              else if (controller.isFriendMode) ...[
                Center(child: FriendRoomScreen()),
              ] else ...[
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
