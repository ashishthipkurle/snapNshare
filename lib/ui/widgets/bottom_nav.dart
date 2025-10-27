import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  final items = [
  {'label': 'Home', 'route': '/home', 'icon': Icons.home},
  {'label': 'Explore', 'route': '/explore', 'icon': Icons.search},
  {'label': 'Create', 'route': '/create', 'icon': Icons.add_box},
  {'label': 'SnapVerse', 'route': '/snapverse', 'icon': Icons.video_collection},
  {'label': 'Profile', 'route': '/profile', 'icon': Icons.person},
  ];

  void _onTap(int idx) {
    final route = items[idx]['route'] as String;
    final current = ModalRoute.of(context)?.settings.name ?? '/home';
    setState(() => _currentIndex = idx);
    if (current != route) Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context)?.settings.name ?? '/home';
    final idx = items.indexWhere((e) => e['route'] == route);
    if (idx >= 0) setState(() => _currentIndex = idx);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kPrimary,
      unselectedItemColor: Colors.grey[500],
      items: items
          .map((e) => BottomNavigationBarItem(
              icon: Icon(e['icon'] as IconData), label: e['label'] as String))
          .toList(),
    );
  }
}
