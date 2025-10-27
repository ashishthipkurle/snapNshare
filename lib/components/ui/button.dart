import 'package:flutter/material.dart';

import '../../theme.dart';

class UiButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool primary;
  final EdgeInsetsGeometry padding;

  const UiButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.primary = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ButtonStyle(
      padding: MaterialStateProperty.all(padding),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (!primary) return Colors.transparent;
        return null; // gradient handled below
      }),
    );

    if (primary) {
      return DecoratedBox(
        decoration: BoxDecoration(
          gradient: kGradientPrimary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: kShadowMedium,
        ),
        child: ElevatedButton(
          style: style.copyWith(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: onPressed,
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            child: child,
          ),
        ),
      );
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: style.merge(ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(color: kPrimary.withOpacity(0.12))),
      )),
      child: child,
    );
  }
}

