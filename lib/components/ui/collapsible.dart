import 'package:flutter/material.dart';

class UiCollapsible extends StatelessWidget {
  final String title;
  final Widget child;

  const UiCollapsible({Key? key, required this.title, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => ExpansionTile(title: Text(title), children: [child]);
}

