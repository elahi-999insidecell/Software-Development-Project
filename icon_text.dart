import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/small_texts.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color icon_color;
  const IconText({
    super.key,

    required this.icon_color,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: icon_color, size: Dimensions.icon24),
        SizedBox(width: 5),
        SmallTexts(text: text),
      ],
    );
  }
}
