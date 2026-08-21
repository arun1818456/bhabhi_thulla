import 'package:bhabhi_thulla/constant/export_file.dart';
import 'package:bhabhi_thulla/controllers/socket_controller.dart';
import 'package:bhabhi_thulla/models/user_model.dart';

class SoloRoomController extends GetxController with BaseClass {
  MySocketController socketController = Get.find<MySocketController>();
  UserDataModel userData = UserDataModel();
  int? prizeSelected;
  bool isMatchFounding = false;

  int searchCount = 1;
  Timer? searchTimer;

  void startSearchingAnimation() {
    searchCount = 1;
    update();
    searchTimer?.cancel();
    searchTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      searchCount++;
      if (searchCount > 3) {
        searchCount = 1;
      }
      update();
    });
  }

  void stopSearchingAnimation() {
    searchTimer?.cancel();
    searchTimer = null;
    searchCount = 1;
    update();
  }

  @override
  void onInit() {
    userData = getUserData();
    super.onInit();
  }

  @override
  void onClose() {
    searchTimer?.cancel();
    super.onClose();
  }


  void onTapToSelectPrize(int entryFee) {
    prizeSelected = entryFee;
    update();
  }

  void onTapStartMatch() {
    startSearchingAnimation();
    isMatchFounding = true;
    socketController.findMatch(playerCount: 4, entryFee: prizeSelected ?? 160);
    update();
    // CloudTransition.push(context, const GameScreen());
  }
}
