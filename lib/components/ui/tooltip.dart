import 'package:flutter/material.dart';

class UiTooltip extends StatelessWidget {
  final String message;
  final Widget child;

  const UiTooltip({Key? key, required this.message, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => Tooltip(message: message, child: child);
}

