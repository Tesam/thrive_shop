import 'package:flutter/material.dart';
import 'package:thrive_shop/color_schemes.g.dart';

class CSMDropdown<T> extends StatelessWidget {
  const CSMDropdown(
      {super.key,
      required T element,
      required ValueChanged<T?>? onChanged,
      required List<T> items,})
      : _element = element,
        _onChanged = onChanged, _items = items;

  final T _element;
  final ValueChanged<T?>? _onChanged;
  final List<T> _items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.lightColorScheme.primaryContainer,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: _element,
          icon: const Icon(Icons.expand_more),
          elevation: 16,
          isExpanded: true,
          menuMaxHeight: 300,
          style: TextStyle(
            color: AppColors.lightColorScheme.onPrimaryContainer,
          ),
          onChanged: _onChanged,
          items: _items
              .map<DropdownMenuItem<T>>((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }
}
