import 'package:flutter/material.dart';

class UiSelect<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  const UiSelect({Key? key, this.value, required this.items, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) => DropdownButton<T>(value: value, items: items, onChanged: onChanged);
}

