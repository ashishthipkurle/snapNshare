import 'package:flutter/material.dart';

class UiLabel extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const UiLabel(this.text, {Key? key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style ?? Theme.of(context).textTheme.bodySmall);
  }
}

