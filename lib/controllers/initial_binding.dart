import 'package:bhabhi_thulla/controllers/data_controller.dart';
import 'package:bhabhi_thulla/controllers/socket_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MySocketController(), permanent: true);
    Get.put(DataController(), permanent: true);
  }
}
