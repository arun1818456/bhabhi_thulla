import 'package:bhabhi_thulla/constant/export_file.dart';

class DataController extends GetxController with BaseClass {
  MySocketController socketController = Get.find<MySocketController>();
  UserDataModel userData = UserDataModel();

  // List<PendingRequestModel> friends = [];
  List<PendingRequestModel> pendingRequests = [];
  List<UserDataModel> myFriends = [];

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

    if (storage.hasData(LocalKeys.userData)) {
      userData = getUserData();
      getPendingRequests();
    }
  }

  void _attachListeners() {
    socketController.socket.value?.on("friendRemoved", friendRemovedFromList);
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
    socketController.socket.value?.off("friendRemoved");
    socketController.socket.value?.off("friend_presence_changed");
    socketController.socket.value?.off("friendRequestReceived");
    socketController.socket.value?.off("friendAdded");
    super.onClose();
  }

  void friendRemovedFromList(dynamic data) {
    print("friends_presence: $data");
    final String userId = data["userId"].toString();
    myFriends.removeWhere((friend) => friend.id == userId);
    if (Get.isRegistered<FriendsController>()) {
      final FriendsController friendsController = Get.find<FriendsController>();
      friendsController.myFriends = myFriends;
      friendsController.update();
    }
    update();
  }

  void myOnlineOfflineFriendsUpdate(dynamic data) {
    print("friend_presence_changed : $data");
    final friendData = Map<String, dynamic>.from(data["friend"]);
    final String userId = friendData["userId"].toString();
    final bool isOnline = friendData["isOnline"] ?? false;
    final index = myFriends.indexWhere((friend) => friend.id == userId);
    if (index != -1) {
      myFriends[index].isOnline = isOnline;
      update();
      if (Get.isRegistered<FriendsController>()) {
        final FriendsController friendsController =
            Get.find<FriendsController>();
        friendsController.myFriends = myFriends;
        friendsController.update();
      }
    }
  }

  void friendRequestReceived(dynamic data) {
    print("friendRequestReceived : $data");

    // ==========================================
    // Convert socket data to model
    // ==========================================

    final request = PendingRequestModel.fromJson(
      Map<String, dynamic>.from(data),
    );

    // Add to pending requests
    pendingRequests.add(request);

    // ==========================================
    // Get FriendsController safely
    // ==========================================

    if (!Get.isRegistered<FriendsController>()) {
      Get.put(FriendsController());
    }

    final FriendsController friendsController = Get.find<FriendsController>();
    friendsController.pendingRequests = pendingRequests;
    friendsController.update();
    // ==========================================
    // Request ID
    // ==========================================

    final String? requestId = request.sId;

    // ==========================================
    // Show notification
    // ==========================================

    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: Colors.transparent,
        snackPosition: SnackPosition.TOP,

        duration: const Duration(seconds: 8),

        margin: const EdgeInsets.only(left: 8, right: 8, top: 25),

        padding: EdgeInsets.zero,

        snackStyle: SnackStyle.FLOATING,

        messageText: FriendRequestNotification(
          data: request,
          onAccept: () {
            if (requestId == null) {
              print("❌ Request ID is null");
              return;
            }

            friendsController.acceptRequest(
              receiverId: getUserData().id!,
              requestId: requestId,
            );
            pendingRequests.removeWhere((element) => element.sId == requestId);
            update();
            Get.closeCurrentSnackbar();
          },

          onReject: () {
            if (requestId == null) {
              print("❌ Request ID is null");
              return;
            }

            friendsController.rejectRequest(requestId: requestId);
            pendingRequests.removeWhere((element) => element.sId == requestId);
            update();
            Get.closeCurrentSnackbar();
          },

          onClose: () {
            Get.closeCurrentSnackbar();
          },
        ),
      ),
    );

    update();
  }

  void friendAdded(dynamic data) {
    print("friendAdded : $data");
    myFriends.add(UserDataModel.fromJson(data));
    if (!Get.isRegistered<FriendsController>()) {
      Get.put(FriendsController());
    }

    final FriendsController friendsController = Get.find<FriendsController>();
    friendsController.myFriends = myFriends;
    friendsController.update();
    update();
  }

  void getPendingRequests() async {
    try {
      var res = await httpRequest(
        REQUEST.get,
        getConnectionsRequestsApiEP,
        {},
        token: userData.token ?? "",
      );

      pendingRequests = (res["data"]?["requests"] as List)
          .map((e) => PendingRequestModel.fromJson(e))
          .toList();
      myFriends = (res["data"]?["friends"] as List)
          .map((e) => UserDataModel.fromJson(e))
          .toList();
    } catch (e) {
      showMySnackBar("$e", error: true);
    }
  }
}
