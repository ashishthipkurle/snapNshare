import 'package:flutter/widgets.dart';

class MenuBar extends StatelessWidget {
  final List<Widget> children;

  const MenuBar({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(children: children);
}

