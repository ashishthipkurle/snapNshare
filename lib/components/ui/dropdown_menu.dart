import 'package:flutter/material.dart';

class UiDropdownMenu extends StatelessWidget {
  final List<PopupMenuEntry> items;

  const UiDropdownMenu({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) => PopupMenuButton(itemBuilder: (_) => items);
}

