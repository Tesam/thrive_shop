import 'package:flutter/material.dart';
import 'package:thrive_shop/color_schemes.g.dart';

class CSMTextField extends StatelessWidget {
  const CSMTextField({
    super.key,
    TextEditingController? textEditingController,
    required String text,
    bool isSearchTextField = false,
    ValueSetter<String>? onChanged,
    FocusNode? focusNode,
    String? errorText,
  })  : _textEditingController = textEditingController,
        _text = text,
        _isSearchTextField = isSearchTextField,
        _onChanged = onChanged,
        _focusNode = focusNode,
        _errorText = errorText;

  final TextEditingController? _textEditingController;
  final String _text;
  final bool _isSearchTextField;
  final ValueSetter<String>? _onChanged;
  final FocusNode? _focusNode;
  final String? _errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      style: TextStyle(
        color: AppColors.lightColorScheme.onPrimaryContainer,
      ),
      focusNode: _focusNode,
      onChanged: _onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
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
        errorText: _errorText,
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
