import 'package:flutter/material.dart';

class UiToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const UiToggle({Key? key, required this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) => Switch(value: value, onChanged: onChanged ?? (_) {});
}

