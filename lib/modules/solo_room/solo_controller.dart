import 'package:bhabhi_thulla/models/lobby_model.dart';

import '../../constant/export_file.dart';

class SoloRoomController extends GetxController with BaseClass {
  MySocketController socketController = Get.find<MySocketController>();
  UserDataModel userData = UserDataModel();
  LobbyModel lobbyModel = LobbyModel();

  // Local variables
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
    socketController.socket.value!.on('lobby_created', onLobbyCreated);
    socketController.socket.value!.on('match_status', onMatchStatus);
    socketController.socket.value!.on('lobby_error', onLobbyError);
    socketController.socket.value!.on('lobbyUpdated', onLobbyUpdated);
    socketController.socket.value!.on('inviteFailed', onInviteFailed);
    socketController.socket.value!.on('inviteRejected', inviteRejected);
    super.onInit();
  }

  @override
  void onClose() {
    searchTimer?.cancel();
    super.onClose();
    socketController.socket.value!.off('lobby_error');
    socketController.socket.value!.off('match_status');
    socketController.socket.value!.off('lobby_created');
    socketController.socket.value!.off('lobbyUpdated');
    socketController.socket.value!.off('inviteFailed');
    socketController.socket.value!.off('inviteRejected');
  }

  void onTapToSelectPrize(int entryFee) {
    prizeSelected = entryFee;
    socketController.onCreateLobby(entryFee);
    update();
  }

  void onTapStartMatch() {
    startSearchingAnimation();
    isMatchFounding = true;
    socketController.findMatch(entryFee: prizeSelected ?? 160);
    update();
    // CloudTransition.push(context, const GameScreen());
  }

  void onTapToJoinFriend() {
    final dataController = Get.find<DataController>();
    List<UserDataModel> onlineFriends = [];
    for (var element in dataController.myFriends) {
      if (element.isOnline == true) {
        onlineFriends.add(element);
      }
    }

    if (onlineFriends.isEmpty) {
      Get.snackbar(
        "No Friends Online",
        "All of your friends are currently offline.",
        backgroundColor: const Color(0xFFFFC857),
        colorText: Colors.black,
      );
      return;
    }

    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        backgroundColor: Colors.transparent,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: Get.width / 2,
            height: Get.height - 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF111A3E), Color(0xFF1A1E42)],
              ),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.black, width: 4),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: 52,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E8CFF),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Stack(
                    children: [
                      const Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.people_alt_rounded,
                              size: 26,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "ONLINE FRIENDS",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 12,
                        top: 12,
                        child: GestureDetector(
                          onTap: Get.back,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView.separated(
                      itemCount: onlineFriends.length,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      separatorBuilder: (_, a) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final friend = onlineFriends[index];
                        return GestureDetector(
                          onTap: (){
                            socketController.sendInviteRequest(userId: friend.id??"");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1C244D),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFF4B6FFF),
                                width: 1.2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFF56D8FF),
                                          width: 1.5,
                                        ),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF2B3A7A),
                                            Color(0xFF171D45),
                                          ],
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Image.asset(
                                          AppImages.imageMap[friend.avatar] ??
                                              AppImages.p1,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: -3,
                                      bottom: -2,
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF38D46A),
                                          shape: BoxShape.circle,
                                          border: Border.fromBorderSide(
                                            BorderSide(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        text: friend.name ?? "",
                                        fontSize: 15,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0,
                                      ),
                                      const SizedBox(height: 2),
                                      MyText(
                                        text:
                                            "LVL ${friend.level} • PID ${friend.pid}",
                                        fontSize: 11,
                                        color: Colors.amberAccent,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF2DD7A6,
                                    ).withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color: const Color(0xFF46E7C2),
                                      width: 1.2,
                                    ),
                                  ),
                                  child: const MyText(
                                    text: "Invite",
                                    fontSize: 11,
                                    color: Colors.greenAccent,
                                    borderColor: Colors.transparent,
                                    borderWidth: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //// Socket Listeners
  void onMatchStatus(dynamic data) {
    debugPrint(">>onMatch Status >>> $data");
  }

  void onLobbyUpdated(dynamic data) {
    debugPrint(">>onLobbyUpdated >>> $data");
  }

  void onInviteFailed(dynamic data) {
    debugPrint(">>onInviteFailed >>> $data");
  }

  void inviteRejected(dynamic data) {
    debugPrint(">>inviteRejected >>> $data");
  }

  void onLobbyError(dynamic data) {
    prizeSelected = null;
    showMySnackBar(data["message"]);
    update();
    debugPrint(">>onLobbyError >>> $data");
  }

  void onLobbyCreated(dynamic data) {
    debugPrint(">>onLobbyCreated >>> $data");
    if (data != null) {
      lobbyModel = LobbyModel.fromJson(data);
      update();
    }
  }
}
