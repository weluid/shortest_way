import 'package:flutter/cupertino.dart';
import '../app.dart';
import '../utils/animation_route.dart';

class NavigationService {
  void push(Widget classTo, {BuildContext? context}) {
    Navigator.push(
      context ?? App.globalContext,
      CupertinoPageRoute(
        builder: (_) => classTo,
      ),
    );
  }

  void pushWithAnimation(Widget classTo,
      {direction = AnimationDirection.vertical, Duration? speedAnimationDuration}) {
    Navigator.push(
      App.globalContext,
      AnimatedPageRoute(
        direction,
        classTo,
        speedAnimation: speedAnimationDuration,
        reverseAnimationDuration: speedAnimationDuration,
      ),
    );
  }

  void pushAndRemoveUntil(Widget classTo) {
    Navigator.pushAndRemoveUntil(
      App.globalContext,
      CupertinoPageRoute(
        builder: (_) => classTo,
        allowSnapshotting: false,
      ),
          (route) => false,
    );
  }

  void pushReplacement(Widget classTo) {
    Navigator.pushReplacement(
      App.globalContext,
      CupertinoPageRoute(
        builder: (_) => classTo,
      ),
    );
  }

  Future<void> pop({Object? result, BuildContext? context}) async {
    if (Navigator.canPop(context ?? App.globalContext)) {
      Navigator.of(context ?? App.globalContext).pop(result);
    }
  }
}
