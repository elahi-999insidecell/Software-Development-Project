import 'package:flutter/material.dart';
import 'package:food_delivery_app/app_color.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_texts.dart';
import 'package:food_delivery_app/widgets/small_texts.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(top: 25, bottom: Dimensions.height15),
                padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigTexts(
                          text: 'Bangladesh',
                          color: AppColors.mainColor,
                        ),
                        Row(
                          children: [
                            SmallTexts(text: 'Rajshahi', color: Colors.black54),
                            Icon(Icons.arrow_drop_down_rounded),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius15,
                          ),
                          color: AppColors.mainColor,
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimensions.icon24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: SingleChildScrollView(child: FoodPageBody())),
          ],
        ),
      ),
    );
  }
}
