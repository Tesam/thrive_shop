import 'package:equatable/equatable.dart';

/// {@template category}
/// A single category item.
///
/// Contains a [categoryId], [category] and [color].
///
/// [Category] objects are immutable.
/// {@endtemplate}
class Category extends Equatable {
  /// {@macro category}
  const Category({
    required this.categoryId,
    required this.category,
    required this.color,
  });

  /// The unique identifier of the category.
  ///
  /// Cannot be empty.
  final String categoryId;

  /// The name of the category.
  ///
  /// Cannot be empty.
  final String category;

  /// The color assigned to the category.
  ///
  /// Cannot be empty.
  final int color;

  @override
  List<Object?> get props => [categoryId, category, color];
}
