import '../../constant/export_file.dart';

class CommonDialogs with BaseClass {
  static void common2ButtonsPopUp(
      BuildContext context, {
        VoidCallback? onClose,
        bool showSecondButton = true,
        required VoidCallback onButtonTap,
        required VoidCallback onButton2Tap,
        required String button1Image,
        required String button2Image,
      }) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black12,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder:
          (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) {
        return SlideTransition(
          position: Tween(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ).animate(animation),
          child: child,
        );
      },
      pageBuilder:
          (
          BuildContext buildContext,
          Animation animation,
          Animation secondaryAnimation,
          ) {
        return StatefulBuilder(
          builder: (context, StateSetter setStateDialog) {
            return Container(
              alignment: Alignment.bottomCenter,
              child: Wrap(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      padding: EdgeInsets.fromLTRB(
                        20,
                        0,
                        20,
                        MediaQuery.of(context).padding.bottom,
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Upload",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                        onButtonTap();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Image.asset(
                                          button1Image,
                                          height: 30,
                                          width: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 14),
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                        onButton2Tap();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Image.asset(
                                          button2Image,
                                          height: 30,
                                          width: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 8,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.cancel_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      if (onClose != null) {
        onClose();
      }
    });
  }

  void showLogOutDialog(BuildContext context, token) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.blackColor.withValues(alpha: 0.9),
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder:
          (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) {
        return SlideTransition(
          position: Tween(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ).animate(animation),
          child: child,
        );
      },
      pageBuilder:
          (
          BuildContext buildContext,
          Animation animation,
          Animation secondaryAnimation,
          ) {
        return StatefulBuilder(
          builder: (context, StateSetter setStateDialog) {
            return Padding(
              padding: EdgeInsets.zero,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: true,
                body: Container(
                  alignment: Alignment.bottomCenter,
                  child: Wrap(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                            10,
                            0,
                            10,
                            10 + MediaQuery.of(context).padding.bottom,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.blackColor),
                          ),
                          // child: LogoutDialog(
                          //   headerImage: AppImages.logoutPopUp,
                          //   headerImageHeight: 100,
                          //   headerImageWidth: 100,
                          //   title: "Are You Sure You Want to Logout?",
                          //   description:
                          //   "You can log back in to your account to Add You Daily Expenses, are you sure you want to logout?",
                          //   button1Text: "Cancel",
                          //   button2Text: "Logout",
                          //   onButton1Tap: () {
                          //     Get.back();
                          //   },
                          //   onButton2Tap: () async {
                          //     // showCircularLoader();
                          //     // ExpenseController expenseController =
                          //     // Get.find<ExpenseController>();
                          //     // List<Map<String, dynamic>>
                          //     // expenseList = expenseController.expenses
                          //     //     .map(
                          //     //       (expense) => {
                          //     //     "id": expense.id,
                          //     //     "title": expense.title,
                          //     //     "amount": expense.amount,
                          //     //     "category": expense.category.name,
                          //     //     "paymentType": expense.paymentType,
                          //     //     "date": expense.date
                          //     //         .toUtc()
                          //     //         .toIso8601String(),
                          //     //     "groupId":expense.groupId,
                          //     //     "groupName":expense.groupName,
                          //     //     "description": expense.description,
                          //     //   },
                          //     // )
                          //     //     .toList();
                          //     // try {
                          //     //   var response = await httpRequest(
                          //     //     REQUEST.post,
                          //     //     logoutApiEndPoint,
                          //     //     {"expenses": expenseList},
                          //     //     token: token,
                          //     //   );
                          //     //   if (response["success"] == true) {
                          //     //     // Clear SQL Database
                          //     //     await expenseController.clearAllExpenses();
                          //     //
                          //     //     // Clear All Local Storage (GetStorage)
                          //     //     await GetStorage().erase();
                          //     //
                          //     //     // Sign out from Google
                          //     //     await GoogleSignIn().signOut();
                          //     //     try {
                          //     //       await GoogleSignIn().disconnect();
                          //     //     } catch (e) {
                          //     //       debugPrint("Google disconnect error: $e");
                          //     //     }
                          //     //
                          //     //     Get.back();
                          //     //     Get.back();
                          //     //     Get.back();
                          //     //     Get.toNamed(AppRoutes.authScreen);
                          //     //     showMySnackBar("Logged out successfully", success: true);
                          //     //   } else {
                          //     //     showMySnackBar(
                          //     //       response["message"],
                          //     //       error: true,
                          //     //     );
                          //     //   }
                          //     // } catch (e) {
                          //     //   showMySnackBar(e.toString(), error: true);
                          //     // }
                          //   },
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // static void showLoginRequiredDialog(BuildContext context) {
  //   showGeneralDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
  //     barrierColor: AppColors.blackColor.withValues(alpha: 0.9),
  //     transitionDuration: const Duration(milliseconds: 150),
  //     transitionBuilder:
  //         (
  //         BuildContext context,
  //         Animation<double> animation,
  //         Animation<double> secondaryAnimation,
  //         Widget child,
  //         ) {
  //       return SlideTransition(
  //         position: Tween(
  //           begin: Offset(0, 1),
  //           end: Offset(0, 0),
  //         ).animate(animation),
  //         child: child,
  //       );
  //     },
  //     pageBuilder:
  //         (
  //         BuildContext buildContext,
  //         Animation animation,
  //         Animation secondaryAnimation,
  //         ) {
  //       return StatefulBuilder(
  //         builder: (context, StateSetter setStateDialog) {
  //           return Padding(
  //             padding: EdgeInsets.zero,
  //             child: Scaffold(
  //               backgroundColor: Colors.transparent,
  //               resizeToAvoidBottomInset: true,
  //               body: Container(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Wrap(
  //                   children: [
  //                     Material(
  //                       color: Colors.transparent,
  //                       child: Container(
  //                         margin: EdgeInsets.fromLTRB(
  //                           10,
  //                           0,
  //                           10,
  //                           10 + MediaQuery.of(context).padding.bottom,
  //                         ),
  //                         decoration: BoxDecoration(
  //                           color: AppColors.whiteColor,
  //                           borderRadius: BorderRadius.circular(14),
  //                           border: Border.all(color: AppColors.blackColor),
  //                         ),
  //                         child: LogoutDialog(
  //                           headerImage: AppImages.loadingGif,
  //                           headerImageHeight: 100,
  //                           headerImageWidth: 100,
  //                           title: "Login Required",
  //                           description:
  //                           "To use this feature please login or signup",
  //                           button1Text: "Cancel",
  //                           button2Text: "Login",
  //                           onButton1Tap: () {
  //                             Get.back();
  //                           },
  //                           onButton2Tap: () {
  //                             Get.back();
  //                             Get.toNamed(AppRoutes.authScreen);
  //                           },
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  Future<void> showUpdateDialog(BuildContext context) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Update",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.system_update,
                      size: 50,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Update Available",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "A new version is now available.\n"
                          "Update now to enjoy the latest features, performance improvements, and bug fixes.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            // isBorderEnable: true,
                            // borderColor: AppColors.appColor,
                            color: Colors.white,
                            // textColor: AppColors.appColor,
                            text: "Later",
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            text: "Update Now",
                            onPressed: () async {
                              // const url =
                              //     "https://play.google.com/store/apps/details?id=com.aruninnovation.studio.daily_expense_tracker";
                              //
                              // await launchUrl(
                              //   Uri.parse(url),
                              //   mode: LaunchMode.externalApplication,
                              // );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showCustomDialog(
      BuildContext context, {
        required String title,
        required String description,
        required String yesButtonText,
        required String noButtonText,
        required VoidCallback onTapYes,
      }) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: title,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                // margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        if(noButtonText.isNotEmpty)
                          Expanded(
                            child: CustomButton(
                              // isBorderEnable: true,
                              // borderColor: AppColors.appColor,
                              // color: Colors.white,
                              // textColor: AppColors.appColor,
                              text: noButtonText,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            text: yesButtonText,
                            onPressed: () {
                              Navigator.of(context).pop();
                              onTapYes();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
