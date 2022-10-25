import 'package:flutter/material.dart';
import 'package:thrive_shop/color_schemes.g.dart';

class CSMButton extends StatelessWidget {
  const CSMButton({
    super.key,
    required VoidCallback onPressed,
    required String title,
  })  : _onPressed = onPressed,
        _title = title;

  final VoidCallback _onPressed;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _onPressed,
        child: Text(
          _title,
          style: TextStyle(
            color: AppColors.lightColorScheme.onPrimary,),
        ),
      ),
    );
  }
}
