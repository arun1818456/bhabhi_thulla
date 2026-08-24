import 'package:bhabhi_thulla/constant/export_file.dart';

class DataController extends GetxController with BaseClass {
  MySocketController socketController = Get.find<MySocketController>();

  @override
  void onInit() {
    super.onInit();
    if (socketController.socket.value != null) {
      _attachListeners();
    }
    // Handle case where socket might be initialized after this controller
    ever(socketController.socket, (socket) {
      if (socket != null) {
        _attachListeners();
      }
    });
  }

  void _attachListeners() {
    socketController.socket.value?.on("friends_presence", myOnlineFriendsList);
    socketController.socket.value?.on(
      "friend_presence_changed",
      myOnlineOfflineFriendsUpdate,
    );
  }

  @override
  void onClose() {
    socketController.socket.value?.off("friends_presence");
    socketController.socket.value?.off("friend_presence_changed");
    super.onClose();
  }

  void myOnlineFriendsList(dynamic data) {
    print("friends_presence: $data");
  }

  void myOnlineOfflineFriendsUpdate(dynamic data) {
    print("friend_presence_changed : $data");
  }
}
