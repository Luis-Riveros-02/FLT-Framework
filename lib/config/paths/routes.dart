import 'package:flutter/material.dart';
import '../../Renders/counter_screen.dart';
import '../../Renders/input_screen.dart';
import '../../Renders/boolradio_screen.dart';
import '../../Renders/homeView.dart';
import '../anim.dart';

class RouteItem {
  final String label;
  final Widget page;
  final RouteAnim anim;

  const RouteItem({
    required this.label,
    required this.page,
    required this.anim,
  });
}


class RouteConfig {
  static const Map<String, RouteItem> routes = {

    '/': RouteItem(
      label: 'Home',
      page: HomeView(),
      anim: RouteAnim.toUp,
    ),

    '/counter': RouteItem(
      label: 'Counter',
      page: CounterScreen(),
      anim: RouteAnim.toLeft,
    ),

    '/input': RouteItem(
      label: 'Input',
      page: InputScreen(),
      anim: RouteAnim.toRight,
    ),

    '/boolradio': RouteItem(
      label: 'Radio',
      page: BoolRadioScreen(),
      anim: RouteAnim.fade,
    ),

  };

  static List<String> get keys => routes.keys.toList();
  static RouteItem of(String route) => routes[route] ?? routes['/']!;
}
