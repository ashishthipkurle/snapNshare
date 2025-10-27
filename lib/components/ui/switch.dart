import 'package:flutter/material.dart';

class UiSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const UiSwitch({Key? key, required this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) => Switch(value: value, onChanged: onChanged ?? (_) {});
}

