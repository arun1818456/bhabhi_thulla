import 'package:google_fonts/google_fonts.dart';

import '../constant/export_file.dart';

class MyText extends StatelessWidget {
  final String text;
  final Color color;
  final Color borderColor;
  final double fontSize;
  final double? borderWidth;
  final TextAlign textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;

  const MyText({
    super.key,
    required this.text,
    this.color = Colors.white,
    this.borderColor = Colors.black,
    this.fontSize = 18,
    this.borderWidth,
    this.textAlign = TextAlign.center,
    this.fontWeight,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          text,
          textAlign: textAlign,
          overflow: overflow,
          maxLines: maxLines,
          style: GoogleFonts.lilitaOne(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = borderWidth ?? 5
              ..color = borderColor,
          ),
        ),
        Text(
          text,
          textAlign: textAlign,
          overflow: overflow,
          maxLines: maxLines,
          style: GoogleFonts.lilitaOne(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          ),
        ),
      ],
    );
  }
}
