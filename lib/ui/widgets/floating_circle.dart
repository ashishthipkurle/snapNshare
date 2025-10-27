import 'package:flutter/material.dart';

class FloatingCircle extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  final double dx;
  final double dy;

  const FloatingCircle({Key? key, required this.size, required this.color, this.duration = const Duration(seconds: 3), this.dx = 0, this.dy = 0}) : super(key: key);

  @override
  State<FloatingCircle> createState() => _FloatingCircleState();
}

class _FloatingCircleState extends State<FloatingCircle> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(vsync: this, duration: widget.duration)..repeat(reverse: true);
  late final Animation<double> _anim = Tween(begin: 0.0, end: -10.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(widget.dx, _anim.value + widget.dy),
          child: child,
        );
      },
      child: Container(width: widget.size, height: widget.size, decoration: BoxDecoration(color: widget.color.withOpacity(0.2), shape: BoxShape.circle)),
    );
  }
}

