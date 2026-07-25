
 import 'package:bhabhi_thulla/constant/export_file.dart';

class ProfileController extends GetxController{
  int selectedIndex = 0;
  String selectedImage= AppImages.p1;

  void onSelectOption(int index) {
    if(index==0||index==1){
      selectedIndex = index;
      update();
    }
  }

  void  onTapToSelectIMage(String image){
    selectedImage=image;
    update();
  }
}