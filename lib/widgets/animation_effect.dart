import 'package:flutter/material.dart';

enum AnimationEffect {
  fade,
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
  scale,
  rotation,
}

class AnimatorWidget extends StatefulWidget {
  final Widget child;
  final AnimationEffect effect;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  const AnimatorWidget({
    super.key,
    required this.child,
    this.effect = AnimationEffect.fade,
    this.duration = const Duration(milliseconds: 250),
    this.delay = const Duration(microseconds: 100),
    this.curve = Curves.easeOut,
  });

  @override
  State<AnimatorWidget> createState() => _AnimatorWidgetState();
}

class _AnimatorWidgetState extends State<AnimatorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> rotationAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: widget.duration);

    fadeAnimation = CurvedAnimation(parent: controller, curve: widget.curve);

    scaleAnimation = Tween<double>(begin: 0.7, end: 1).animate(fadeAnimation);

    rotationAnimation = Tween<double>(
      begin: -0.15,
      end: 0,
    ).animate(fadeAnimation);

    Offset beginOffset = Offset.zero;

    switch (widget.effect) {
      case AnimationEffect.leftToRight:
        beginOffset = const Offset(-1, 0);
        break;

      case AnimationEffect.rightToLeft:
        beginOffset = const Offset(1, 0);
        break;

      case AnimationEffect.topToBottom:
        beginOffset = const Offset(0, -1);
        break;

      case AnimationEffect.bottomToTop:
        beginOffset = const Offset(0, 1);
        break;

      default:
        beginOffset = Offset.zero;
    }

    slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    Future.delayed(widget.delay, () {
      if (mounted) controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedChild = widget.child;

    switch (widget.effect) {
      case AnimationEffect.fade:
        animatedChild = FadeTransition(
          opacity: fadeAnimation,
          child: widget.child,
        );
        break;

      case AnimationEffect.leftToRight:
      case AnimationEffect.rightToLeft:
      case AnimationEffect.topToBottom:
      case AnimationEffect.bottomToTop:
        animatedChild = FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(position: slideAnimation, child: widget.child),
        );
        break;

      case AnimationEffect.scale:
        animatedChild = FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(scale: scaleAnimation, child: widget.child),
        );
        break;

      case AnimationEffect.rotation:
        animatedChild = FadeTransition(
          opacity: fadeAnimation,
          child: RotationTransition(
            turns: rotationAnimation,
            child: widget.child,
          ),
        );
        break;
    }

    return animatedChild;
  }
}
