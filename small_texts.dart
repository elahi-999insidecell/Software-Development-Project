import 'package:flutter/material.dart';

class SmallTexts extends StatelessWidget {
  final Color color;
  final String text;
  double size;
  double height;

  SmallTexts({
    super.key,
    this.color = const Color(0xFF808884),
    required this.text,
    this.size = 12.0,
    this.height = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, height: height),
    );
  }
}
