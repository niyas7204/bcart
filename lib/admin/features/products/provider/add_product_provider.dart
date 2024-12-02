import 'dart:developer';
import 'dart:io';

import 'package:amazone_clone/admin/features/products/models/products_model.dart';
import 'package:amazone_clone/admin/features/products/presentation/pages/product_list.dart';
import 'package:amazone_clone/admin/features/products/presentation/widgets/show_snackbar.dart';
import 'package:amazone_clone/admin/features/products/service/add_product_service.dart';
import 'package:amazone_clone/core/contants/key.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider extends ChangeNotifier {
  //intialize
  StateHandler<List<File>> _images = StateHandler.initial();
  StateHandler<ProductModel> _addProduct = StateHandler.initial();
  StateHandler<ProductsListModel> _getProduct = StateHandler.initial();
  //getter for state
  StateHandler<ProductsListModel> get getproductState => _getProduct;
  StateHandler<List<File>> get imageState => _images;
  StateHandler<ProductModel> get addproductState => _addProduct;

  //setter for states
  set setImage(StateHandler<List<File>> imageFiles) {
    _images = imageFiles;
    notifyListeners();
  }

  set setProduct(StateHandler<ProductModel> newProduct) {
    _addProduct = newProduct;
    notifyListeners();
  }

  set setGetProduct(StateHandler<ProductsListModel> products) {
    _getProduct = products;
    notifyListeners();
  }

//event to select image from device
  void selectImages() async {
    setImage = StateHandler.loading();

    final result = await AddProductService.getImage();
    result.fold(
      (l) => setImage = StateHandler.error(l.errorMessage),
      (r) => setImage = StateHandler.success(r),
    );
  }

//event upload product
  Future<void> uploadProduct(
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
      setProduct = StateHandler.loading();
      //upload image on cloud
      final result = await AddProductService.uploadImage(
          productName: productName, images: images);

      result.fold(
        (l) {
          showSnakbar(context, "failed to upload image");
          setProduct = StateHandler.error("Failed upload image");
        },
        (r) async {
          //upload product
          final product = await AddProductService.uploadProduct(
              accessToken: accestoken,
              product: ProductModel(
                  name: productName,
                  description: "description",
                  price: price,
                  quantity: quantity,
                  images: r,
                  sellerId: null,
                  productId: null));
          product.fold((l) => setProduct = StateHandler.error(l.errorMessage),
              (r) {
            showSnakbar(context, "product added successfully");
            setProduct = StateHandler.success(r);
          });
        },
      );
    } else {
      setImage = StateHandler.error("Failed to authenticate");
    }
  }

  Future<void> getProduct() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString(ConstantKeys.accesToken);
    if (accessToken != null) {
      setGetProduct = StateHandler.loading();
      final product =
          await AddProductService.getProduct(accessToken: accessToken);
      product.fold(
        (l) => setGetProduct = StateHandler.error(l.errorMessage),
        (r) => setGetProduct = StateHandler.success(r),
      );
    } else {
      setGetProduct = StateHandler.error("Failed to authenticate");
    }
  }
}
