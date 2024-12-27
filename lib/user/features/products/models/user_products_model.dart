// To parse this JSON data, do
//
//     final UserProductsListModel = UserProductsListModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_products_model.g.dart';

UserProductsListModel userProductsListModelFromJson(String str) =>
    UserProductsListModel.fromJson(json.decode(str));

String userProductsListModelToJson(UserProductsListModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class UserProductsListModel {
  @JsonKey(name: "products")
  List<ProductModel> products;

  UserProductsListModel({
    required this.products,
  });

  factory UserProductsListModel.fromJson(Map<String, dynamic> json) =>
      _$UserProductsListModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProductsListModelToJson(this);

  @override
  String toString() {
    return 'ProductModel$products';
  }
}

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

@JsonSerializable()
class ProductModel {
  @JsonKey(name: "productName")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "category")
  Category? category;
  @JsonKey(name: "price")
  double? price;
  @JsonKey(name: "quantity")
  double? quantity;
  @JsonKey(name: "images")
  List<String>? images;
  @JsonKey(name: "sellerId")
  String? sellerId;
  @JsonKey(name: "_id")
  String? productId;

  ProductModel({
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.quantity,
    required this.images,
    required this.sellerId,
    required this.productId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  String toString() {
    return ' {"name": "$name", "description": "$description", category:"$category", "price": "$price", "quantity": "$quantity", "images": "$images", "sellerId": "$sellerId", "productId": "$productId"}';
  }
}

CategoriesModel categoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class CategoriesModel {
  @JsonKey(name: "categories")
  List<Category> categories;

  CategoriesModel({
    required this.categories,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "image")
  String? image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
