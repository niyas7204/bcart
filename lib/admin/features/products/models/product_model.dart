// To parse this JSON data, do
//
//     final chatMessageModel = chatMessageModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'product_model.g.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

@JsonSerializable()
class ProductModel {
  @JsonKey(name: "product_name")
  String name;
  @JsonKey(name: "description")
  String description;
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
