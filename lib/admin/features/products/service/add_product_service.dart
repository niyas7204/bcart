import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:amazone_clone/admin/features/products/models/products_model.dart';
import 'package:amazone_clone/auth/services/auth_service.dart';
import 'package:amazone_clone/core/contants/token.dart';
import 'package:amazone_clone/core/errors/error_handling.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
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
      final String url = "$baseUrl/api/admin/addProduct";
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(product.toJson()), headers: {
        'Access-Token': accessToken,
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearedToken',
      });
      log("====== statuscode ${response.statusCode} result ${response.body}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final result = jsonDecode(response.body);

        final product =
            ProductModel.fromJson(result["product"] as Map<String, dynamic>);
        return right(product);
      } else {
        log("add product failure ${response.body}");
        final result = jsonDecode(response.body);
        log("===== ${result["error"]}");
        return left(Failure(errorMessage: result["error"]));
      }
    } catch (e) {
      log("product upload error $e");
      return left(Failure(errorMessage: "Failed to upload product"));
    }
  }

  static Future<Either<Failure, ProductsListModel>> getProduct(
      {required String accessToken}) async {
    try {
      final String url = "$baseUrl/api/admin/getProduct";
      final response = await http.get(Uri.parse(url), headers: {
        'Access-Token': accessToken,
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearedToken',
      });
      log("====== statuscode ${response.statusCode} result ${response.body}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final result = jsonDecode(response.body);

        final product = productsListModelFromJson(response.body);
        return right(product);
      } else {
<<<<<<< HEAD
        log("get product failure ${response.body}");
=======
        log("add product failure ${response.body}");
>>>>>>> origin/main
        final result = jsonDecode(response.body);
        log("===== ${result["error"]}");
        return left(Failure(errorMessage: result["error"]));
      }
    } catch (e) {
      log("product get error $e");
      return left(Failure(errorMessage: "Failed to upload product"));
    }
  }
<<<<<<< HEAD

  static Future<Either<Failure, ProductModel>> deleteProduct(
      {required String accessToken, required String productId}) async {
    try {
      final String url = "$baseUrl/api/admin/deleteProduct";
      final response = await http
          .post(Uri.parse(url), body: jsonEncode({"id": productId}), headers: {
        'Access-Token': accessToken,
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearedToken',
      });
      log("====== statuscode ${response.statusCode} result ${response.body}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final result = jsonDecode(response.body);

        final product = ProductModel.fromJson(result["product"]);

        return right(product);
      } else {
        log("delete product failure ${response.body}");
        final result = jsonDecode(response.body);
        log("===== ${result["error"]}");
        return left(Failure(errorMessage: result["error"]));
      }
    } catch (e) {
      log("product delete error $e");
      return left(Failure(errorMessage: "Failed to upload product"));
    }
  }
=======
>>>>>>> origin/main
}
