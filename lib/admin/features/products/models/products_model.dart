// To parse this JSON data, do
//
//     final ProductsListModel = ProductsListModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'products_model.g.dart';

ProductsListModel productsListModelFromJson(String str) =>
    ProductsListModel.fromJson(json.decode(str));

String productsListModelToJson(ProductsListModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProductsListModel {
  @JsonKey(name: "products")
  List<ProductModel> products;

  ProductsListModel({
    required this.products,
  });

  factory ProductsListModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsListModelToJson(this);
}

@JsonSerializable()
class ProductModel {
  @JsonKey(name: "product_name")
  String name;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "price")
  double price;
  @JsonKey(name: "quantity")
  double quantity;
  @JsonKey(name: "images")
  List<String> images;
  @JsonKey(name: "seller_id")
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
}
