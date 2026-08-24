import 'package:bhabhi_thulla/constant/export_file.dart';

class FriendsController extends GetxController with BaseClass {
  final TextEditingController searchController = TextEditingController();
  FriendModel? searchedPlayer;

  List<FriendModel> pendingRequests = [
    FriendModel(
      name: "Neha Kapoor",
      pid: "5433253",
      level: 45,
      isOnline: false,
      avatar: AppImages.p12,
    ),
    FriendModel(
      name: "Vikram Singh",
      pid: "5433252",
      level: 12,
      isOnline: true,
      avatar: AppImages.p10,
    ),
  ];

  List<FriendModel> friends = [
    FriendModel(
      name: "Arun Kumar",
      pid: "5433244",
      level: 25,
      isOnline: true,
      avatar: AppImages.p1,
    ),
    // FriendModel(name: "Rahul Sharma", pid: "5433245", level: 18, isOnline: false, avatar: AppImages.p2),
    // FriendModel(name: "Saurav Singh", pid: "5433246", level: 32, isOnline: true, avatar: AppImages.p3),
    // FriendModel(name: "Amit Patel", pid: "5433247", level: 21, isOnline: false, avatar: AppImages.p4),
    // FriendModel(name: "Vijay Verma", pid: "5433248", level: 15, isOnline: true, avatar: AppImages.p5),
    // FriendModel(name: "Prakash Deep", pid: "5433249", level: 28, isOnline: true, avatar: AppImages.p6),
    // FriendModel(name: "Suraj Kumar", pid: "5433250", level: 10, isOnline: false, avatar: AppImages.p7),
    // FriendModel(name: "Deepak Raj", pid: "5433251", level: 40, isOnline: true, avatar: AppImages.p8),
  ];

  void searchPlayer() {
    String query = searchController.text.trim();
    if (query.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a PID to search",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    // Dummy search logic: Find a player not in current friends list
    if (query == "5433252") {
      searchedPlayer = FriendModel(
        name: "Vikram Singh",
        pid: "5433252",
        level: 12,
        isOnline: true,
        avatar: AppImages.p10,
      );
    } else if (query == "5433253") {
      searchedPlayer = FriendModel(
        name: "Neha Kapoor",
        pid: "5433253",
        level: 45,
        isOnline: false,
        avatar: AppImages.p12,
      );
    } else {
      searchedPlayer = null;
      Get.snackbar(
        "Not Found",
        "No player found with PID $query",
        backgroundColor: Colors.orangeAccent,
      );
    }
    update();
  }

  void sendRequest() {
    if (searchedPlayer == null) return;
    Get.snackbar(
      "Success",
      "Friend request sent to ${searchedPlayer!.name}!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    searchedPlayer = null;
    searchController.clear();
    update();
  }

  void acceptRequest(int index) {
    final request = pendingRequests.removeAt(index);
    friends.insert(0, request);
    update();
    showMySnackBar("${request.name} is now your friend!", success: true);
  }

  void rejectRequest(int index) {
    final request = pendingRequests.removeAt(index);
    update();
    showMySnackBar("Request from ${request.name} declined.");
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
