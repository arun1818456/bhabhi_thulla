import '../../constant/export_file.dart';

class FriendsController extends GetxController with BaseClass {
  final TextEditingController searchController = TextEditingController();
  DataController dataController = Get.find<DataController>();
  UserDataModel userData = UserDataModel();
  UserDataModel? searchedPlayer;
  List<FriendRequestModel> pendingRequests = [];
  List<UserDataModel> myFriends = [];

  @override
  void onInit() {
    onInitData();
    super.onInit();
  }

  void onInitData() {
    userData = getUserData();
    pendingRequests = dataController.pendingRequests;
    myFriends = dataController.myFriends;
    update();
  }

  Future<void> searchPlayer() async {
    String query = searchController.text.trim();
    if (query.isEmpty) {
      showMySnackBar("Please enter a PID to search", error: true);
      return;
    }
    try {
      searchedPlayer = null;
      var res = await httpRequest(
        REQUEST.get,
        "$getUserByPIDApiEP/$query",
        {},
        token: userData.token ?? "",
      );
      searchedPlayer = UserDataModel.fromJson(res["data"]);
    } catch (e) {
      showMySnackBar("$e", error: true);
    } finally {
      update();
    }
  }

  Future<void> sendRequest() async {
    if (searchedPlayer == null) return;
    try {
      Map data = {"receiverId": searchedPlayer!.id};
      await httpRequest(
        REQUEST.post,
        sendFriendRequestApiEP,
        data,
        token: userData.token ?? "",
      );
      showMySnackBar(
        "Friend request sent to ${searchedPlayer!.name}!",
        success: true,
      );
      searchedPlayer = null;
      searchController.clear();
    } catch (e) {
      showMySnackBar("$e", error: true);
    } finally {
      update();
    }
  }

  void acceptRequest({required String requestId, required String receiverId}) {
    try {
      Map data = {"requestId": requestId, "receiverId": receiverId};
      httpRequest(
        REQUEST.post,
        acceptFriendRequestApiEP,
        data,
        token: userData.token ?? "",
      );
    } catch (e) {
      showMySnackBar("$e", error: true);
    }
    pendingRequests.removeWhere((element) => element.sId == requestId);
    dataController.pendingRequests.removeWhere(
      (element) => element.sId == requestId,
    );
    dataController.update();
    update();
  }

  Future<void> rejectRequest({required String requestId}) async {
    try {
      Map data = {"requestId": requestId};
      await httpRequest(
        REQUEST.post,
        rejectFriendRequestApiEP,
        data,
        token: userData.token ?? "",
      );
      pendingRequests.removeWhere((element) => element.sId == requestId);
      dataController.pendingRequests.removeWhere(
        (element) => element.sId == requestId,
      );
      dataController.update();
    } catch (e) {
      showMySnackBar("$e", error: true);
    }

    update();
  }

  Future<void> removeMyFriend({required String friendId}) async {
    try {
      await httpRequest(
        REQUEST.delete,
        "$removeMyFriendApiEP/$friendId",
        {},
        token: userData.token ?? "",
      );
      myFriends.removeWhere((element) => element.id == friendId);
      dataController.myFriends.removeWhere((element) => element.id == friendId);
      dataController.update();
      update();
    } catch (e) {
      showMySnackBar("$e", error: true);
    }
  }

  void removeFriend(int index) {
    final friend = myFriends[index];
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: Get.width * 0.4,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xffa16b47),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xff7a4d2e), width: 6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MyText(
                text: "Remove Friend",
                fontSize: 28,
                borderWidth: 4,
                color: Colors.white,
                borderColor: Colors.black87,
              ),
              const SizedBox(height: 20),
              MyText(
                text: "Are you sure you want to remove ${friend.name}?",
                fontSize: 18,
                borderColor: Colors.transparent,
                textAlign: TextAlign.center,
                color: Colors.white,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel Button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const MyText(text: "CANCEL", fontSize: 16),
                    ),
                  ),
                  // Confirm Button
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      removeMyFriend(friendId: myFriends[index].id ?? "");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const MyText(text: "REMOVE", fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
