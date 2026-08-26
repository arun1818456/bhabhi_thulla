import '../../constant/export_file.dart';

class ProfileController extends GetxController with BaseClass {
  int selectedIndex = 0;
  String selectedImage = AppImages.p1;
  UserDataModel userData = UserDataModel();

  @override
  void onInit() {
    selectedIndex = 0;
    userData = getUserData();
    setInitData();
    super.onInit();
  }

  void setInitData() {
    selectedImage = AppImages.imageMap[userData.avatar] ?? AppImages.p1;
  }

  void onSelectOption(int index) {
    if (index == 0 || index == 1) {
      selectedIndex = index;
      update();
    }
  }

  void onTapToSelectIMage(String image) {
    selectedImage = image;
    update();
  }
}
