import 'package:flutter/material.dart';
import 'package:food_delivery_app/HomePage/mainFoodPage.dart';
import 'package:food_delivery_app/Pages/cart/cart_page.dart';
import 'package:food_delivery_app/app_color.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/pop_product_controller.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/AppIcon.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/big_texts.dart';
import 'package:food_delivery_app/widgets/extendable_text.dart';
import 'package:get/get.dart';

class PopFood extends StatelessWidget {
  int pageId;
  PopFood({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var produ = Get.find<PopProductController>().popProductList[pageId];
    Get.find<PopProductController>().initProduct(
      produ,
      Get.find<CartController>(),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: Dimensions.popFoodImgSize,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          produ.img!,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => MainFoodPage());
                    },
                    child: Appicon(icon: Icons.arrow_back_ios),
                  ),

                  GetBuilder<PopProductController>(
                    builder: (controller) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => CartPage());
                            },
                            child: Appicon(icon: Icons.shopping_cart_outlined),
                          ),
                          Get.find<PopProductController>().totalItems >= 1
                              ? Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => CartPage());
                                  },
                                  child: Appicon(
                                    icon: Icons.circle,
                                    iconColor: Colors.transparent,
                                    size: 20,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                ),
                              )
                              : Container(),

                          Get.find<PopProductController>().totalItems >= 1
                              ? Positioned(
                                top: 1,
                                right: 4,
                                bottom: 3,
                                child: BigTexts(
                                  text:
                                      Get.find<PopProductController>()
                                          .totalItems
                                          .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                              : Container(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: Dimensions.popFoodImgSize - 20,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: produ.name!),
                    SizedBox(height: Dimensions.height20),
                    BigTexts(text: 'Introduce'),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [ExtendableText(text: produ.description!)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopProductController>(
          builder: (popularProduct) {
            return Container(
              height: Dimensions.bottomHeiBar,
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height30,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                color: AppColors.bottomBarColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(Icons.remove, color: AppColors.signColor),
                        ),
                        SizedBox(width: Dimensions.width10),
                        BigTexts(text: popularProduct.cartItems.toString()),
                        SizedBox(width: Dimensions.width10),
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(Icons.add, color: AppColors.signColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        popularProduct.addItem(produ);
                      },
                      child: BigTexts(
                        text: '${produ.price!} taka | Add to Cart',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
