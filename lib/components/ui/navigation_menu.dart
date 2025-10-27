import 'package:flutter/material.dart';

class UiNavigationMenu extends StatelessWidget {
  final List<Widget> items;

  const UiNavigationMenu({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(children: items);
}

