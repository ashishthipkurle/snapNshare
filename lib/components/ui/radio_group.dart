import 'package:flutter/material.dart';

class RadioGroup<T> extends StatelessWidget {
  final T value;
  final ValueChanged<T?>? onChanged;
  final List<T> options;

  const RadioGroup({Key? key, required this.value, this.onChanged, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options
          .map((opt) => RadioListTile<T>(value: opt, groupValue: value, onChanged: onChanged))
          .toList(),
    );
  }
}

