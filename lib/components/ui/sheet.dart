import 'package:flutter/material.dart';

class UiSheet extends StatelessWidget {
  final Widget child;
  final double? height;

  const UiSheet({Key? key, required this.child, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: child,
    );
  }
}

