import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:amazone_clone/admin/features/products/models/product_model.dart';
import 'package:amazone_clone/auth/services/auth_service.dart';
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

  static Future<void> uploadProduct({required ProductModel product}) async {
    try {
      log("======== $product");
      log("product json ${product.toJson()}");
      log("encode ${jsonEncode(product.toJson())}");
      // final body = jsonEncode({
      //   "product_name": "name",
      //   "description": "description",
      //   "price": 200,
      //   "quantity": 5,
      //   "images": ["images"],
      //   "seller_id": "1",
      // });
      // log("=== product $body");
      final String url = "$baseUrl/api/admin/addProduct";
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(product.toJson()), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearedToken',
      });
      log("====== statuscode ${response.statusCode} result ${response.body}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        log("------- success ${response.body}");
      }
    } catch (e) {
      log("------- error $e");
    }
  }
}
