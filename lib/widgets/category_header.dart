import 'package:flutter/material.dart';
import 'package:thrive_shop/color_schemes.g.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({
    super.key,
    required int color,
    required String category,
  })  : _color = color,
        _category = category;

  final int _color;
  final String _category;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
