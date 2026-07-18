import 'package:bhabhi_thulla/widgets/button.dart';
import 'package:bhabhi_thulla/widgets/friend_list_widget.dart';
import '../../../constant/export_file.dart';
import '../../../constant/user_data.dart';
import '../../../my_app.dart';
import '../../../widgets/network_image.dart';
import '../controller/room_lobby_controller.dart';

class RoomLobby extends StatefulWidget {
  const RoomLobby({super.key});

  @override
  State<RoomLobby> createState() => _RoomLobbyState();
}

class _RoomLobbyState extends State<RoomLobby> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: RoomLobbyController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Game Room"),
          ),
          body:  Column(
            children: [
              const Spacer(),
              CustomButton(text: "Start", onPressed: (){})
            ],
          ),
          drawer: Drawer(
            child: Column(
              children: [
                // Upper section (Profile and Stats)
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 62,
                          width: 62,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.lightBlueAccent)),
                          child: NetworkImageWidget(
                            imageUrl: UserData.profileUrl,
                          ),
                        ),
                      ),
                      gap(width: 10),
                      Column(
                        children: [
                          Text(
                            UserData.name,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          if (UserData.userName != "")
                            Text(
                              UserData.userName,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            )
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                          Get.back();
                          Get.toNamed(AppRoutes.addFriendScreen);
                        },
                        child: Container(
                          height: 35,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.person_add_alt),
                              Text(
                                "Add Friend",
                                style: TextStyle(fontSize: 6, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Total Friends",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "50",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Active Friends",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "10",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: 30,
                    padding: EdgeInsets.all(15),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FriendListWidget(
                        profileUrl: UserData.profileUrl,
                        isUserOnline: false,
                        name: 'Name ',
                        deviceToken: '1514',
                        userId: '5614514514',
                        userName: 'user Name ',
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        );
      },
    );
  }
}
