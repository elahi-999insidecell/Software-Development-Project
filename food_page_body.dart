import 'package:flutter/material.dart';
import 'package:food_delivery_app/app_color.dart';
import 'package:food_delivery_app/controllers/pop_product_controller.dart';
import 'package:food_delivery_app/controllers/recom_product_controller.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_texts.dart';
import 'package:food_delivery_app/widgets/icon_text.dart';
import 'package:food_delivery_app/widgets/small_texts.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currpagevalue = 0.0;
  double scaleFactor = 0.8;
  final double _hei = Dimensions.PageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currpagevalue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose(); // less memory lagbe
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GetBuilder<PopProductController>(
            builder: (popProducts) {
              return popProducts.isLoaded
                  ? SizedBox(
                    // slider section
                    height: 320,

                    child: PageView.builder(
                      controller: pageController,
                      itemCount: popProducts.popProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(
                          position,
                          popProducts.popProductList[position],
                        );
                      },
                    ),
                  )
                  : CircularProgressIndicator(color: AppColors.mainColor);
            },
          ),

          GetBuilder<PopProductController>(
            builder: (popProducts) {
              return DotsIndicator(
                dotsCount:
                    popProducts.popProductList.isEmpty
                        ? 1
                        : popProducts.popProductList.length,
                position: currpagevalue,
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeColor: AppColors.mainColor,
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              );
            },
          ),

          //Pop Text
          SizedBox(height: Dimensions.height30),
          Container(
            margin: EdgeInsets.only(left: Dimensions.width30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigTexts(text: 'Recomended'),
                SizedBox(width: Dimensions.width10),
                Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: BigTexts(text: '.', color: AppColors.smalltextColor),
                ),
                SizedBox(width: Dimensions.width10),
                Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: SmallTexts(text: 'Food Pairing'),
                ),
              ],
            ),
          ),

          // showing the list of restaurants
          GetBuilder<RecomProductController>(
            builder: (recomProduct) {
              return recomProduct.isLoaded
                  ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recomProduct.recomProductList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getRecommendedFood(index));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height10,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: Dimensions.listviewimgSize,
                                width: Dimensions.listviewimgSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.width30,
                                  ),

                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "${AppConstants.BASE_URL}/uploads/" +
                                          recomProduct
                                              .recomProductList[index]
                                              .img!,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: Dimensions.listviewTextSize,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                        Dimensions.radius20,
                                      ),
                                      topLeft: Radius.circular(
                                        Dimensions.radius20,
                                      ),
                                      bottomLeft: Radius.circular(
                                        Dimensions.radius20,
                                      ),
                                      bottomRight: Radius.circular(
                                        Dimensions.radius20,
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigTexts(
                                          text:
                                              recomProduct
                                                  .recomProductList[index]
                                                  .name!,
                                        ),
                                        SizedBox(height: Dimensions.height10),
                                        SmallTexts(
                                          text:
                                              'Delicious food all over Bangladesh',
                                        ),
                                        SizedBox(height: Dimensions.height10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                  : CircularProgressIndicator(color: AppColors.mainColor);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPageItem(int index, ProductModel popProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == currpagevalue.floor()) {
      var currscale =
          1 - (currpagevalue - index) * (1 - scaleFactor); //always getting 1
      var currTrans = _hei * (1 - currscale) / 2; // getting 0 for curr page
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currpagevalue.floor() + 1) {
      var currscale =
          scaleFactor +
          (currpagevalue - index + 1) * (1 - scaleFactor); //always getting 0.8
      var currTrans =
          _hei * (1 - currscale) / 2; //getting 22 for next, so niche nambe
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currpagevalue.floor() - 1) {
      var currscale =
          1 - (currpagevalue - index) * (1 - scaleFactor); // getting 0.8
      var currTrans =
          _hei * (1 - currscale) / 2; //getting 22 for next, so niche nambe
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currscale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(1, _hei * (1 - scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.PageViewContainer,

              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "${AppConstants.BASE_URL}/uploads/${popProduct.img!}",
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.PageViewTextContainer,

              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30,
              ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    offset: Offset(0, 5),
                    blurRadius: 5,
                  ),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigTexts(text: popProduct.name!),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Wrap(
                          children: [
                            ...List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                color: AppColors.mainColor,
                                size: 15,
                              ),
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
