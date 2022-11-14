import 'package:flutter/material.dart';
import 'package:thrive_shop/color_schemes.g.dart';

class FavoriteSwipeBackground extends StatelessWidget {
  const FavoriteSwipeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.lightColorScheme.secondary,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: const [
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            Text(
              ' Favorite',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
