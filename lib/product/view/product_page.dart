import 'package:flutter/material.dart';
import 'package:thrive_shop/product/view/category_form.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: CategoryForm(),
          ),
        ],
      ),
    );
  }
}
