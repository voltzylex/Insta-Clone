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
    required this.smallLike,
  });

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
