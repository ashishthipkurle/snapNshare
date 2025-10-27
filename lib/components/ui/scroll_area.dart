import 'package:flutter/material.dart';

class UiScrollArea extends StatelessWidget {
  final Widget child;

  const UiScrollArea({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(child: child);
}

