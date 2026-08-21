import '../../constant/export_file.dart';

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
                      if (controller.isSoloMode ||
                          controller.isFriendPlayMode ||
                          controller.isFriendsMode ||
                          controller.isRanksMode ||
                          controller.isRewardsMode) ...[
                        InkWell(
                          onTap: controller.onTapArrowBack,
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
                                text: controller.isFriendPlayMode
                                    ? "Custom Room"
                                    : controller.isSoloMode
                                    ? "Solo Mode"
                                    : controller.isFriendsMode
                                    ? "Friends"
                                    : controller.isRanksMode
                                    ? "Global Ranks"
                                    : "Daily Rewards",
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
                              AppImages.imageMap[controller
                                      .userData
                                      .profileUrl] ??
                                  AppImages.p1,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          width: Get.width / 3 - 100,
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                text: controller.userData.name ?? "--------",
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
                          headerChip(
                            AppImages.moneyBag,
                            controller.userData.coins.toString(),
                            Colors.orange,
                          ),
                          const SizedBox(width: 12),
                          headerChip(
                            AppImages.diamond,
                            controller.userData.diamonds.toString(),
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
              ] else if (controller.isFriendPlayMode) ...[
                Center(child: FriendRoomScreen()),
              ] else if (controller.isFriendsMode) ...[
                Center(child: FriendsScreen()),
              ] else if (controller.isRanksMode) ...[
                Center(child: RanksScreen()),
              ] else if (controller.isRewardsMode) ...[
                Center(child: RewardsScreen()),
              ] else if (controller.spinPage) ...[
                Center(child: SpinnerScreen()),
              ] else ...[
                Stack(
                  children: [
                    LeftMenuWidget(controller: controller),
                    RightMenuWidget(controller: controller),
                    BottomMenuWidget(controller: controller),
                    CenterGameCards(controller: controller),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
