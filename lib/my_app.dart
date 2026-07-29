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
        initialRoute: AppPages.init,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

void keyBoardOff() {
  FocusScopeNode currentFocus = FocusScope.of(Get.context!);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

SizedBox gap({double? height, double? width}) {
  return SizedBox(height: height ?? 0, width: width ?? 0);
}
