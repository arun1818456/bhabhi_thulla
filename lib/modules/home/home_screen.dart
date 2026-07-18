import 'package:bhabhi_thulla/widgets/background_widget.dart';
import 'package:flutter/material.dart';

import '../../constant/export_file.dart';
import '../../constant/images_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    Widget menuButton(IconData icon, String text) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: w * .09,
            height: w * .09,
            constraints: const BoxConstraints(minWidth: 50, minHeight: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 80,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }

    return BackgroundWidget(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: Get.width*0.05,
                height: Get.width*0.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person, size: 20),
              ),
              const SizedBox(width: 10),
              Container(
                height: Get.width*0.05,
                width: Get.width/3-50,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Arun",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10
                      ),
                    ),
                    SizedBox(height: 2),
                    LinearProgressIndicator(value: .8),
                  ],
                ),
              ),
              Spacer(),
            ],
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

  Widget chip(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.amber),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget card(Color color, IconData icon, String title, double w, double h) {
    return Container(
      width: w.clamp(140, 260),
      height: h.clamp(180, 320),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
