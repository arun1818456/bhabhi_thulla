import 'package:bhabhi_thulla/constant/local_keys.dart';
import 'package:bhabhi_thulla/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

mixin BaseClass {
  final storage = GetStorage();
  UserDataModel getUserData() {
    if (storage.hasData(LocalKeys.userData)) {
      return UserDataModel.fromJson(storage.read(LocalKeys.userData));
    } else {
      return UserDataModel();
    }
  }
}
