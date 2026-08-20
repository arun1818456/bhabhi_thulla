import 'package:bhabhi_thulla/constant/local_keys.dart';
import 'package:bhabhi_thulla/models/user_model.dart';
import 'package:bhabhi_thulla/widgets/full_screen_loader.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_storage/get_storage.dart';
import '../constant/export_file.dart';

mixin BaseClass {
  final storage = GetStorage();
  UserDataModel getUserData() {
    if (storage.hasData(LocalKeys.userData)) {
      return UserDataModel.fromJson(storage.read(LocalKeys.userData));
    } else {
      return UserDataModel();
    }
  }

  Future getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      return allInfo;
    } catch (e) {
      debugPrint("Error fetching device info: $e");
    }
  }
  // Future getDeviceToken() async {
  //   NotificationSettings settings = await FirebaseMessaging.instance
  //       .requestPermission();
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     String? token = await FirebaseMessaging.instance.getToken();
  //
  //     debugPrint("🔥 FCM Device Token: $token");
  //     return token ?? "";
  //   } else {
  //     showDialog(
  //       context: Get.context!,
  //       builder: (context) => AlertDialog(
  //         title: const Text("Enable Notifications"),
  //         content: const Text(
  //           "Notifications are turned off. To receive updates, please enable notifications in settings.",
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text("Cancel"),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               Navigator.pop(context);
  //               await openAppSettings(); // from permission_handler package
  //             },
  //             child: const Text("Open Settings"),
  //           ),
  //         ],
  //       ),
  //     );
  //     return "";
  //   }
  // }

  void showCircularLoader() {
    Get.dialog(LoadingDialog(), barrierDismissible: false);
  }
}
