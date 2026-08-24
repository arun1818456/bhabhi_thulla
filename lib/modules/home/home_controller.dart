import 'package:bhabhi_thulla/constant/export_file.dart';

class HomeController extends GetxController with BaseClass {
  MySocketController socketController = Get.find<MySocketController>();
  final FriendsController friendsController = Get.put(FriendsController());
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

  void onInitData() {
    userData = getUserData();
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

  void onTapArrowBack() {
    isSoloMode = false;
    isFriendPlayMode = false;
    isFriendsMode = false;
    isRanksMode = false;
    isRewardsMode = false;
    isProfileMode = false;
    spinPage = false;
    SoloRoomController controller = SoloRoomController();
    controller.prizeSelected = null;
    controller.isMatchFounding = false;
    controller.stopSearchingAnimation();
    controller.update();
    update();
  }
}
