import 'package:bhabhi_thulla/constant/local_storage.dart';

import '../../../constant/export_file.dart';
import '../models/user_model.dart';

class AuthenticationController extends GetxController {
  onTapGoogleSignUp() async {
    try {
      const List<String> scopes = <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ];
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: scopes).signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        String uid = user.uid;
        CollectionReference users = FirebaseFirestore.instance.collection('users');
        DocumentSnapshot userSnapshot = await users.doc(uid).get();
        if (userSnapshot.exists) {
          // User already exists, retrieve their data
          Map<String, dynamic>? userData =
              userSnapshot.data() as Map<String, dynamic>?;
          // print("User already exists. Data: $userData");
          LocalStorage().saveUserData(UserDataModel.fromJson(userData!));
        } else {
          // User doesn't exist, create a new user in Firestore
          Map<String, dynamic> newUserData = {
            'uid': user.uid,
            'name': user.displayName,
            'user_name': "",
            'email': user.email,
            'profile_url': user.photoURL,
            'device_token': "",
            'pass_key': "",
            'coins': "",
            "total_friends":"0"
          };
          print(newUserData);
          LocalStorage().saveUserData(UserDataModel.fromJson(newUserData));
          await users.doc(uid).set(newUserData);
        }
      }
      // loadingStop();
      Get.offAllNamed(AppRoutes.homeRoute);
    } catch (e) {
      // loadingStop();
      if (e.toString().contains('cloud_firestore/unavailable')) {
        // Message()
        //     .toast("Service unavailable. Please try again later.", error: true);
      } else {
        // Message().toast("Error during Google Sign-In: $e", error: true);
        // loadingStop();
      }
      print("Error during Google Sign-In: $e");
    }
  }
}
