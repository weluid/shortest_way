import 'package:flutter/material.dart';

enum AnimationDirection { vertical, horizontal }

class AnimatedPageRoute extends PageRouteBuilder {
  final AnimationDirection animationDirection;
  final Widget page;
  final Curve curve;
  final Duration? speedAnimation;
  final Duration? reverseAnimationDuration;

  AnimatedPageRoute(
      this.animationDirection,
      this.page, {
        this.curve = Curves.decelerate,
        this.speedAnimation,
        this.reverseAnimationDuration,
      }) : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionDuration:
    speedAnimation ?? const Duration(milliseconds: 250),
    reverseTransitionDuration:
    reverseAnimationDuration ?? const Duration(milliseconds: 250),
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: animationDirection == AnimationDirection.vertical
                  ? const Offset(0, 1)
                  : const Offset(-1, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: child,
          ),
        ),
  );
}
