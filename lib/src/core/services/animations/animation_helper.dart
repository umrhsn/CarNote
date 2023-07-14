import 'package:flutter/material.dart';

class AnimationHelper {
  static void continuousRepeatableAnimation(
    AnimationController animationController,
    Animation<double> animation,
  ) {
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.repeat();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();
  }

  static void continuousReversibleAnimation(
    AnimationController animationController,
    Animation<double> animation,
  ) {
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();
  }
}
