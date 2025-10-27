import 'package:flutter/material.dart';

class UiAccordion extends StatelessWidget {
  final String title;
  final Widget child;

  const UiAccordion({Key? key, required this.title, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(title: Text(title), children: [child]);
  }
}

