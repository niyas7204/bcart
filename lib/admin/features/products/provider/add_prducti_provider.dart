import 'dart:io';

import 'package:amazone_clone/admin/features/products/models/product_model.dart';
import 'package:amazone_clone/admin/features/products/presentation/widgets/show_snackbar.dart';
import 'package:amazone_clone/admin/features/products/service/add_product_service.dart';
import 'package:amazone_clone/core/contants/key.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPrductiProvider extends ChangeNotifier {
  StateHandler<List<File>> images = StateHandler.initial();
  StateHandler<List<File>> get imageState => images;
  set setImage(StateHandler<List<File>> imageFiles) {
    images = imageFiles;
    notifyListeners();
  }

  StateHandler<ProductModel> product = StateHandler.initial();
  StateHandler<List<File?>> get productState => images;
  set setProduct(StateHandler<ProductModel> newProduct) {
    product = newProduct;
    notifyListeners();
  }

  void selectImages() async {
    setImage = StateHandler.loading();

    final result = await AddProductService.getImage();
    result.fold(
      (l) => setImage = StateHandler.error(l.errorMessage),
      (r) => setImage = StateHandler.success(r),
    );
  }

  void uploadProduct(
      {required List<File> images,
      required String productName,
      required String description,
      required double price,
      required double quantity,
      required BuildContext context}) async {
    setImage = StateHandler.loading();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final accestoken = sharedPreferences.getString(ConstantKeys.accesToken);
    if (accestoken != null) {
      // final result = await AddProductService.uploadImage(
      //     productName: productName, images: images);

      // result.fold(
      //   (l) {
      //     showSnakbar(context, "failed to upload image");
      //     setProduct = StateHandler.error("Failed upload image");
      //   },
      //   (r) async {
      final product = await AddProductService.uploadProduct(
          accessToken: accestoken,
          product: ProductModel(
              name: productName,
              description: "description",
              price: price,
              quantity: quantity,
              images: ["========"],
              sellerId: null,
              productId: null));
      product.fold((l) => setProduct = StateHandler.error(l.errorMessage), (r) {
        showSnakbar(context, "product added successfully");
        setProduct = StateHandler.success(r);
      });
      // },)
    } else {
      setImage = StateHandler.error("Failed to authenticate");
    }
  }
}
