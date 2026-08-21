import '../../constant/export_file.dart';

class GameImageCard extends StatelessWidget {
  final String image;
  final GestureTapCallback onTap;

  const GameImageCard({
    super.key,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -5.0, end: 5.0),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: child,
        );
      },
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          image,
          height: Get.height / 2,
        ),
      ),
    );
  }
}