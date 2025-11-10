import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Internals/logic_provider.dart';


// Example n1: Counter Screen
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Count: ${app.counter}', style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: app.decrementCounter, child: const Text('-')),
              const SizedBox(width: 20),
              ElevatedButton(onPressed: app.incrementCounter, child: const Text('+')),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: app.toggleBool, child: Text('Toggle: ${app.toggle}')),
        ],
      ),
    );
  }
}
