import 'dart:developer';

import 'package:amazone_clone/core/helpers/access_token.dart';
import 'package:amazone_clone/user/features/products/services/user_product_service.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  Future<void> addToCart(
      {required String producId, required int itemCount}) async {
    try {
      final String? accessToken = await getAccessToken();
      if (accessToken != null) {
        final product = await UserProductService.addToCart(
            productId: producId,
            itemCount: itemCount,
            accessToken: accessToken);
        Future<String?> getAccessToken() async {
          // Implement your logic to get the access token here
          return "your_access_token";
        }
      }
    } catch (e) {
      log("=error $e");
    }
  }
}
