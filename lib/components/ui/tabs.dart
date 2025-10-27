import 'package:flutter/material.dart';

class UiTabs extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> views;

  const UiTabs({Key? key, required this.tabs, required this.views}) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(length: tabs.length, child: Column(children: [TabBar(tabs: tabs), Expanded(child: TabBarView(children: views))]));
}

