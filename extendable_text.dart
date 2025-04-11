import 'package:flutter/material.dart';
import 'package:food_delivery_app/app_color.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/small_texts.dart';

class ExtendableText extends StatefulWidget {
  final String text;
  const ExtendableText({super.key, required this.text});

  @override
  _ExtendableTextState createState() => _ExtendableTextState();
}

class _ExtendableTextState extends State<ExtendableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  final int textLimit = 150; // Fixed character limit for better readability

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textLimit) {
      firstHalf = widget.text.substring(0, textLimit);
      secondHalf = widget.text.substring(textLimit, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          secondHalf.isEmpty
              ? SmallTexts(
                size: Dimensions.icon16,
                height: 1.8,
                color: AppColors.textColor,
                text: firstHalf,
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallTexts(
                    size: Dimensions.icon16,
                    height: 1.8,
                    color: AppColors.textColor,
                    text:
                        hiddenText ? "$firstHalf..." : "$firstHalf$secondHalf",
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SmallTexts(
                          text: hiddenText ? "Show more" : "Show less",
                          color: AppColors.mainColor,
                        ),
                        Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.mainColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
