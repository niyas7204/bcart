import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:amazone_clone/admin/core/constants/url.dart';
import 'package:amazone_clone/admin/features/products/models/products_model.dart';
import 'package:amazone_clone/core/errors/error_handling.dart';
import 'package:amazone_clone/core/helpers/response_handler.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';

class AddProductService {
  static Future<Either<Failure, List<File>>> getImage() async {
    try {
      List<File> images = [];

      final file = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: true);
      if (file != null && file.files.isNotEmpty) {
        for (var i = 0; i < file.files.length; i++) {
          images.add(File(file.files[i].path!));
        }
      }

      return right(images);
    } catch (e) {
      log("select image error $e");
      return left(Failure(errorMessage: "filed to pick image"));
    }
  }

  static Future<Either<Failure, List<String>>> uploadImage(
      {required List<File> images, required String productName}) async {
    try {
      final List<String> imageUrls = [];

      final cloudinary = CloudinaryPublic("dtrwjfu68", "bcart_upload_preset");
      for (var i = 0; i < images.length; i++) {
        final cloudRespone = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: productName));
        imageUrls.add(cloudRespone.secureUrl);
      }
      return right(imageUrls);
    } catch (e) {
      log("upload image error $e");
      return left(Failure(errorMessage: "Failed to upload image"));
    }
  }

  static Future<Either<Failure, ProductModel>> uploadProduct(
      {required ProductModel product, required String accessToken}) async {
    try {
      return handlerApiResponse<ProductModel>(
        accessToken: accessToken,
        body: jsonEncode(product.toJson()),
        addHeader: null,
        url: AdminUrls.addPrduct,
        successHandler: (p0) {
          return ProductModel.fromJson(p0["product"] as Map<String, dynamic>);
        },
      );
    } catch (e) {
      log("product upload error $e");
      return left(Failure(errorMessage: "Failed to upload product"));
    }
  }

  static Future<Either<Failure, ProductsListModel>> getProduct(
      {required String accessToken}) async {
    try {
      return handlerApiResponse<ProductsListModel>(
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

  static Future<Either<Failure, ProductModel>> deleteProduct(
      {required String accessToken, required String productId}) async {
    try {
      return handlerApiResponse<ProductModel>(
        accessToken: accessToken,
        body: jsonEncode({"id": productId}),
        addHeader: null,
        url: AdminUrls.deleteProudct,
        successHandler: (p0) {
          return ProductModel.fromJson(p0["product"]);
        },
      );
    } catch (e) {
      log("product delete error $e");
      return left(Failure(errorMessage: "Failed to upload product"));
    }
  }

  static Future<Either<Failure, String>> getCategories({
    required String accessToken,
  }) async {
    try {
      return handlerApiResponse<String>(
        accessToken: accessToken,
        body: null,
        addHeader: null,
        url: AdminUrls.getCategories,
        successHandler: (p0) {
          return "success";
        },
      );
    } catch (e) {
      log("product delete error $e");
      return left(Failure(errorMessage: "Failed to upload product"));
    }
  }

  static Future<Either<Failure, String>> createCategories(
      {required String accessToken, required String category}) async {
    try {
      return handlerApiResponse<String>(
        accessToken: accessToken,
        body: jsonEncode({"name": category}),
        addHeader: null,
        url: AdminUrls.createCategory,
        successHandler: (p0) {
          return "success";
        },
      );
    } catch (e) {
      log("product delete error $e");
      return left(Failure(errorMessage: "Failed to upload product"));
    }
  }
}
