import 'package:flutter/material.dart';

class UiDrawer extends StatelessWidget {
  final Widget child;

  const UiDrawer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: child);
  }
}

