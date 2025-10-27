import 'package:flutter/material.dart';

class UiTextarea extends StatelessWidget {
  final TextEditingController? controller;

  const UiTextarea({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) => TextField(controller: controller, maxLines: 6);
}

