import 'package:flutter/material.dart';

class UiCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const UiCard({Key? key, required this.child, this.padding = const EdgeInsets.all(12)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: Offset(0, 6))],
      ),
      child: child,
    );
  }
}

