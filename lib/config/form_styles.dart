import 'package:flutter/material.dart';

/// Selector de estilos
class StyleSelector {
  static final form1 = Form1Style();
  static final form2 = Form2Style();
  static final form3 = Form3Style();
}

/// Estilo para Formulario 1
class Form1Style {
  final InputDecoration inputDecoration = const InputDecoration(
    labelStyle: TextStyle(color: Colors.blue),
    border: OutlineInputBorder(),
  );
  final TextStyle inputTextStyle = const TextStyle(fontSize: 16);
  final TextStyle placeholderStyle = const TextStyle(color: Color.fromARGB(255, 44, 89, 140)); // <- rojo
  final TextStyle titleStyle = const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue);
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    padding: EdgeInsets.symmetric(vertical: 15),
  );
  final TextStyle buttonTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  final TextStyle textError = const TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Color.fromARGB(255, 244, 54, 54),backgroundColor: Color.fromARGB(30, 244, 67, 54));
}



/// Estilo para Formulario 2
class Form2Style {
  final InputDecoration inputDecoration = const InputDecoration(
    labelStyle: TextStyle(color: Colors.green),
    border: UnderlineInputBorder(),
  );
  final TextStyle inputTextStyle = const TextStyle(fontSize: 16);
  final TextStyle placeholderStyle = const TextStyle(color: Color.fromARGB(255, 81, 127, 51), fontSize: 14, fontStyle: FontStyle.italic);
  final TextStyle titleStyle = const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 61, 243, 33));
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    padding: EdgeInsets.symmetric(vertical: 15),
  );
  final TextStyle buttonTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
    final TextStyle textError = const TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.red,backgroundColor: Color.fromARGB(30, 244, 67, 54));

}

/// Estilo para Formulario 3
class Form3Style {
  final InputDecoration inputDecoration = const InputDecoration(
    labelStyle: TextStyle(color: Colors.red),
    border: OutlineInputBorder(),
  );
  final TextStyle inputTextStyle = const TextStyle(fontSize: 16);
  final TextStyle placeholderStyle = const TextStyle(color: Color.fromARGB(255, 255, 91, 36), fontSize: 14, fontStyle: FontStyle.italic);
  final TextStyle titleStyle = const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 213, 97, 25));
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
    padding: EdgeInsets.symmetric(vertical: 15),
  );
  final TextStyle buttonTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
    final TextStyle textError = const TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.red,backgroundColor: Color.fromARGB(30, 244, 67, 54));

}
