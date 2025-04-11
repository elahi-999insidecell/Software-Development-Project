import 'package:food_delivery_app/data/repository/recom_product_repo.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:get/get.dart';

class RecomProductController extends GetxController {
  final RecomProductRepo recomProductRepo;
  RecomProductController({required this.recomProductRepo});
  List<dynamic> _recomProductList = [];
  List<dynamic> get recomProductList => _recomProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response = await recomProductRepo.getRecommendedProductList();

    if (response.statusCode == 200) {
      //print("got products");
      _recomProductList = [];
      _recomProductList.addAll(Product.fromJson(response.body).products);
      // print(popProductList);
      _isLoaded = true;
      update();
    } else {}
  }
}
