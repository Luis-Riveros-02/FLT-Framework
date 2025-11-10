import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/forms.dart';
import '../Internals/logic_provider.dart';
import '../config/form_styles.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final PersonForm _form = PersonForm(visualForm: StyleSelector.form1);


   @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Person Form")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: 1200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: _form.renderWithStyle(app, context),
          ),
        ),
      ),
    );
  }
}
