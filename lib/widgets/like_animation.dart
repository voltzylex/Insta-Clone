

import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool isAnimationg;
  final VoidCallback? onEnd;
  final bool smallLike;
  const LikeAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 150),
    required this.isAnimationg,
    this.onEnd,
    this.smallLike = false,
  });

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scale;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
    );
    scale = Tween<double>(begin: 1, end: 1.2).animate(animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimationg != oldWidget) {
      startAnimation();
    }
  }

  startAnimation() async {
    if (widget.isAnimationg || widget.smallLike) {
      await animationController.forward();
      await animationController.reverse();
      await Future.delayed(Duration(milliseconds: 200));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
