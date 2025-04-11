import 'package:flutter/material.dart';
import 'package:food_delivery_app/app_color.dart';
import 'package:food_delivery_app/controllers/pop_product_controller.dart';
import 'package:food_delivery_app/controllers/recom_product_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/AppIcon.dart';
import 'package:food_delivery_app/widgets/big_texts.dart';
import 'package:food_delivery_app/widgets/extendable_text.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/Pages/cart/cart_page.dart';

class RecommendedFood extends StatelessWidget {
  int pageId;
  RecommendedFood({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecomProductController>(
      builder: (controller) {
        if (!controller.isLoaded || controller.recomProductList.isEmpty) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.mainColor),
            ),
          );
        }

        var produ = controller.recomProductList[pageId];
        Get.find<PopProductController>().initProduct(
          produ,
          Get.find<CartController>(),
        );
        //print("Description: ${produ.description}");
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 70,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getInitial());
                        },
                        child: Appicon(
                          icon: Icons.clear,
                          iconColor: Colors.white,
                        ),
                      ),

                      //shopping cart outlined er jaygay get builder
                      GetBuilder<PopProductController>(
                        builder: (controller) {
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => CartPage());
                                },
                                child: Appicon(
                                  icon: Icons.shopping_cart_outlined,
                                ),
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
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(20),
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20),
                        ),
                      ),
                      child: Center(
                        child: BigTexts(
                          text: produ.name,
                          size: Dimensions.font26,
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  pinned: true,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          produ.img,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        child: ExtendableText(text: produ.description),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            bottomNavigationBar: GetBuilder<PopProductController>(
              builder: (controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: Dimensions.width20 * 2.5,
                        right: Dimensions.width20 * 2.5,
                        top: Dimensions.height10,
                        bottom: Dimensions.height10,
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.setQuantity(false);
                            },
                            child: Appicon(
                              icon: Icons.remove,
                              iconColor: Colors.white,
                              backgroundColor: AppColors.mainColor,
                              size: Dimensions.icon24 * 1.7,
                            ),
                          ),

                          BigTexts(
                            text:
                                "${produ.price ?? 0} Taka x ${controller.cartItems}",

                            color: AppColors.textColor,
                            size: Dimensions.font26,
                          ),

                          GestureDetector(
                            onTap: () {
                              controller.setQuantity(true);
                            },
                            child: Appicon(
                              icon: Icons.add,
                              iconColor: Colors.white,
                              backgroundColor: AppColors.mainColor,
                              size: Dimensions.icon24 * 1.7,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
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
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius20,
                              ),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.favorite,
                              color: AppColors.mainColor,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              controller.addItem(produ);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: Dimensions.height20,
                                bottom: Dimensions.height20,
                                left: Dimensions.width20,
                                right: Dimensions.width20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius20,
                                ),
                                color: AppColors.mainColor,
                              ),
                              child: BigTexts(
                                text: '${produ.price!} taka | Add to Cart',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
