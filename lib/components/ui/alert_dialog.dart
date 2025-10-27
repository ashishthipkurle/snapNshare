import 'package:flutter/material.dart';

class UiAlertDialog {
  static Future<T?> show<T>(BuildContext context, {required String title, required String content}) {
    return showDialog<T>(
      context: context,
      builder: (_) => AlertDialog(title: Text(title), content: Text(content), actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))]),
    );
  }
}

