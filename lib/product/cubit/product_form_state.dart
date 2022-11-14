part of 'product_form_cubit.dart';

class ProductFormState extends Equatable {
  const ProductFormState({
    this.product = const ProductInput.pure(),
    this.category = const CategoryModelInput.pure(),
    this.imageUrl = const ImageUrlInput.pure(),
    this.items = const <CategoryModel>[],
    this.status = FormzStatus.pure,
  });

  final ProductInput product;
  final CategoryModelInput category;
  final ImageUrlInput imageUrl;
  final FormzStatus status;
  final List<CategoryModel> items;

  ProductFormState copyWith({
    ProductInput? product,
    CategoryModelInput? category,
    ImageUrlInput? imageUrl,
    List<CategoryModel>? items,
    FormzStatus? status,
  }) {
    return ProductFormState(
      product: product ?? this.product,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [product, category, imageUrl, items, status];
}
