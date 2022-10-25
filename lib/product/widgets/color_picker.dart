import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:thrive_shop/color_schemes.g.dart';

class ColorPickerContainer extends StatelessWidget {
  const ColorPickerContainer(
      {super.key,
      required Color pickerColor,
      required ValueChanged<Color> onColorChanged,})
      : _pickerColor = pickerColor,
        _onColorChanged = onColorChanged;

  final Color _pickerColor;
  final ValueChanged<Color> _onColorChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: Text(
            'Pick the category color',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.lightColorScheme.onPrimaryContainer,
              fontSize: 16,
            ),
          ),
        ),
        InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: _pickerColor,
            ),
            height: 50,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(''),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: _pickerColor,
                      onColorChanged: _onColorChanged,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('SELECT'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
