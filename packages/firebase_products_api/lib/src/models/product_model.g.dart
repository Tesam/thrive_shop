// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      product: json['product'] as String,
      category:
          CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      imageUrl: json['image_url'] as String,
      isFavorite: json['is_favorite'] as bool? ?? false,
      favoriteDate: json['favorite_date'] as String? ?? '',
      productId: json['product_id'] as String? ?? '',
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product': instance.product,
      'image_url': instance.imageUrl,
      'is_favorite': instance.isFavorite,
      'favorite_date': instance.favoriteDate,
      'category': instance.category.toJson(),
    };
