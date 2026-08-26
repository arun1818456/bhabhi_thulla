import '../../constant/export_file.dart';

class AuthController extends GetxController with BaseClass {
  Future<void> onTapGuestLogin() async {
    var deviceInfo = await getDeviceInfo();
    if (deviceInfo != null) {
      try {
        var response = await httpRequest(REQUEST.post, guestLoginApiEP, {
          "deviceId": deviceInfo["id"] ?? "not-found",
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
