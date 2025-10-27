import 'package:flutter/widgets.dart';

bool isMobile(BuildContext context) {
  final w = MediaQuery.of(context).size.width;
  return w < 720;
}

