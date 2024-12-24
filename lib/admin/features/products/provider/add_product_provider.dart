import 'dart:developer';
import 'dart:io';

import 'package:amazone_clone/admin/features/products/models/category_model.dart';
import 'package:amazone_clone/admin/features/products/models/products_model.dart';
import 'package:amazone_clone/core/widgets/show_alert.dart';
import 'package:amazone_clone/core/widgets/show_snackbar.dart';
import 'package:amazone_clone/admin/features/products/service/product_service.dart';
import 'package:amazone_clone/core/contants/key.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider extends ChangeNotifier {
  //intialize
  StateHandler<List<File>> _images = StateHandler.initial();
  StateHandler<ProductModel> _addProduct = StateHandler.initial();
  StateHandler<ProductsListModel> _getProduct = StateHandler.initial();
  StateHandler<CategoriesModel> _categories = StateHandler.initial();

  //getter for state
  StateHandler<ProductsListModel> get getproductState => _getProduct;
  StateHandler<List<File>> get imageState => _images;
  StateHandler<CategoriesModel> get catogerisState => _categories;
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
    if (products.status == StateStatuse.success) {
      log("======== ${products.data!.toString()}");
    }

    _getProduct = products;

    notifyListeners();
  }

  set setCategoris(StateHandler<CategoriesModel> newCategories) {
    _categories = newCategories;
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
      required String category,
      required double price,
      required double quantity,
      required BuildContext context}) async {
    if (category.isEmpty) {
      showAlertDiologe(
          context: context, tittle: "Missing", content: "Select Category");
    }
    {
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
                categoryName: category,
                accessToken: accestoken,
                product: ProductModel(
                    name: productName,
                    category: null,
                    description: "description",
                    price: price,
                    quantity: quantity,
                    images: r,
                    sellerId: null,
                    productId: null));
            product.fold((l) => setProduct = StateHandler.error(l.errorMessage),
                (r) async {
              showSnakbar(context, "product added successfully");
              await getProduct();
              setImage = StateHandler.initial();
              setProduct = StateHandler.success(r);
            });
          },
        );
      } else {
        setProduct = StateHandler.error("Failed to authenticate");
      }
    }
  }

  Future<void> getProduct() async {
    final String? accessToken = await getAccessToken();
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

  Future<void> deleteProduct(
      {required String productId, required BuildContext context}) async {
    final String? accessToken = await getAccessToken();
    if (accessToken != null) {
      final deleteProduct = await AddProductService.deleteProduct(
          accessToken: accessToken, productId: productId);
      deleteProduct.fold(
        (l) {
          showSnakbar(context, "Failed Delete Product");
        },
        (r) {
          final products = _getProduct.data!;
          for (var i = 0; i < products.products.length; i++) {
            if (products.products[i].productId == r.productId) {
              products.products.removeAt(i);
              setGetProduct = StateHandler.success(products);
            }
          }
          showSnakbar(context, "Product Deleted Successfuly");
        },
      );
    }
  }

  Future<void> getCategories() async {
    final String? accessToken = await getAccessToken();
    if (accessToken != null) {
      setGetProduct = StateHandler.loading();
      final product =
          await AddProductService.getCategories(accessToken: accessToken);

      product.fold((l) => setCategoris = StateHandler.error(l.errorMessage),
          (r) {
        setCategoris = StateHandler.success(r);
      });
    } else {
      setGetProduct = StateHandler.error("Failed to authenticate");
    }
  }

  Future<void> createCategories({required String category}) async {
    final String? accessToken = await getAccessToken();
    if (accessToken != null) {
      setGetProduct = StateHandler.loading();
      final product = await AddProductService.createCategories(
          category: category, accessToken: accessToken);
      product.fold(
        (l) {
          log("add category error ${l.errorMessage}");
        },
        (r) {
          CategoriesModel categoriesModel =
              _categories.status == StateStatuse.success
                  ? _categories.data!
                  : CategoriesModel(categories: []);
          categoriesModel.categories.add(r);
          setCategoris = StateHandler.success(categoriesModel);
        },
      );
    } else {
      setGetProduct = StateHandler.error("Failed to authenticate");
    }
  }
}

Future<String?> getAccessToken() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final accessToken = sharedPreferences.getString(ConstantKeys.accesToken);
  return accessToken;
}
