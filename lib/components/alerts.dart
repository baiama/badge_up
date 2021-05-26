import 'dart:io';

import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:budge_up/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageAlert extends StatelessWidget {
  final Function(File?) onImageSelected;

  ImageAlert({required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(Strings.cancel)),
      ],
      content: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: TextButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                File? image = await Utils.getImage(ImageSource.gallery);
                onImageSelected(image);
              },
              label: Text(
                Strings.gallery,
                style: kInterReg14,
              ),
              icon: Icon(Icons.image_outlined),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: TextButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                File? image = await Utils.getImage(ImageSource.camera);
                onImageSelected(image);
              },
              label: Text(
                Strings.camera,
                style: kInterReg14,
              ),
              icon: Icon(Icons.camera_alt_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
