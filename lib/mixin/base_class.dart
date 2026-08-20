import 'package:bhabhi_thulla/constant/local_keys.dart';
import 'package:bhabhi_thulla/models/user_model.dart';
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
}
