import 'package:bhabhi_thulla/constant/api_constant.dart';
import 'package:bhabhi_thulla/constant/local_keys.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../constant/export_file.dart';

class MySocketController extends GetxController with BaseClass {
  Rx<Socket?> socket = Rx<Socket?>(null);
  RxInt timeCount = 10.obs;
  Rx<Timer?> timer = Rx<Timer?>(null);
  RxBool isSocketConnected = false.obs;

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

  void findMatch({ required int entryFee}){
    if(socket.value == null || !socket.value!.connected){
      initializeSocket();
      return;
    }
    Map<String, dynamic> data = {
      "entryFee": entryFee,
    };
    debugPrint(">>>> find_match: ${data}");
    socket.value!.emit("find_match",data);
  }
}
