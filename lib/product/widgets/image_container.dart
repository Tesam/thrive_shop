import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/product/cubit/product_form_cubit.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, required String imageUrl})
      : _imageUrl = imageUrl;

  final String _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.lightColorScheme.primaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: (_imageUrl.isNotEmpty)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      _imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://i.imgur.com/sUFH1Aq.png',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final imagePicker = ImagePicker();
              XFile? image;

              await Permission.photos.request();

              final permissionStatus = await Permission.photos.status;

              if (permissionStatus.isGranted) {
                image = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                );

                if (image != null) {
                  final file = File(image.path);
                  await context
                      .read<ProductFormCubit>()
                      .onImageUrlChanged(file);
                }
              }
            },
            child: Text(
              (_imageUrl.isNotEmpty)
                  ? 'Change Image'
                  : 'Upload Image',
              style: TextStyle(
                color: AppColors.lightColorScheme.onPrimary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
