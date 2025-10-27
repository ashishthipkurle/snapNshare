import 'package:flutter/material.dart';

class UiDialog {
  static Future<T?> show<T>(BuildContext context, {required Widget child, bool barrierDismissible = true}) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(padding: const EdgeInsets.all(12), child: child),
      ),
    );
  }
}

