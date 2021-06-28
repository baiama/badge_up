import 'dart:io';

import 'package:budge_up/components/alerts.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/utils/full_screen.dart';
import 'package:flutter/material.dart';

class ProfileImageContainer extends StatelessWidget {
  final File? image;
  final String avatar;
  final Function(File?) onImageSelected;
  final ImageProvider imageProvider;
  const ProfileImageContainer({
    Key? key,
    required this.image,
    required this.avatar,
    required this.onImageSelected,
    required this.imageProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (image == null && avatar.length == 0)
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ImageAlert(
                        onImageSelected: (image) {
                          onImageSelected(image);
                        },
                      );
                    });
              },
              child: Container(
                height: 120,
                width: 120,
                alignment: Alignment.center,
                child: CustomIcon(
                  customIcon: CustomIcons.addPhoto,
                ),
                decoration: BoxDecoration(
                  color: kColorF6F6F6,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: kColor26656565,
                      spreadRadius: 4,
                      blurRadius: 20,
                      offset: Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                ),
              ),
            ),
          ),
        if (image != null || avatar.length > 0)
          Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FullScreenImage(avatar, image)));
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: kColorF6F6F6,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: imageProvider,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: kColor26656565,
                          spreadRadius: 20,
                          blurRadius: 20,
                          offset: Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: CustomIcon(
                      color: kColor2980B9,
                      customIcon: CustomIcons.addPhoto,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ImageAlert(
                              onImageSelected: (image) {
                                onImageSelected(image);
                              },
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
