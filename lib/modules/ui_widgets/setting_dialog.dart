import '../../constant/export_file.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: Get.width / 2,
        height: Get.height - 50,
        decoration: BoxDecoration(
          color: const Color(0xff1650BF),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _header(context),

            // Body
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(15),
                children: [
                  SettingRow(
                    icon: Icons.workspace_premium,
                    title: "Credits",
                    buttonText: "View",
                  ),

                  SizedBox(height: 18),

                  SettingRow(
                    icon: Icons.school,
                    title: "Tutorial",
                    buttonText: "Play",
                  ),

                  SizedBox(height: 18),

                  SettingRow(
                    icon: Icons.privacy_tip,
                    title: "Privacy Policy",
                    buttonText: "Read",
                  ),

                  SizedBox(height: 18),

                  SettingRow(
                    icon: Icons.description,
                    title: "Terms",
                    buttonText: "Read",
                  ),

                  SizedBox(height: 18),

                  SettingRow(
                    icon: Icons.delete,
                    title: "Delete Account",
                    buttonText: "Delete",
                  ),

                  SizedBox(height: 30),
                ],
              ),
            ),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Color(0xff2E8CFF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Stack(
        children: [
          const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.settings, size: 30, color: Colors.white),

                SizedBox(width: 12),

                Text(
                  "SETTINGS",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            right: 15,
            top: 15,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xff2E8CFF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GameButton(text: "Support", onTap: () {}),
          ),

          SizedBox(width: 30),

          Expanded(
            child: GameButton(text: "Logout", onTap: () {}),
          ),
        ],
      ),
    );
  }
}

class SettingRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String buttonText;
  final VoidCallback? onPressed;

  const SettingRow({
    super.key,
    required this.icon,
    required this.title,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        SizedBox(
          width: 100,
          child: GameButton(text: buttonText, onTap: onPressed ?? () {}),
        ),
      ],
    );
  }
}

class GameButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const GameButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color = const Color(0xff39C7FF),
  });

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => pressed = true),
      onTapUp: (_) {
        setState(() => pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => pressed = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 80),
        scale: pressed ? .96 : 1,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [widget.color.withValues(alpha: .95), const Color(0xff208BFF)],
            ),
            border: Border.all(color: Colors.white.withValues(alpha: .25), width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 5,
                right: 5,
                top: 5,
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .18),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Center(
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
