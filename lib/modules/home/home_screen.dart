import 'package:bhabhi_thulla/constant/images_text.dart';
import 'package:bhabhi_thulla/widgets/background_widget.dart';
import 'package:bhabhi_thulla/widgets/my_text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/export_file.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final w = size.width;
    // final h = size.height;

    // Widget menuButton(IconData icon, String text) {
    //   return Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Container(
    //         width: w * .09,
    //         height: w * .09,
    //         constraints: const BoxConstraints(minWidth: 50, minHeight: 50),
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.circular(16),
    //         ),
    //         child: Icon(icon),
    //       ),
    //       const SizedBox(height: 4),
    //       SizedBox(
    //         width: 80,
    //         child: Text(
    //           text,
    //           textAlign: TextAlign.center,
    //           style: const TextStyle(
    //             color: Colors.white,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),
    //     ],
    //   );
    // }

    return BackgroundWidget(
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: Get.width * 0.06,
                    height: Get.width * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 2, color: Colors.black),
                    ),
                    child: const Icon(Icons.person, size: 20),
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
                  text: "Leaderboards",
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
                  Image.asset(AppImages.soloPlay, height: Get.height / 2),
                  SizedBox(width: 20),
                  Image.asset(AppImages.friendPlay, height: Get.height / 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   body: Container(
    //     decoration: const BoxDecoration(
    //       gradient: LinearGradient(
    //         colors: [Color(0xff1c4db7), Color(0xff2f8fff)],
    //         begin: Alignment.topLeft,
    //         end: Alignment.bottomRight,
    //       ),
    //     ),
    //     child: SafeArea(
    //       child: Column(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.all(12),
    //             child: Row(
    //               children: [
    //                 Container(
    //                   width: 70,
    //                   height: 70,
    //                   decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.circular(18),
    //                   ),
    //                   child: const Icon(Icons.person, size: 40),
    //                 ),
    //                 const SizedBox(width: 10),
    //                 Expanded(
    //                   child: Container(
    //                     height: 70,
    //                     padding: const EdgeInsets.all(10),
    //                     decoration: BoxDecoration(
    //                       color: Colors.blue.shade700,
    //                       borderRadius: BorderRadius.circular(18),
    //                     ),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: const [
    //                         Text("Arun",
    //                             style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontWeight: FontWeight.bold)),
    //                         SizedBox(height: 8),
    //                         LinearProgressIndicator(value: .8),
    //                       ],
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               chip(Icons.monetization_on, "990"),
    //               const SizedBox(width: 12),
    //               chip(Icons.diamond, "17"),
    //             ],
    //           ),
    //           Expanded(
    //             child: Row(
    //               children: [
    //                 SizedBox(
    //                   width: w * .18,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       menuButton(Icons.key, "Premium"),
    //                       SizedBox(height: h * .03),
    //                       menuButton(Icons.block, "Remove Ads"),
    //                       SizedBox(height: h * .03),
    //                       menuButton(Icons.settings, "Settings"),
    //                     ],
    //                   ),
    //                 ),
    //                 Expanded(
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Wrap(
    //                         alignment: WrapAlignment.center,
    //                         spacing: 20,
    //                         runSpacing: 20,
    //                         children: [
    //                           card(
    //                               Colors.red,
    //                               Icons.emoji_events,
    //                               "CLASSIC\nMODE",
    //                               w * .28,
    //                               h * .28),
    //                           card(
    //                               Colors.green,
    //                               Icons.people,
    //                               "PLAY WITH\nFRIENDS",
    //                               w * .28,
    //                               h * .28),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   width: w * .18,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       menuButton(Icons.casino, "Daily Spin"),
    //                       SizedBox(height: h * .03),
    //                       menuButton(Icons.card_giftcard, "Rewards"),
    //                       SizedBox(height: h * .03),
    //                       menuButton(Icons.store, "Shop"),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(bottom: 16),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 menuButton(Icons.menu_book, "Tutorial"),
    //                 menuButton(Icons.people, "Friends"),
    //                 menuButton(Icons.leaderboard, "Leaderboard"),
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
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
}
