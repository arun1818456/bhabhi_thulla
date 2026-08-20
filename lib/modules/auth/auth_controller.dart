import 'package:bhabhi_thulla/constant/api_constant.dart';
import 'package:bhabhi_thulla/constant/export_file.dart';
import 'package:bhabhi_thulla/services/api_handler.dart';

import '../../constant/local_keys.dart';

class AuthController extends GetxController with BaseClass {
  Future<void> onTapGuestLogin() async {
    var deviceInfo = await getDeviceInfo();
    if (deviceInfo != null) {
      try{
       var response=await httpRequest(REQUEST.post, guestLoginApiEP, {
          "deviceId": deviceInfo["id"]
        });
       if(response["success"]){
         storage.write(LocalKeys.userData, response["data"]);
         Get.offAllNamed(AppRoutes.homeScreen);
       }
      }catch(e){
        debugPrint("Error:- $e");
      }
    }
  }
}
