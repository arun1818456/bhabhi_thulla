import 'package:bhabhi_thulla/old_modules/home/view/two_player.dart';
import 'package:flutter/services.dart';
import 'package:bhabhi_thulla/constant/user_data.dart';
// import 'package:bhabhi_thulla/modules/home/view/two_player.dart';
import 'package:bhabhi_thulla/my_app.dart';
import 'package:bhabhi_thulla/widgets/network_image.dart';

import '../../../constant/colors.dart';
import '../../../constant/export_file.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int player = 2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        // color: AppColors.fadeGreyColor,
                      ),
                      child: NetworkImageWidget(
                        imageUrl: UserData.profileUrl,
                      ),
                    ),
                  ),
                  gap(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        UserData.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      if(UserData.userName!="")
                      Text(
                        UserData.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container()
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.room);
                  },
                  child: Container(
                    height: 45,
                    width: Get.width / 2,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(child: Text("Custom Room")),
                  ),
                )
              ],
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return index == 0
                              ? const TwoPlayers()
                              : index == 1
                                  ? const ThreePlayers()
                                  : index == 2
                                      ? const FourPlayer()
                                      : index == 3
                                          ? const FivePlayer()
                                          : const SizedBox();
                        },
                      ));
                    },
                    child: Container(
                      color: Colors.red,
                      child: Center(
                        child: Text("Player ${index + 2}"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
