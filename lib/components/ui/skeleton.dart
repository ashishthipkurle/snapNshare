import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double width;
  final double height;

  const Skeleton({Key? key, this.width = double.infinity, this.height = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        color: Colors.grey.shade300,
      );
}

