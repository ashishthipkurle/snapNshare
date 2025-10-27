import 'package:flutter/material.dart';

class UiAlert extends StatelessWidget {
  final String text;
  final Color? color;

  const UiAlert({Key? key, required this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color ?? Colors.orange.withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
      child: Text(text),
    );
  }
}

