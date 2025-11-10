import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Internals/logic_provider.dart';

class BoolRadioScreen extends StatelessWidget {
  const BoolRadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Radios
          ListTile(
            leading: Radio<bool>(
              value: true,
              groupValue: appProvider.toggle,
              onChanged: (bool? value) {
                if (value != null && value != appProvider.toggle) {
                  appProvider.toggleBool();
                }
              },
            ),
            title: const Text('True'),
            onTap: () {
              if (!appProvider.toggle) appProvider.toggleBool();
            },
          ),
          ListTile(
            leading: Radio<bool>(
              value: false,
              groupValue: appProvider.toggle,
              onChanged: (bool? value) {
                if (value != null && value != appProvider.toggle) {
                  appProvider.toggleBool();
                }
              },
            ),
            title: const Text('False'),
            onTap: () {
              if (appProvider.toggle) appProvider.toggleBool();
            },
          ),
          const SizedBox(height: 20),

          // Estados globales previos
          Text('Toggle value: ${appProvider.toggle}'),
          const SizedBox(height: 20),
          Text('Count value: ${appProvider.counter}'),
          const SizedBox(height: 20),
          Text('Text value: ${appProvider.inputText}'),

          const Divider(height: 40),

          // Datos de la persona desde el form
          if (appProvider.person != null) ...[
            Text('--- person values ---', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Text('Name: ${appProvider.person!.name}'),
            Text('Age: ${appProvider.person!.age}'),
            Text('Height: ${appProvider.person!.height} m'),
          ],
        ],
      ),
    );
  }
}
