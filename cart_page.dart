import 'package:flutter/material.dart';

import 'package:food_delivery_app/HomePage/mainFoodPage.dart';
import 'package:food_delivery_app/app_color.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/AppIcon.dart';
import 'package:food_delivery_app/widgets/big_texts.dart';
import 'package:food_delivery_app/widgets/small_texts.dart';

import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: Dimensions.height20,
              right: Dimensions.width20,
              left: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Appicon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    size: Dimensions.icon24 * 1.7,
                  ),
                  SizedBox(width: Dimensions.width20 * 5),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => MainFoodPage());
                    },
                    child: Appicon(
                      icon: Icons.home_sharp,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      size: Dimensions.icon24 * 1.7,
                    ),
                  ),

                  Appicon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    size: Dimensions.icon24 * 1.7,
                  ),
                ],
              ),
            ),
            Positioned(
              top: Dimensions.height20 * 5,
              bottom: 0,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(
                    builder: (cartcontroller) {
                      return ListView.builder(
                        itemCount: cartcontroller.getItems.length,
                        itemBuilder: (_, index) {
                          return SizedBox(
                            height: Dimensions.height20 * 5,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Container(
                                  height: Dimensions.height20 * 5,
                                  width: Dimensions.width20 * 5,
                                  margin: EdgeInsets.only(
                                    bottom: Dimensions.height10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.radius20,
                                    ),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        AppConstants.BASE_URL +
                                            AppConstants.UPLOAD_URL +
                                            cartcontroller.getItems[index].img!,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10),
                                Expanded(
                                  child: SizedBox(
                                    height: Dimensions.height20 * 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigTexts(
                                          text:
                                              cartcontroller
                                                  .getItems[index]
                                                  .name!,
                                          color: Colors.black54,
                                        ),
                                        SmallTexts(text: "Yummy"),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigTexts(
                                                text:
                                                    cartcontroller
                                                        .getItems[index]
                                                        .price
                                                        .toString(),
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: Dimensions.height10,
                                                  bottom: Dimensions.height10,
                                                  left: Dimensions.width10,
                                                  right: Dimensions.width10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        Dimensions.radius20,
                                                      ),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        //popularProduct.setQuantity(false);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color:
                                                            AppColors.signColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Dimensions.width10,
                                                    ),
                                                    BigTexts(text: "0"),
                                                    SizedBox(
                                                      width: Dimensions.width10,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        //popularProduct.setQuantity(true);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color:
                                                            AppColors.signColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
