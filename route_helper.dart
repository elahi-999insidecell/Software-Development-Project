import 'package:food_delivery_app/HomePage/mainFoodPage.dart';
import 'package:food_delivery_app/Pages/food_details/pop_food.dart';
import 'package:food_delivery_app/Pages/food_details/recommended_food.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static String getInitial() => initial;

  static const String popularFood = '/popular-food';
  static String getPopularFood(int pageId) => "$popularFood?pageId= $pageId";

  static const String recommendedFood = '/recommended-food';
  static String getRecommendedFood(int pageId) =>
      "$recommendedFood?pageId=$pageId";

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = int.parse(Get.parameters['pageId']!);
        return PopFood(pageId: pageId);
      },

      transition: Transition.fadeIn,
    ),

    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = int.parse(Get.parameters['pageId']!);
        return RecommendedFood(pageId: pageId);
      },
      transition: Transition.fadeIn,
    ),
  ];
}
