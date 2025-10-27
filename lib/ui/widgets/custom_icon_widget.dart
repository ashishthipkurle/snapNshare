import 'package:flutter/material.dart';

class CustomIconWidget extends StatelessWidget {
  final String iconName;
  final Color? color;
  final double? size;

  const CustomIconWidget(
      {super.key, required this.iconName, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    // Map a few known names to Material icons for the shim
    final map = {
      'close': Icons.close,
      'search': Icons.search,
      'photo_library': Icons.photo_library,
      'camera_alt': Icons.camera_alt,
      'gif': Icons.gif,
      'add': Icons.add,
      'flip_camera_ios': Icons.flip_camera_android,
      'flash_on': Icons.flash_on,
      'flash_off': Icons.flash_off,
      'camera_alt_outlined': Icons.camera_alt_outlined,
    };

    final icon = map[iconName] ?? Icons.help_outline;

    return Icon(icon, color: color, size: size);
  }
}

