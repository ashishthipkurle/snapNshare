import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String? semanticLabel;

  const CustomImageWidget(
      {super.key,
      required this.imageUrl,
      this.width,
      this.height,
      this.fit,
      this.semanticLabel});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) return const SizedBox.shrink();
    return Image.network(imageUrl,
        width: width, height: height, fit: fit ?? BoxFit.cover);
  }
}

