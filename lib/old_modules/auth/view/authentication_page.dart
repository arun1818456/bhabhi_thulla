// import 'package:bhabhi_thulla/modules/auth/controller/authentication_controller.dart';

import '../../../constant/export_file.dart';
import '../controller/authentication_controller.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({
    super.key,
  });
  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AuthenticationController(),
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: ElevatedButton(
                onPressed: () {
                  controller.onTapGoogleSignUp();
                },
                child: const Text("Google")),
          ),
        );
      },
    );
  }
}
