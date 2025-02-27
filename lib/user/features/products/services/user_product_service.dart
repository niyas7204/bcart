import 'dart:convert';
import 'dart:developer';

import 'package:amazone_clone/core/errors/error_handling.dart';
import 'package:amazone_clone/core/helpers/response_handler.dart';
import 'package:amazone_clone/user/core/user_urls.dart';
import 'package:amazone_clone/user/features/products/models/user_products_model.dart';
import 'package:dartz/dartz.dart';

class UserProductService {
  static Future<Either<Failure, UserProductsListModel>> getProducts(
      {required String? query,
      required String? category,
      required String accessToken}) async {
    try {
      return await handlerApiResponse(
        accessToken: accessToken,
        url:
            "${UserUrls.getProudct}?${query != null ? 'name=$query&' : ''}${category != null ? 'category=$category' : ''}",
        body: null,
        method: Method.get,
        addHeader: null,
        successHandler: (p0) {
          return userProductsListModelFromJson(p0);
        },
      );
    } catch (e) {
      log("error===========$e");
      throw Exception();
    }
  }

  static Future<Either<Failure, void>> addToCart(
      {required String productId,
      required int itemCount,
      required String accessToken}) async {
    try {
      log("======= addd id $productId");
      return await handlerApiResponse(
        accessToken: accessToken,
        url: UserUrls.addToCart,
        body: jsonEncode({"productId": productId, "quantity": itemCount}),
        method: Method.post,
        addHeader: null,
        successHandler: (p0) {},
      );
    } catch (e) {
      log("error===========$e");
      throw Exception();
    }
  }
}
