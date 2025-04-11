import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_texts.dart';
import 'package:food_delivery_app/widgets/small_texts.dart';
import 'package:food_delivery_app/widgets/icon_text.dart';
import 'package:food_delivery_app/app_color.dart';
import 'package:flutter/material.dart';

class AppColumn extends StatelessWidget {
  const AppColumn({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigTexts(text: text, size: Dimensions.font26),
        SizedBox(height: 10),
        Row(
          children: [
            Wrap(
              children: [
                ...List.generate(
                  5,
                  (index) =>
                      Icon(Icons.star, color: AppColors.mainColor, size: 15),
                ),
                SizedBox(width: 10),
                SmallTexts(text: '4.5'),
                SizedBox(width: 10),
                SmallTexts(text: '84'),
                SizedBox(width: 3),
                SmallTexts(text: 'Comments'),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconText(
              icon_color: AppColors.iconColor1,
              icon: Icons.circle_sharp,
              text: 'Normal',
            ),

            IconText(
              icon_color: AppColors.mainColor,
              icon: Icons.location_on,
              text: '2.3 km',
            ),

            IconText(
              icon_color: AppColors.iconColor2,
              icon: Icons.access_time_rounded,
              text: '30 minutes',
            ),
          ],
        ),
      ],
    );
  }
}
