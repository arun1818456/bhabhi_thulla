import '../constant/export_file.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MySocketController(), permanent: true);
    Get.put(DataController(), permanent: true);
  }
}
