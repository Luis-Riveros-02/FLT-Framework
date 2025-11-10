import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Internals/logic_provider.dart';
import '../config/anim.dart';
import '../config/paths/routes.dart';

class GlobalHeader extends StatelessWidget {
  const GlobalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();

    // Routes buttons
    Widget buildRouteButton(String route, RouteItem item) {
      final isActive = appProvider.currentRoute == route;

      return TextButton(
        onPressed: isActive ? null : () => appProvider.navigateTo(route),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isActive ? Colors.blue[800] : Colors.transparent,
        ),
        child: Text(
          item.label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
    }

    // Container header
    Widget headerContent() {
      return Container(
        color: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: RouteConfig.routes.entries
              .map((entry) => buildRouteButton(entry.key, entry.value))
              .toList(),
        ),
      );
    }

    // Anim header
    if (!appProvider.animHeader) return headerContent();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, anim) =>
          animatedSwitcherTransition(RouteAnim.fade, anim, child),
      child: KeyedSubtree(
        key: ValueKey(appProvider.currentRoute),
        child: headerContent(),
      ),
    );
  }
}
