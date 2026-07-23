import 'package:bhabhi_thulla/constant/export_file.dart';

class HomeController extends GetxController {
  bool isSoloMode = false;
  bool isFriendMode = false;
  bool isProfileMode=false;
  void onTapSoloPlay() {
    isSoloMode = true;
    update();
  }
  void onTapFriendPlay() {
    isFriendMode = true;
    update();
  }
  void onTapToProfile() {
    isProfileMode = true;
    update();
  }
}
