import 'package:flutter/material.dart';
import '../theme/color.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final bool isSubtitle;
  final int maxLines;
  final TextOverflow overflow;

  const TitleText({
    Key? key,
    required this.text,
    this.fontSize = 18,
    this.color = LightColor.titleTextColor,
    this.fontWeight = FontWeight.w800,
    this.isSubtitle = false,
    this.maxLines = 2,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isSubtitle ? 15 : fontSize,
        fontFamily: 'Roboto',
        fontWeight: fontWeight,
        color: isSubtitle ? LightColor.orange : color,
      ),
      textAlign: TextAlign.center,
      maxLines: maxLines, // Handle number of lines
      overflow: overflow, // Handle overflow
    );
  }
}
