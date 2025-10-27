import 'package:flutter/material.dart';
import '../ui/screens/create/media_selection_screen.dart';

class AppRoutes {
  // Start the app at the welcome screen by default
  static const String initial = '/welcome';
  static const String mediaSelection = '/media-selection-screen';

  static Map<String, WidgetBuilder> routes = {
    mediaSelection: (context) => const MediaSelectionScreen(),
    // Additional shared routes can be added here later.
  };
}
