import 'package:bhabhi_thulla/constant/export_file.dart';
import 'package:bhabhi_thulla/models/pending_req_model.dart';

class DataController extends GetxController with BaseClass {
  MySocketController socketController = Get.find<MySocketController>();

  // List<PendingRequestModel> friends = [];
  List<PendingRequestModel> pendingRequests = [];

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
    getPendingRequests();
  }

  void _attachListeners() {
    socketController.socket.value?.on("friends_presence", myOnlineFriendsList);
    socketController.socket.value?.on("friendAdded", friendAdded);
    socketController.socket.value?.on(
      "friend_presence_changed",
      myOnlineOfflineFriendsUpdate,
    );
    socketController.socket.value?.on(
      "friendRequestReceived",
      friendRequestReceived,
    );
  }

  @override
  void onClose() {
    socketController.socket.value?.off("friends_presence");
    socketController.socket.value?.off("friend_presence_changed");
    socketController.socket.value?.off("friendRequestReceived");
    socketController.socket.value?.off("friendAdded");
    super.onClose();
  }

  void myOnlineFriendsList(dynamic data) {
    print("friends_presence: $data");
  }

  void myOnlineOfflineFriendsUpdate(dynamic data) {
    print("friend_presence_changed : $data");
  }

  void friendRequestReceived(dynamic data) {
    print("friendRequestReceived : $data");
  }

  void friendAdded(dynamic data) {
    print("friendAdded : $data");
  }

  void getPendingRequests() async {
    try {
      var res = await httpRequest(
        REQUEST.get,
        "$getPendingRequestsApiEP?receiverId=${getUserData().id}",
        {},
      );

      pendingRequests = (res["data"] as List)
          .map((e) => PendingRequestModel.fromJson(e))
          .toList();
    } catch (e) {
      showMySnackBar("$e", error: true);
    }
  }
}
