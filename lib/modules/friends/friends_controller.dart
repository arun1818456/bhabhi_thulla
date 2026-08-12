import 'package:bhabhi_thulla/constant/export_file.dart';
import '../../models/friend_model.dart';

class FriendsController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  FriendModel? searchedPlayer;

  List<FriendModel> friends = [
    FriendModel(name: "Arun Kumar", pid: "5433244", level: 25, isOnline: true, avatar: AppImages.p1),
    FriendModel(name: "Rahul Sharma", pid: "5433245", level: 18, isOnline: false, avatar: AppImages.p2),
    FriendModel(name: "Saurav Singh", pid: "5433246", level: 32, isOnline: true, avatar: AppImages.p3),
    FriendModel(name: "Amit Patel", pid: "5433247", level: 21, isOnline: false, avatar: AppImages.p4),
    FriendModel(name: "Vijay Verma", pid: "5433248", level: 15, isOnline: true, avatar: AppImages.p5),
    FriendModel(name: "Prakash Deep", pid: "5433249", level: 28, isOnline: true, avatar: AppImages.p6),
    FriendModel(name: "Suraj Kumar", pid: "5433250", level: 10, isOnline: false, avatar: AppImages.p7),
    FriendModel(name: "Deepak Raj", pid: "5433251", level: 40, isOnline: true, avatar: AppImages.p8),
  ];

  void searchPlayer() {
    String query = searchController.text.trim();
    if (query.isEmpty) {
      Get.snackbar("Error", "Please enter a PID to search", backgroundColor: Colors.redAccent, colorText: Colors.white);
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
      Get.snackbar("Not Found", "No player found with PID $query", backgroundColor: Colors.orangeAccent);
    }
    update();
  }

  void sendRequest() {
    if (searchedPlayer == null) return;
    Get.snackbar("Success", "Friend request sent to ${searchedPlayer!.name}!", backgroundColor: Colors.green, colorText: Colors.white);
    searchedPlayer = null;
    searchController.clear();
    update();
  }

  void removeFriend(int index) {
    friends.removeAt(index);
    update();
    Get.snackbar("Remove Friend", "Friend removed successfully!");
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
