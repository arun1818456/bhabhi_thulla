
import 'dart:convert';

import 'package:bhabhi_thulla/constant/user_data.dart';
// import 'package:bhabhi_thulla/modules/auth/models/user_model.dart';

import '../main.dart';
import '../old_modules/auth/models/user_model.dart';

class LocalStorage {
  static const String userProfile = "responseData";

  saveUserData(UserDataModel? model) async {
    localStorage.write(userProfile, jsonEncode(model));
    getUserProfile();
  }

  Future<UserDataModel?> getUserProfile() async {
    Map<String, dynamic>? userMap;

    final userStr = await localStorage.read(userProfile);
    if (userStr != null) {
      try {
        userMap = jsonDecode(userStr) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }

    try {
      UserDataModel user = UserDataModel.fromJson(userMap);
      UserData.name=user.name??"";
      UserData.userName=user.userName??"";
      UserData.coins=user.coins??"";
      UserData.deviceToken=user.deviceToken??"";
      UserData.email=user.email??"";
      UserData.passKey=user.passKey??"";
      UserData.profileUrl=user.profileUrl??"";
      UserData.uid=user.uid??"";
      return user;
    } catch (e) {
      return null;
    }
  }
}
