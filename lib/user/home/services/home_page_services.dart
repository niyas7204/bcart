import 'dart:developer';

import 'package:amazone_clone/admin/core/constants/url.dart';
import 'package:amazone_clone/admin/features/products/models/products_model.dart';
import 'package:amazone_clone/core/errors/error_handling.dart';
import 'package:amazone_clone/core/helpers/response_handler.dart';
import 'package:dartz/dartz.dart';

class HomePageServices {
  static Future<Either<Failure, ProductsListModel>> getProduct(
      {required String accessToken}) async {
    try {
      return await handlerApiResponse<ProductsListModel>(
        call: Method.get,
        accessToken: accessToken,
        body: null,
        addHeader: null,
        url: AdminUrls.getProudct,
        successHandler: (p0) {
          return productsListModelFromJson(p0);
        },
      );
    } catch (e) {
      log("product get error $e");
      return left(Failure(errorMessage: "Failed to upload product"));
    }
  }
}
