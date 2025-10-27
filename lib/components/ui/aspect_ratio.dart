import 'package:flutter/material.dart';

class UiAspectRatio extends StatelessWidget {
  final double ratio;
  final Widget child;

  const UiAspectRatio({Key? key, required this.ratio, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => AspectRatio(aspectRatio: ratio, child: child);
}

