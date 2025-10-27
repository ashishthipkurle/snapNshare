import 'package:flutter/material.dart';

class UiContextMenu extends StatelessWidget {
  final List<PopupMenuEntry> items;

  const UiContextMenu({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (_) => items);
  }
}

