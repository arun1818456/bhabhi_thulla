import 'package:device_info_plus/device_info_plus.dart';
import 'package:bhabhi_thulla/constant/export_file.dart';

class AuthController extends GetxController {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<void> getGuestDeviceInfo() async {
    try {
      final deviceInfo = await _deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      debugPrint(">>>> Device Info: $allInfo");
      // Add your guest login logic here
    } catch (e) {
      debugPrint("Error fetching device info: $e");
    }
  }
}
