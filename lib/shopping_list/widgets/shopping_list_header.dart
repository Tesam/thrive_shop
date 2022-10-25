import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/shopping_list/cubit/shopping_list_cubit.dart';
import 'package:thrive_shop/widgets/category_header.dart';
import 'package:thrive_shop/widgets/delete_swipe_background.dart';

class ShoppingListHeader extends StatelessWidget {
  const ShoppingListHeader({super.key, required String categoryId,
  required String category, required int color,})
      : _categoryId = categoryId, _category = category, _color = color;
  final String _categoryId;
  final String _category;
  final int _color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      child: Dismissible(
        key: ValueKey<String>(_categoryId,),
        background: const DeleteSwipeBackground(),
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Delete '
                      '$_category',
                ),
                content: Text('Are you sure you want to '
                    'delete '
                    '$_category'
                    '?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () =>
                        Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: Text(
                      'DELETE',
                      style: TextStyle(
                        color:
                        AppColors.lightColorScheme.error,
                      ),
                    ),
                    onPressed: () {
                      context
                          .read<ShoppingListCubit>()
                          .deleteCategory(
                        categoryId:
                        _categoryId,
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: CategoryHeader(
          color: _color,
          category: _category,
        ),
      ),
    );
  }
}
