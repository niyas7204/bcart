import 'dart:developer';

import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/helpers/access_token.dart';
import 'package:amazone_clone/user/features/products/models/user_products_model.dart';
import 'package:amazone_clone/user/features/products/services/user_product_service.dart';
import 'package:flutter/cupertino.dart';

class UserProductsProvider extends ChangeNotifier {
  StateHandler<UserProductsListModel> _products = StateHandler.initial();
  StateHandler<UserProductsListModel> _productsbyCategory =
      StateHandler.initial();
  StateHandler<UserProductsListModel> get allprodctsState => _products;
  StateHandler<UserProductsListModel> get productByCategoryState =>
      _productsbyCategory;

  set setProduct(StateHandler<UserProductsListModel> newProducts) {
    _products = newProducts;
    notifyListeners();
  }

  set setProductbyCategory(StateHandler<UserProductsListModel> newProducts) {
    _productsbyCategory = newProducts;
    notifyListeners();
  }

  Future<void> getProducts(
      {required String? query, required String? category}) async {
    final String? accessToken = await getAccessToken();
    if (accessToken != null) {
      log("===========1 $category ");
      category != null
          ? setProductbyCategory = StateHandler.loading()
          : setProduct = StateHandler.loading();
      final product = await UserProductService.getProducts(
          query: query, category: category, accessToken: accessToken);

      product.fold((l) {
        if (category != null) {
          setProductbyCategory = StateHandler.error(l.errorMessage);
        } else {
          setProduct = StateHandler.error(l.errorMessage);
        }
      }, (r) {
        if (category != null) {
          setProductbyCategory = StateHandler.success(r);
        } else {
          setProduct = StateHandler.success(r);
        }
      });
    } else {
      log("===========Failed to authenticate");
      setProduct = StateHandler.error("Failed to authenticate");
    }
  }
}
