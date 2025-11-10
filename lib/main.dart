import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'Internals/logic_provider.dart';
import 'config/anim.dart';
import 'config/paths/routes.dart';
import 'config/paths/app_layout.dart';
import '../Internals/Languaje/LangSystem.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el provider desde el contexto (está arriba en el árbol)
    final appProvider = context.watch<AppProvider>();

    return MaterialApp(
      title: 'Flutter API Demo',
      // Establecemos el locale actual desde el provider
      locale: appProvider.currentLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // supportedLocales se obtiene desde availableLanguages del provider
      supportedLocales: appProvider.availableLanguages
          .map((lang) => Locale(lang.code, ''))
          .toList(),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final route = appProvider.currentRoute; // Si tienes currentRoute en AppProvider
    final item = RouteConfig.of(route);

    return AppLayout(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) =>
            animatedSwitcherTransition(item.anim, animation, child),
        child: KeyedSubtree(
          key: ValueKey(route),
          child: item.page,
        ),
      ),
    );
  }
}
