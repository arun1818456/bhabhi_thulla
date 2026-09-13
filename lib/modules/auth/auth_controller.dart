import 'package:uuid/uuid.dart';
import '../../constant/export_file.dart';

class AuthController extends GetxController with BaseClass {
  Future<void> onTapGuestLogin() async {
    try {
      final deviceId = await getUniqueDeviceId();

      debugPrint("DEVICE ID => $deviceId");

      final response = await httpRequest(REQUEST.post, guestLoginApiEP, {
        "deviceId": deviceId,
      });

      if (response["success"] == true) {
        await storage.write(LocalKeys.userData, response["data"]);

        Get.find<MySocketController>().initializeSocket();
        Get.find<DataController>().onInit();

        Get.offAllNamed(AppRoutes.homeScreen);
      }
    } catch (e) {
      debugPrint("Guest Login Error => $e");
    }
  }
}
