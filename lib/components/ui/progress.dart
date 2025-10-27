import 'package:flutter/material.dart';

class UiProgress extends StatelessWidget {
  final double value;

  const UiProgress({Key? key, this.value = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) => LinearProgressIndicator(value: value);
}

