import 'package:flutter/material.dart';
import 'package:thrive_shop/color_schemes.g.dart';

class CSMTextField extends StatelessWidget {
  const CSMTextField({
    super.key,
    required TextEditingController textEditingController,
    required String text,
    bool isSearchTextField = false,
  })  : _textEditingController = textEditingController,
        _text = text,
        _isSearchTextField = isSearchTextField;

  final TextEditingController _textEditingController;
  final String _text;
  final bool _isSearchTextField;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      style: TextStyle(
        color: AppColors.lightColorScheme.onPrimaryContainer,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        labelText: _text,
        hintText: _text,
        prefixIcon: _isSearchTextField ? const Icon(Icons.search) : null,
        labelStyle: TextStyle(
          color: AppColors.lightColorScheme.onPrimaryContainer,
          fontSize: 15,
        ),
        filled: true,
        fillColor: AppColors.lightColorScheme.primaryContainer,
        enabledBorder: borderStyle(),
        focusedBorder: borderStyle(),
        disabledBorder: borderStyle(),
        border: borderStyle(),
      ),
    );
  }

  OutlineInputBorder borderStyle() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      borderSide: BorderSide.none,
    );
  }
}
