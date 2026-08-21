import '../../constant/export_file.dart';

class ChipWithText extends StatelessWidget {
  final String iconImage;
  final String text;
  final GestureTapCallback onTap;
  final double? size;

  const ChipWithText({
    super.key,
    required this.iconImage,
    required this.text,
    required this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(iconImage, width: size ?? 45, height: size ?? 45),
            MyText(text: text, fontSize: 15),
          ],
        ),
      ),
    );
  }
}
