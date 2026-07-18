import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final Color color;
  final Color borderColor;
  final double fontSize;
  final TextAlign textAlign;
  final FontWeight? fontWeight;

  const MyText({
    super.key,
    required this.text,
    this.color = Colors.white,
    this.borderColor = Colors.black,
    this.fontSize = 18,
    this.textAlign = TextAlign.center,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          text,
          textAlign: textAlign,
          style: GoogleFonts.lilitaOne(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..color = borderColor,
          ),
        ),
        Text(
          text,
          textAlign: textAlign,
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