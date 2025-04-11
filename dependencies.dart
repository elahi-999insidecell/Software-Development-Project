import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/recom_product_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/repository/cart_repo.dart';
import 'package:food_delivery_app/data/repository/recom_product_repo.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/data/repository/popular_product_repo.dart';
import 'package:food_delivery_app/controllers/pop_product_controller.dart';

Future<void> init() async {
  //api client
  Get.lazyPut(() => ApiClient(apiBaseUrl: AppConstants.BASE_URL));

  //repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find<ApiClient>()));
  Get.lazyPut(() => RecomProductRepo(apiClient: Get.find<ApiClient>()));
  Get.lazyPut(() => CartRepo());
  //controllers
  Get.lazyPut(
    () => PopProductController(
      popularProductRepo: Get.find<PopularProductRepo>(),
    ),
  );

  Get.lazyPut(
    () =>
        RecomProductController(recomProductRepo: Get.find<RecomProductRepo>()),
  );

  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
