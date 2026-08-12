import 'package:bhabhi_thulla/constant/export_file.dart';

class HomeController extends GetxController {
  bool isSoloMode = false;
  bool isFriendPlayMode = false;
  bool isProfileMode = false;
  bool isFriendsMode = false;
  bool isRanksMode = false;
  bool spinPage = false;

  void onTapSoloPlay() {
    isSoloMode = true;
    update();
  }

  void onTapFriendPlay() {
    isFriendPlayMode = true;
    update();
  }

  void onTapToProfile() {
    isProfileMode = true;
    update();
  }

  void onTapToFriends() {
    isFriendsMode = true;
    update();
  }

  void onTapToRanks() {
    isRanksMode = true;
    update();
  }

  void onTapToSpinPage() {
    spinPage = true;
    update();
  }
}
