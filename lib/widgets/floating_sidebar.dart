import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Internals/logic_provider.dart';
import '../Internals/Languaje/LangSystem.dart';

class FloatingSidebar extends StatefulWidget {
  const FloatingSidebar({super.key});

  @override
  State<FloatingSidebar> createState() => _FloatingSidebarState();
}

class _FloatingSidebarState extends State<FloatingSidebar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _toggleSidebar() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    return Stack(
      children: [

        // open/close logic
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: _toggleSidebar,
              child: Icon(_isOpen ? Icons.close : Icons.menu),
            ),
          ),
        ),

        // Sidebar
        SlideTransition(
          position: _offsetAnimation,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 250,
              height: double.infinity,
              color: const Color.fromARGB(255, 180, 180, 180),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //elements sidebar
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _toggleSidebar,
                    ),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {app.navigateTo('/'); _toggleSidebar();},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                    ),
                    child: const Text("Home",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {app.navigateTo('/counter'); _toggleSidebar();},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                    ),
                    child: const Text("Counter",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {app.navigateTo('/input'); _toggleSidebar();},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                    ),
                    child: const Text("Input",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {app.navigateTo('/boolradio'); _toggleSidebar();},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                    ),
                    child: const Text("Boolradio",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  CheckboxListTile(
                    title: const Text("Anim Header"),
                    value: context.watch<AppProvider>().animHeader,
                    onChanged: (value) {
                      app.setAnimHeader(value ?? false);
                    },
                  ),

                  DropdownButton<AppLanguage>(
                    value: context.watch<AppProvider>().currentLanguage,
                    items: context.watch<AppProvider>().availableLanguages.map((lang) {
                      return DropdownMenuItem(
                        value: lang,
                        child: Text(lang.label),
                      );
                    }).toList(),
                    onChanged: (newLang) {
                      if (newLang != null) {
                        context.read<AppProvider>().setLanguage(newLang);
                      }
                    }
                    )

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

