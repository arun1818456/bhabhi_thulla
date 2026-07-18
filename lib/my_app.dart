import 'constant/export_file.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          keyBoardOff();
        },
        child: GetMaterialApp(
          // theme: ThemeData(
          //   scaffoldBackgroundColor:
          //   AppColors.whiteColor,
          // ),
          initialRoute: AppPages.init,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
        ));
  }
}

keyBoardOff() {
  FocusScopeNode currentFocus = FocusScope.of(Get.context!);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

gap({double? height, double? width}) {
  return SizedBox(
    height: height ?? 0,
    width: width ?? 0,
  );
}
