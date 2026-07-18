import 'package:bhabhi_thulla/constant/local_storage.dart';

import '../../../constant/export_file.dart';

class SplashController extends GetxController {
  late Timer timer;
  @override
  void onInit() {
    _navigateToNextScreen();
    super.onInit();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  //*===================================================================== Check App validity ==========================================================*
  void _navigateToNextScreen() {
    timer = Timer(const Duration(seconds: 3), () async {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;

      // if (user != null) {
      //   final userDoc = await FirebaseFirestore.instance
      //       .collection('users')
      //       .doc(user.uid)
      //       .get();
        // if (userDoc.exists) {
          // User exists in Firestore, proceed to the app
         await LocalStorage().getUserProfile();
          Get.offAllNamed(AppRoutes.homeRoute);
        // } else {
        //   // User does not exist in Firestore, log out and go to the welcome route
        //   await auth.signOut();
        //   Get.offAllNamed(AppRoutes.authenticate);
        // }
      // } else {
      //   // If no authenticated user, go to the welcome route
      //   Get.offAllNamed(AppRoutes.authenticate);
      // }
    });
  }
}
