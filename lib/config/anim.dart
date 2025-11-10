import 'package:flutter/material.dart';

enum RouteAnim { none, toLeft, toRight, toUp, toDown, fade }

Widget animatedSwitcherTransition(
    RouteAnim anim, Animation<double> animation, Widget child) {
  switch (anim) {
    case RouteAnim.toLeft:
      return SlideTransition(
        position: Tween(begin: const Offset(1, 0), end: Offset.zero)
            .animate(animation),
        child: child,
      );
    case RouteAnim.toRight:
      return SlideTransition(
        position: Tween(begin: const Offset(-1, 0), end: Offset.zero)
            .animate(animation),
        child: child,
      );
    case RouteAnim.toUp:
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: Offset.zero)
            .animate(animation),
        child: child,
      );
    case RouteAnim.toDown:
      return SlideTransition(
        position: Tween(begin: const Offset(0, -1), end: Offset.zero)
            .animate(animation),
        child: child,
      );
    case RouteAnim.fade:
      return FadeTransition(opacity: animation, child: child);
    case RouteAnim.none:
      return child;
  }
}
