import 'package:flutter/material.dart';

class UiSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;

  const UiSlider({Key? key, required this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) => Slider(value: value, onChanged: onChanged ?? (_) {});
}

