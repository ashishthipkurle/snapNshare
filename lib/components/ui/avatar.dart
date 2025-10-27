import 'package:flutter/material.dart';

class UiAvatar extends StatelessWidget {
  final double size;
  final String? imagePath;

  const UiAvatar({Key? key, this.size = 40, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: size / 2, backgroundImage: imagePath != null ? AssetImage(imagePath!) : null);
  }
}

