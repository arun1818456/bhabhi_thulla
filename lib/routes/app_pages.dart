
// import 'package:bhabhi_thulla/modules/auth/view/authentication_page.dart';
// import 'package:bhabhi_thulla/modules/home/view/add_friend_screen.dart';
// import 'package:bhabhi_thulla/modules/home/view/home_screen.dart';
// import 'package:bhabhi_thulla/modules/home/view/room_lobby.dart';
// import 'package:bhabhi_thulla/modules/splash/view/splash_screen.dart';

import '../constant/export_file.dart';
import '../modules/home/home_screen.dart';
import '../old_modules/splash/view/splash_screen.dart';

class AppPages {
  static const init = AppRoutes.splashRoute;

  static final routes = [

    // Authentication Routes----------------------------------------------------
    //
    GetPage(
      name: AppRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.homeRoute,
      page: () => const HomeScreen(),
    ),
    // GetPage(
    //   name: AppRoutes.authenticate,
    //   page: () => const AuthenticationPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.room,
    //   page: () => const RoomLobby(),
    // ),
    // GetPage(
    //   name: AppRoutes.addFriendScreen,
    //   page: () => const AddFriendScreen(),
    // ),
    // GetPage(
    //   name: AppRoutes.loginRoute,
    //   page: () => const LoginScreen(),
    //   bindings: [LoginBinding()],
    // ),
    // GetPage(
    //   name: AppRoutes.signupRoute,
    //   page: () => const SignUpScreen(),
    //   bindings: [SignupBinding()],
    // ),
    // GetPage(
    //   name: AppRoutes.forgetRoute,
    //   page: () => const ForgetScreen(),
    //   bindings: [ForgetBinding()],
    // ),
    // GetPage(
    //   name: AppRoutes.otpRoute,
    //   page: () => const OtpScreen(),
    //   bindings: [OtpBinding()],
    // ),
    // GetPage(
    //   name: AppRoutes.setPassRoute,
    //   page: () => const SetPassScreen(),
    //   bindings: [SetPassBinding()],
    // ),
    // GetPage(
    //   name: AppRoutes.successRoute,
    //   page: () => const SuccessScreen(),
    //   bindings: [SuccessBinding()],
    // ),
    //
    // // Home Screen Routes-------------------------------------------------------
    //

    // GetPage(
    //   name: AppRoutes.bottomRoute,
    //   page: () => const BottomBarScreen(),
    //   bindings: [BottomBinding()],
    // ),
    //
    // // Profile Screen Routes ---------------------------------------------------
    //
    // GetPage(
    //   name: AppRoutes.profileRoute,
    //   page: () => const ProfileScreen(),
    //   bindings: [ProfileBinding()],
    // ),
  ];
}
