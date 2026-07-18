import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bhabhi_thulla/my_app.dart';

import 'constant/export_file.dart';

GetStorage localStorage = GetStorage();
Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}
