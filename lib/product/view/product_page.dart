import 'package:flutter/material.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/product/view/category_form.dart';
import 'package:thrive_shop/product/view/product_form.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _isProduct = true;
  String _title = 'Product';

  void changeMode({required bool value}) {
    if (value) {
      setState(() {
        _isProduct = true;
        _title = 'Create Product';
      });
    } else {
      setState(() {
        _isProduct = false;
        _title = 'Create Category';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              Switch(
                value: _isProduct,
                onChanged: (value) => changeMode(value:value),
                activeColor: AppColors.lightColorScheme.primary,
              )
            ],
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: _isProduct ? const ProductForm() : const CategoryForm(),
          ),
        ],
      ),
    );
  }
}
