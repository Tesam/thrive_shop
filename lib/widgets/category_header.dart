import 'package:flutter/material.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/shopping_list/widgets/delete_swipe_background.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({
    super.key,
    required int color,
    required String category,
    required VoidCallback onDelete,
  })  : _color = color,
        _category = category,
        _onDelete = onDelete;

  final int _color;
  final String _category;
  final VoidCallback _onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<String>(_category),
      background: const DeleteSwipeBackground(),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete $_category'),
              content: Text('Are you sure you want to delete $_category?'),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(
                    'DELETE',
                    style: TextStyle(color: AppColors.lightColorScheme.error),
                  ),
                  onPressed: () {
                    _onDelete();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(_color),
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
              _category,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.expand_more,
              color: AppColors.lightColorScheme.onBackground,
            ),
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          )
        ],
      ),
    );
  }
}
