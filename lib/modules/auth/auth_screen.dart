import 'package:bhabhi_thulla/modules/auth/auth_controller.dart';
import '../../constant/export_file.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AuthController(),
      builder: (controller) {
        return BackgroundWidget(
          padding: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final h = constraints.maxHeight;
              final w = constraints.maxWidth;

              return Stack(
                children: [
                  // Logo / Title Section
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatorWidget(
                          effect: AnimationEffect.scale,
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.elasticOut,
                          child: const MyText(
                            text: "BHABHI THULLA",
                            fontSize: 48,
                            color: Colors.white,
                            borderColor: Colors.black,
                            borderWidth: 8,
                          ),
                        ),
                        SizedBox(height: h * 0.05),

                        // Wooden Container for Buttons
                        Container(
                          width: w * 0.4,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xffa16b47),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color(0xff7a4d2e), width: 6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildAuthButton(
                                text: "GOOGLE",
                                icon: Icons.g_mobiledata,
                                color: Colors.white,
                                textColor: Colors.black87,
                                onTap: () => debugPrint("Google Login"),
                              ),
                              const SizedBox(height: 15),
                              _buildAuthButton(
                                text: "APPLE",
                                icon: Icons.apple,
                                color: Colors.black,
                                textColor: Colors.white,
                                onTap: () => debugPrint("Apple Login"),
                              ),
                              const SizedBox(height: 15),
                              _buildAuthButton(
                                text: "GUEST LOGIN",
                                icon: Icons.person_outline,
                                color: Colors.orange,
                                textColor: Colors.white,
                                onTap: () => controller.getGuestDeviceInfo(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildAuthButton({
    required String text,
    required IconData icon,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 28),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
