import 'package:bhabhi_thulla/modules/ui_widgets/lobby_request_notification.dart';

import '../constant/export_file.dart';

class MySocketController extends GetxController with BaseClass {
  Rx<Socket?> socket = Rx<Socket?>(null);
  RxInt timeCount = 10.obs;
  Rx<Timer?> timer = Rx<Timer?>(null);
  RxBool isSocketConnected = false.obs;

  @override
  void onInit() {
    // Only connect if user is already logged in
    if (storage.hasData(LocalKeys.userData)) {
      initializeSocket();
    }
    super.onInit();
  }

  void initializeSocket() {
    if (socket.value != null) {
      if (!socket.value!.connected) {
        debugPrint("-----------Socket Reconnected-----------");
        socket.value!.connect();
      } else {
        joinGame();
      }
    } else {
      debugPrint("-----------Socket Init-----------");
      socket.value = io(baseUrl, {
        'autoConnect': false,
        'transports': ['websocket'],
        'reconnection': true,
      });

      socket.value!.onConnect((_) {
        debugPrint("-----------Socket Connected-----------");
        joinGame();

        if (timer.value != null) {
          timer.value!.cancel();
        }
        isSocketConnected.value = true;
        update();
      });

      socket.value!.onDisconnect((_) {
        debugPrint("-----------Socket Disconnected-----------");
        if (storage.hasData(LocalKeys.userData) &&
            getUserData().token != null &&
            getUserData().token.toString().isNotEmpty) {
          startTimer();
        }
        isSocketConnected.value = false;
        update();
      });

      socket.value!.onConnectError((e) {
        debugPrint("-----------Socket Connection Error == $e-----------");
        if (storage.hasData(LocalKeys.userData) &&
            getUserData().token != null &&
            getUserData().token.toString().isNotEmpty) {
          startTimer();
        }
        isSocketConnected.value = false;
        update();
      });
      onMethods();
      socket.value!.connect();
    }
  }

  /// to reconnect the socket
  void startTimer() {
    timeCount.value = 10;
    if (timer.value != null) {
      timer.value!.cancel();
    }
    update();
    timer.value = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (timeCount.value < 1) {
        initializeSocket();
        timer.cancel();
        Future.delayed(Duration(milliseconds: 1000), () {
          if (!socket.value!.connected) {
            startTimer();
          }
        });
      } else {
        timeCount.value = timeCount.value - 1;
      }
      update();
    });
  }

  /// //////////
  void joinGame() {
    if (storage.hasData(LocalKeys.userData) &&
        getUserData().id != null &&
        getUserData().id.toString().isNotEmpty) {
      Map<String, dynamic> data = {
        "userId": getUserData().id,
        "name": getUserData().name,
      };
      debugPrint("-----------Socket Joining Game: $data-----------");
      socket.value?.emit("join_game", data);
    }
  }

  void findMatch({required int entryFee}) {
    if (socket.value == null || !socket.value!.connected) {
      initializeSocket();
      return;
    }
    Map<String, dynamic> data = {"entryFee": entryFee};
    debugPrint(">>>> find_match: $data");
    socket.value!.emit("find_match", data);
  }

  void onCreateLobby(int entryFee) {
    if (socket.value == null || !socket.value!.connected) {
      initializeSocket();
      return;
    }
    Map<String, dynamic> data = {"entryFee": entryFee};
    debugPrint(">>>> create_lobby: $data ");
    socket.value!.emit("create_lobby", data);
  }

  void leaveLobby() {
    if (socket.value == null || !socket.value!.connected) {
      initializeSocket();
      return;
    }
    Map<String, dynamic> data = {"userId": getUserData().id};
    debugPrint(">>>> leave_lobby: $data");
    socket.value!.emit("leaveLobby", data);
  }

  void sendFriendRequest({
    required String friendId,
    required String friendName,
  }) {
    if (socket.value == null || !socket.value!.connected) {
      initializeSocket();
      return;
    }
    Map<String, dynamic> data = {
      "userId": getUserData().id,
      "userName": getUserData().name,
      "friendId": friendId,
      "friendName": friendName,
    };
    debugPrint(">>>> send_friend_request: $data");
    socket.value!.emit("send_play_request", data);
  }

  void sendInviteRequest({required String userId}) {
    print(">>> Send Invite ");
    try {
      socket.value?.emit("invite_player", {"id": userId});
      showMySnackBar("Invite Send", success: true);
    } catch (e) {
      showMySnackBar(e.toString(), error: true);
    }
  }

  void onAcceptRequest({required String lobbyId}) {
    print(">>> Accepted ");
    try {
      socket.value!.emit("accept_invite", {"lobbyId": lobbyId});
    } catch (e) {
      showMySnackBar(e.toString(), error: true);
    }
  }

  void disconnectSocket() {
    if (socket.value != null) {
      debugPrint("-----------Socket Manual Disconnect-----------");
      socket.value!.disconnect();
      socket.value = null;
      isSocketConnected.value = false;
      if (timer.value != null) {
        timer.value!.cancel();
      }
      update();
    }
  }

  void onMethods() {
    socket.value!.on("inviteFailed", (msg) {
      debugPrint(">>inviteFailed>>> $msg");
    });
    socket.value!.on("join_failed", (msg) {
      debugPrint(">>join_failed>>>$msg");
    });
    socket.value!.on("lobby_error", (msg) {
      debugPrint(">>lobby_error>>>$msg");
    });
    socket.value!.on("lobby_invite", (data) {
      print("lobby_invite >>${data}");
      final lobbyId = data["lobbyId"];
      final ownerId = data["ownerId"];
      final avatar = data["avatar"];
      final level = data["level"];
      final name = data["name"];
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.transparent,
          snackPosition: SnackPosition.TOP,

          duration: const Duration(seconds: 8),

          margin: const EdgeInsets.only(left: 8, right: 8, top: 25),

          padding: EdgeInsets.zero,

          snackStyle: SnackStyle.FLOATING,

          messageText: LobbyRequestNotification(
            name: name.toString(),
            avatar: AppImages.imageMap[avatar] ?? AppImages.p1,
            level: level.toString(),
            onJoin: () {
              onAcceptRequest(lobbyId: lobbyId);
              Get.closeCurrentSnackbar();
            },
            onDecline: () {
              print(">>>>> DEcline");
              socket.value!.emit("reject_invite", {"ownerId": ownerId});
              Get.closeCurrentSnackbar();
            },
            onClose: onClose,
          ),
        ),
      );
    });
  }
}
