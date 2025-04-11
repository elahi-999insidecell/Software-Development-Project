import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class Appicon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const Appicon({
    super.key,
    required this.icon,
    this.iconColor = const Color(0xFFfcf4e4),
    this.backgroundColor = const Color(0xFF756d54),
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
      ),
      child: Icon(icon, color: iconColor, size: Dimensions.icon16),
    );
  }
}
