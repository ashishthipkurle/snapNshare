import 'package:flutter/material.dart';

// Shim: forward the existing SnapVerse import/route to the new feed implementation.
// This keeps existing imports/routes that reference `lib/ui/screens/snapverse.dart`
// working while providing a scrollable feed with dummy data.
import 'pages/snapverse_feed.dart';

class SnapVersePage extends StatelessWidget {
  const SnapVersePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SnapVerseFeed();
  }
}
