import 'package:flutter/material.dart';

class UiBadge extends StatelessWidget {
  final String text;

  const UiBadge(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)), child: Text(text, style: TextStyle(fontSize: 12)));
}

