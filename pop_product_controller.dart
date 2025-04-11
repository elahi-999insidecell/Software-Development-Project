import 'package:flutter/material.dart';
import 'package:food_delivery_app/app_color.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/data/repository/popular_product_repo.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:get/get.dart';

class PopProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopProductController({required this.popularProductRepo});
  List<dynamic> _popProductList = [];
  List<dynamic> get popProductList => _popProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _count = 0;
  int get count => _count;
  int _cartItems = 0;
  int get cartItems => _cartItems + _count;

  Future<void> getPopProductList() async {
    Response response = await popularProductRepo.getPopularProList();

    if (response.statusCode == 200) {
      print("got products");
      _popProductList = [];
      _popProductList.addAll(Product.fromJson(response.body).products);
      // print(popProductList);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncreament) {
    if (isIncreament) {
      _count = checkQuantity(_count + 1);
    } else {
      _count = checkQuantity(_count - 1);
    }
    update();
  }

  int checkQuantity(int count) {
    if (_cartItems + count < 0) {
      Get.snackbar(
        "Items",
        "Low level exceeded!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );

      if (cartItems > 0) {
        _count = -_cartItems;
        return _count;
      }

      return 0;
    } else if (_cartItems + count > 20) {
      Get.snackbar(
        "Items",
        "High level exceeded!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return count;
    } //ekahne ja send kortesi tai paitesi
    // but add items e jeye prev quantity er sathe add hoye ultimately real add i pai
  }

  void initProduct(ProductModel product, CartController cart) {
    _count = 0;
    _cartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);

    if (exist) {
      _cartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _count);

    _count = 0; // naile cart e ager ta soho add hoy same product er
    _cartItems = _cart.getQuantity(product);
    //komaile full 0 na hoye ekta ekta kore kombe.otherwise cart e 0 hoye jay

    update(); // ui te dekhanor jonno update method
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
