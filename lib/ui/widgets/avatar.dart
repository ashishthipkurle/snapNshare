import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String? imagePath;
  final String? initials;

  const Avatar({Key? key, this.size = 40, this.imagePath, this.initials}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePath != null && imagePath!.isNotEmpty) {
      return CircleAvatar(radius: size / 2, backgroundImage: AssetImage(imagePath!));
    }

    return CircleAvatar(radius: size / 2, backgroundColor: Colors.grey[300], child: Text(initials ?? '?'));
  }
}

