import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Internals/logic_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(),
            const SizedBox(height: 30),
            _buildTitle(),
            const SizedBox(height: 15),
            _buildSubtitle(),
            const SizedBox(height: 40),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return const FlutterLogo(
      size: 150,
      style: FlutterLogoStyle.markOnly,
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Welcome to API for Flutter",
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      "Explore all the elements of the API to build your application or program.",
      style: TextStyle(fontSize: 16, color: Colors.white70),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AppProvider>().navigateTo('/counter');
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.white,
      ),
      child: const Text(
        "Go to Counter",
        style: TextStyle(
          fontSize: 16,
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
