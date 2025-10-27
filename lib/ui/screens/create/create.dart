import 'package:flutter/material.dart';
import '../../widgets/bottom_nav.dart';
import 'media_selection_screen.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MediaSelectionScreen(),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
