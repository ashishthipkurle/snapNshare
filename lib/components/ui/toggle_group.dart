import 'package:flutter/material.dart';

class UiToggleGroup extends StatelessWidget {
  final List<Widget> children;

  const UiToggleGroup({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(children: children);
}

