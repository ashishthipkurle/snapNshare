import 'package:flutter/material.dart';

class UiDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  const UiDropdown({Key? key, this.value, required this.items, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      isExpanded: true,
      underline: SizedBox.shrink(),
    );
  }
}

