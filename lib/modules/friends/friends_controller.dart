import 'package:bhabhi_thulla/constant/export_file.dart';
import 'package:bhabhi_thulla/controllers/data_controller.dart';
import 'package:bhabhi_thulla/models/pending_req_model.dart';

class FriendsController extends GetxController with BaseClass {
  final TextEditingController searchController = TextEditingController();
  DataController dataController = Get.find<DataController>();
  UserDataModel? searchedPlayer;
  List<PendingRequestModel> pendingRequests = [];

  List friends = [];

  @override
  void onInit() {
    onInitData();
    super.onInit();
  }

  void onInitData() {
    pendingRequests = dataController.pendingRequests;
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
      var res = await httpRequest(REQUEST.get, "$getUserByPIDApiEP/$query", {});
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
      Map data = {
        "senderId": getUserData().id,
        "receiverId": searchedPlayer!.id,
      };
      var res = await httpRequest(REQUEST.post, sendFriendRequestApiEP, data);
      showMySnackBar(
        "Friend request sent to ${searchedPlayer!.name}!",
        success: true,
      );
      // searchedPlayer = null;
      // searchController.clear();
    } catch (e) {
      showMySnackBar("$e", error: true);
    } finally {
      update();
    }
  }

  void acceptRequest(int index) {
    try {
      Map data = {
        "requestId": pendingRequests[index].sId,
        "receiverId": getUserData().id,
      };
      httpRequest(REQUEST.post, acceptFriendRequestApiEP, data);
    } catch (e) {
      showMySnackBar("$e", error: true);
    }
    // final request = pendingRequests.removeAt(index);
    // friends.insert(0, request);
    // update();
    // showMySnackBar("${request.name} is now your friend!", success: true);
  }

  void rejectRequest(int index) {
    try {
      Map data = {
        "requestId": pendingRequests[index].sId,
        "receiverId": getUserData().id,
      };
      httpRequest(REQUEST.post, rejectFriendRequestApiEP, data);
    } catch (e) {
      showMySnackBar("$e", error: true);
    }

    // final request = pendingRequests.removeAt(index);
    // update();
    // showMySnackBar("Request from ${request.name} declined.");
  }

  void removeFriend(int index) {
    final friend = friends[index];
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
                      friends.removeAt(index);
                      update();
                      Get.back();
                      showMySnackBar(
                        "${friend.name} removed successfully!",
                        success: true,
                      );
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
