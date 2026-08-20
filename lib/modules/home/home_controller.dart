import 'package:bhabhi_thulla/constant/export_file.dart';
import 'package:bhabhi_thulla/controllers/socket_controller.dart';
import 'package:bhabhi_thulla/models/user_model.dart';

class HomeController extends GetxController with BaseClass{
  UserDataModel userData = UserDataModel();
  bool isSoloMode = false;
  bool isFriendPlayMode = false;
  bool isProfileMode = false;
  bool isFriendsMode = false;
  bool isRanksMode = false;
  bool isRewardsMode = false;
  bool spinPage = false;

  @override
  void onInit() {
    onInitData();
    super.onInit();
  }

  void onInitData(){
    userData=getUserData();
    MySocketController controller =MySocketController();
    controller.initializeSocket();
    update();
  }

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

  void onTapToRewards() {
    isRewardsMode = true;
    update();
  }

  void onTapToSpinPage() {
    spinPage = true;
    update();
  }
}
