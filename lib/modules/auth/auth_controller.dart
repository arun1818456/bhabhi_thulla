import 'dart:math';

import '../../constant/export_file.dart';

class AuthController extends GetxController with BaseClass {
  Future<void> onTapGuestLogin() async {
    var deviceInfo = await getDeviceInfo();
    if (deviceInfo != null) {
      try {
        final value = 100000 + Random().nextInt(900000);
        var response = await httpRequest(REQUEST.post, guestLoginApiEP, {
          "deviceId": deviceInfo["id"] ?? "${value.toString()}deleteafteruser",
        });
        if (response["success"]) {
          storage.write(LocalKeys.userData, response["data"]);
          Future.delayed(Duration(seconds: 3), () {
            Get.find<MySocketController>().initializeSocket();
            Get.find<DataController>().onInit();
            Get.offAllNamed(AppRoutes.homeScreen);
          });
        }
      } catch (e) {
        debugPrint("Error:- $e");
      }
    }
  }
}
