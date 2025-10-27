import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double height;
  final double radius;

  const GradientButton(
      {Key? key,
      this.onPressed,
      required this.child,
      this.height = 52,
      this.radius = 999})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: kGradientPrimary,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: kShadowGlow,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DefaultTextStyle(
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
              child: child),
        ),
      ),
    );
  }
}
