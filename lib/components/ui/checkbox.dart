import 'package:flutter/material.dart';

class UiCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const UiCheckbox({Key? key, required this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) => Checkbox(value: value, onChanged: onChanged);
}

