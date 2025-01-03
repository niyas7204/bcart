// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsListModel _$ProductsListModelFromJson(Map<String, dynamic> json) =>
    ProductsListModel(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductsListModelToJson(ProductsListModel instance) =>
    <String, dynamic>{
      'products': instance.products,
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      name: json['productName'] as String?,
      description: json['description'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      sellerId: json['sellerId'] as String?,
      productId: json['_id'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productName': instance.name,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'quantity': instance.quantity,
      'images': instance.images,
      'sellerId': instance.sellerId,
      '_id': instance.productId,
    };
