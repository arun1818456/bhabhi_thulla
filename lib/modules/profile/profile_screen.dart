import 'package:bhabhi_thulla/constant/lists.dart';
import 'package:bhabhi_thulla/modules/profile/profile_controller.dart';

import '../../constant/export_file.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(),
      builder: (controller) => Container(
        margin: const EdgeInsets.only(top: 30),
        height: Get.height * 0.7,
        child: Row(
          children: [
            const SizedBox(width: 25),
            Column(
              children: List.generate(
                profileOptions.length,
                (index) => Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        controller.onSelectOption(index);
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Opacity(
                            opacity:index!=0 && index!=1? 0.5:1,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: controller.selectedIndex == index
                                    ? const Color(0xffA56B3E)
                                    : Colors.brown.shade500,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                                boxShadow: controller.selectedIndex == index
                                    ? [
                                        BoxShadow(
                                          color: Colors.amber.withValues(
                                            alpha: 0.8,
                                          ),
                                          blurRadius: 25,
                                          spreadRadius: 6,
                                        ),
                                        BoxShadow(
                                          color: Colors.orange.withValues(
                                            alpha: 0.5,
                                          ),
                                          blurRadius: 40,
                                          spreadRadius: 12,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Image.asset(
                                profileOptions[index],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          if (controller.selectedIndex == index)
                            Positioned(
                              left: 45,
                              top: -1,
                              child: Image.asset(
                                AppImages.arrowFor,
                                width: 50,
                                height: 50,
                              ),
                            ),
                          if(index!=0 && index!=1)
                          Positioned(
                            left: 32,
                            top: -1,
                            child: Image.asset(
                              AppImages.lockedGif,
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 45),

            if (controller.selectedIndex == 0) ...[
              SizedBox(
                height: Get.height,
                width: Get.width * 0.27,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(AppImages.profileCard, fit: BoxFit.fill),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Flexible(
                            flex: 5,
                            child: Container(
                              width: Get.width * 0.12,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImages.profileBgCard),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Image.asset(
                                controller.selectedImage,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          const FittedBox(child: MyText(text: 'ARUN')),
                          const Spacer(),
                          Flexible(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    child: MyText(
                                      text: "PID : 5433244",
                                      color: Colors.brown,
                                      borderColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: FittedBox(
                                    child: MyText(
                                      text: "Country : INDIA",
                                      color: Colors.brown,
                                      borderColor: Colors.transparent,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          const Flexible(
                            flex: 3,
                            child: FittedBox(
                              child: RankProgressWidget(
                                current: 100,
                                total: 300,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: profileDataList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 3.3,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Image.asset(
                              profileDataList[index]["image"] ??
                                  AppImages.avatar,
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyText(
                                      text: profileDataList[index]["title"],
                                      fontSize: 12,
                                      color: Colors.brown,
                                      borderColor: Colors.transparent,
                                    ),
                                    const SizedBox(height: 2),
                                    MyText(
                                      text:
                                          "${profileDataList[index]["value"]} ${profileDataList[index]["p"] ? " %" : ""}",
                                      fontSize: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ] else if (controller.selectedIndex == 1) ...[
              SizedBox(
                height: Get.height,
                width: Get.width * 0.27,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(AppImages.profileCard, fit: BoxFit.fill),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Flexible(
                            flex: 5,
                            child: Container(
                              width: Get.width * 0.12,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImages.profileBgCard),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Image.asset(
                                controller.selectedImage,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          const FittedBox(child: MyText(text: 'ARUN')),
                          const Spacer(),
                          Flexible(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    child: MyText(
                                      text: "PID : 5433244",
                                      color: Colors.brown,
                                      borderColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: FittedBox(
                                    child: MyText(
                                      text: "Country : INDIA",
                                      color: Colors.brown,
                                      borderColor: Colors.transparent,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Flexible(
                            flex: 2,
                            child: SizedBox(
                              height: 50,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFF176),
                                      Color(0xFFFFC107),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.amber.withValues(
                                        alpha: 0.5,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const MyText(
                                    text: "Select",
                                    fontSize: 16,
                                    borderWidth: 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: profileLists.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Row me 4 images
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final bool isSelected =
                        controller.selectedImage == profileLists[index];

                    return GestureDetector(
                      onTap: () {
                        controller.onTapToSelectIMage(profileLists[index]);
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.brown.shade500,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? Colors.amber : Colors.white,
                                width: isSelected ? 3 : 2,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: Colors.amber.withValues(
                                          alpha: 0.6,
                                        ),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Image.asset(
                              profileLists[index],
                              fit: BoxFit.contain,
                            ),
                          ),

                          /// Tick Icon
                          if (isSelected)
                            Positioned(
                              top: -2,
                              right: -2,
                              child: Container(
                                height: 22,
                                width: 22,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
