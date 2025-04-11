import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/repository/cart_repo.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/app_color.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  final Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;
  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;

    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;

        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          time: DateTime.now().toString(),
          quantity: value.quantity! + quantity,
          isExist: true,
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }

      // ete minus kore je 0 value hbe oigula product list e add korbenahh
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
          product.id!,
          () => CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            time: DateTime.now().toString(),
            quantity: quantity,
            isExist: true,
          ),
        );
      } else {
        Get.snackbar(
          "Items",
          "Add an item",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  } // this method for finding onno id er quantity amount and adding or biyog kora

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }
}
