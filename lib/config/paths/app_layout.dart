import 'package:flutter/material.dart';
import '../../widgets/header.dart';
import '../../widgets/floating_sidebar.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  final List<Widget> headerLayout;
  final List<Widget> footerLayout;
  final List<Widget>floatingLayout;

  const AppLayout({
    super.key,
    required this.child,
    this.headerLayout = const [GlobalHeader()], 
    this.footerLayout = const [], 
    this.floatingLayout = const [FloatingSidebar()],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ...headerLayout,
              Expanded(child: child),
              ...footerLayout,
            ],
          ),
          if (floatingLayout.isNotEmpty) ...floatingLayout
        ],
      ),
    );
  }
}
