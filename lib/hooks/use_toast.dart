import 'package:flutter/widgets.dart';
import '../ui/widgets/toaster.dart';

void showToast(BuildContext context, String message) =>
    Toaster.show(context, message);
