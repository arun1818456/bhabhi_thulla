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

  void showMySnackBar(
    String message, {
    bool error = false,
    int? second = 2,
    bool success = false,
    bool alert = false,
  }) {
    Get.closeAllSnackbars();

    final borderColor = success
        ? const Color(0xffFFD54F)
        : alert
        ? Colors.orangeAccent
        : Colors.redAccent;

    final icon = success
        ? Icons.emoji_events_rounded
        : alert
        ? Icons.warning_amber_rounded
        : Icons.cancel_rounded;

    Get.showSnackbar(
      GetSnackBar(
        maxWidth: Get.width * 0.5,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(top: 18, left: 16, right: 16),
        padding: EdgeInsets.zero,
        duration: Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 450),
        borderRadius: 18,

        messageText: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xff2B1B0F),
                Color(0xff5A3720),
              ],
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: borderColor.withOpacity(0.45),
                blurRadius: 18,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffFFD54F),
                      Color(0xffFFB300),
                    ],
                  ),
                ),
                child: Icon(icon, color: Colors.white, size: 26),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      success
                          ? "VICTORY!"
                          : alert
                          ? "WARNING!"
                          : "FAILED!",
                      style: const TextStyle(
                        color: Color(0xffFFE082),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
