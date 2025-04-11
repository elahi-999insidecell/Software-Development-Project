import 'package:flutter/material.dart';

class BigTexts extends StatelessWidget {
  final Color color;
  final String text;
  double size;
  TextOverflow overflow;
  BigTexts({
    super.key,
    this.color = const Color(0xFF191c1c),
    required this.text,
    this.size = 20.0, // Default value for size
    this.overflow = TextOverflow.ellipsis, // Default value for overflow
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: size,
      ),
    );
  }
}
