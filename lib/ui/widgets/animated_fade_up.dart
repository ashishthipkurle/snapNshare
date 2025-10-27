import 'package:flutter/material.dart';

class AnimatedFadeUp extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  const AnimatedFadeUp({Key? key, required this.child, this.duration = const Duration(milliseconds: 600), this.delay = Duration.zero}) : super(key: key);

  @override
  State<AnimatedFadeUp> createState() => _AnimatedFadeUpState();
}

class _AnimatedFadeUpState extends State<AnimatedFadeUp> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(vsync: this, duration: widget.duration);
  late final Animation<Offset> _offset = Tween(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  late final Animation<double> _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);

  @override
  void initState() {
    super.initState();
    if (widget.delay == Duration.zero) {
      _ctrl.forward();
    } else {
      Future.delayed(widget.delay, () => mounted ? _ctrl.forward() : null);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}

