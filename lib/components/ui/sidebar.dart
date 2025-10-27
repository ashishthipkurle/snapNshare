import 'package:flutter/material.dart';

class UiSidebar extends StatelessWidget {
  final Widget child;

  const UiSidebar({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(width: 250, child: child);
}

