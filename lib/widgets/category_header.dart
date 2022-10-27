import 'package:flutter/material.dart';
import 'package:products_api/products_api.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({
    super.key,
    required Category category,
  })  : _category = category;

  final Category _category;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(_category.color),
            borderRadius: BorderRadius.circular(8),
          ),
          width: 20,
          height: 30,
          margin: const EdgeInsets.only(
            right: 10,
          ),
        ),
        Expanded(
          child: Text(
            _category.category,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
