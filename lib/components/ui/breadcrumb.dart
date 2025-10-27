import 'package:flutter/material.dart';

class UiBreadcrumb extends StatelessWidget {
  final List<String> items;

  const UiBreadcrumb({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(children: items.map((s) => Padding(padding: const EdgeInsets.only(right: 8), child: Text(s))).toList());
  }
}

