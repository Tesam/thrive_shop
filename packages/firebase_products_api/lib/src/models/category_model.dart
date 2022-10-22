import 'package:json_annotation/json_annotation.dart';
import 'package:products_api/products_api.dart';

part 'category_model.g.dart';

/// {@template category model}
/// A model of the [Category] entity.
///
/// Contains a [categoryId], [category] and [color].
///
/// [CategoryModel] is serialized and deserialized using [toJson] and
/// [CategoryModel.fromJson] respectively.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class CategoryModel extends Category {
  /// {@macro CategoryModel}
  const CategoryModel({
    required super.category,
    required super.color,
    super.categoryId,
  });

  /// Deserializes the given [json] Map into a [CategoryModel].
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  /// Converts this [CategoryModel] into a [Map].
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
