@echo off
REM ==========================================
REM Crear estructura de carpetas
REM ==========================================
if not exist lib mkdir lib
if not exist lib\providers mkdir lib\providers
if not exist lib\models mkdir lib\models
if not exist lib\forms mkdir lib\forms
if not exist lib\widgets mkdir lib\widgets
if not exist lib\screens mkdir lib\screens

REM ==========================================
REM main.dart con rutas y header global
REM ==========================================
REM ==========================================
REM main.dart con rutas mejoradas (CORREGIDO)
REM ==========================================
> lib\main.dart echo import 'package:flutter/material.dart';
>> lib\main.dart echo import 'package:provider/provider.dart';
>> lib\main.dart echo import 'screens/counter_screen.dart';
>> lib\main.dart echo import 'screens/input_screen.dart';
>> lib\main.dart echo import 'screens/boolradio_screen.dart';
>> lib\main.dart echo import 'widgets/header.dart';
>> lib\main.dart echo import 'providers/app_provider.dart';
>> lib\main.dart echo.
>> lib\main.dart echo void main^(^) ^{
>> lib\main.dart echo   runApp^(
>> lib\main.dart echo     ChangeNotifierProvider^(
>> lib\main.dart echo       create: ^(_^) =^>^ AppProvider^(^),
>> lib\main.dart echo       child: const MyApp^(^),
>> lib\main.dart echo     ^),
>> lib\main.dart echo   ^);
>> lib\main.dart echo ^}
>> lib\main.dart echo.
>> lib\main.dart echo class MyApp extends StatelessWidget ^{
>> lib\main.dart echo   const MyApp^(^{super.key^}^);
>> lib\main.dart echo.
>> lib\main.dart echo   @override
>> lib\main.dart echo   Widget build^(BuildContext context^) ^{
>> lib\main.dart echo     return MaterialApp^(
>> lib\main.dart echo       title: 'Flutter Provider Demo',
>> lib\main.dart echo       initialRoute: '/counter',
>> lib\main.dart echo       routes: ^{
>> lib\main.dart echo         '/counter': ^(_^) =^>^ const ScreenWrapper^(child: CounterScreen^(^)^),
>> lib\main.dart echo         '/input': ^(_^) =^>^ const ScreenWrapper^(child: InputScreen^(^)^),
>> lib\main.dart echo         '/boolradio': ^(_^) =^>^ const ScreenWrapper^(child: BoolRadioScreen^(^)^),
>> lib\main.dart echo       ^},
>> lib\main.dart echo     ^);
>> lib\main.dart echo   ^}
>> lib\main.dart echo ^}
>> lib\main.dart echo.
>> lib\main.dart echo class ScreenWrapper extends StatelessWidget ^{
>> lib\main.dart echo   final Widget child;
>> lib\main.dart echo   const ScreenWrapper^(^{super.key, required this.child^}^);
>> lib\main.dart echo.
>> lib\main.dart echo   @override
>> lib\main.dart echo   Widget build^(BuildContext context^) ^{
>> lib\main.dart echo     return Scaffold^(
>> lib\main.dart echo       appBar: const PreferredSize^(
>> lib\main.dart echo         preferredSize: Size.fromHeight^(60^),
>> lib\main.dart echo         child: GlobalHeader^(^),
>> lib\main.dart echo       ^),
>> lib\main.dart echo       body: child,
>> lib\main.dart echo     ^);
>> lib\main.dart echo   ^}
>> lib\main.dart echo ^}

REM ==========================================
REM App Provider
REM ==========================================
> lib\providers\app_provider.dart echo import 'package:flutter/material.dart';
>> lib\providers\app_provider.dart echo.
>> lib\providers\app_provider.dart echo  class AppProvider extends ChangeNotifier {
>> lib\providers\app_provider.dart echo      bool toggle = false;
>> lib\providers\app_provider.dart echo      String inputText = '';
>> lib\providers\app_provider.dart echo      int counter = 0;
>> lib\providers\app_provider.dart echo.
>> lib\providers\app_provider.dart echo     void toggleBool() {
>> lib\providers\app_provider.dart echo         toggle = !toggle;
>> lib\providers\app_provider.dart echo         notifyListeners();
>> lib\providers\app_provider.dart echo     }
>> lib\providers\app_provider.dart echo.
>> lib\providers\app_provider.dart echo     void setInputText(String text) {
>> lib\providers\app_provider.dart echo          inputText = text;
>> lib\providers\app_provider.dart echo          notifyListeners();
>> lib\providers\app_provider.dart echo      }
>> lib\providers\app_provider.dart echo.
>> lib\providers\app_provider.dart echo      void incrementCounter() {
>> lib\providers\app_provider.dart echo          counter++;
>> lib\providers\app_provider.dart echo          notifyListeners();
>> lib\providers\app_provider.dart echo      }
>> lib\providers\app_provider.dart echo.
>> lib\providers\app_provider.dart echo      void decrementCounter() {
>> lib\providers\app_provider.dart echo          counter--;
>> lib\providers\app_provider.dart echo          notifyListeners();
>> lib\providers\app_provider.dart echo      }
>> lib\providers\app_provider.dart echo  }

REM ==========================================
REM Global Header
REM ==========================================
> lib\widgets\header.dart echo import 'package:flutter/material.dart';
>> lib\widgets\header.dart echo.
>> lib\widgets\header.dart echo class GlobalHeader extends StatelessWidget {
>> lib\widgets\header.dart echo     const GlobalHeader({super.key});
>> lib\widgets\header.dart echo.
>> lib\widgets\header.dart echo     @override
>> lib\widgets\header.dart echo     Widget build(BuildContext context) {
>> lib\widgets\header.dart echo         return Container(
>> lib\widgets\header.dart echo             color: Colors.blue,
>> lib\widgets\header.dart echo             child: const Center(
>> lib\widgets\header.dart echo                 child: Text('Header Global', style: TextStyle(color: Colors.white, fontSize: 20)),
>> lib\widgets\header.dart echo             ),
>> lib\widgets\header.dart echo         );
>> lib\widgets\header.dart echo     }
>> lib\widgets\header.dart echo }

REM ==========================================
REM Counter Screen
REM ==========================================
> lib\screens\counter_screen.dart echo import 'package:flutter/material.dart';
>> lib\screens\counter_screen.dart echo import 'package:provider/provider.dart';
>> lib\screens\counter_screen.dart echo import '../providers/app_provider.dart';
>> lib\screens\counter_screen.dart echo.
>> lib\screens\counter_screen.dart echo class CounterScreen extends StatelessWidget {
>> lib\screens\counter_screen.dart echo     const CounterScreen({super.key});
>> lib\screens\counter_screen.dart echo.
>> lib\screens\counter_screen.dart echo     @override
>> lib\screens\counter_screen.dart echo     Widget build(BuildContext context) {
>> lib\screens\counter_screen.dart echo         final app = context.watch^<^AppProvider^>^(^)^;
>> lib\screens\counter_screen.dart echo         return Center(
>> lib\screens\counter_screen.dart echo             child: Column(
>> lib\screens\counter_screen.dart echo                 mainAxisAlignment: MainAxisAlignment.center,
>> lib\screens\counter_screen.dart echo                 children: [
>> lib\screens\counter_screen.dart echo                     Text('Contador: ${app.counter}', style: TextStyle(fontSize: 24)),
>> lib\screens\counter_screen.dart echo                     SizedBox(height: 20),
>> lib\screens\counter_screen.dart echo                     Row(
>> lib\screens\counter_screen.dart echo                         mainAxisAlignment: MainAxisAlignment.center,
>> lib\screens\counter_screen.dart echo                         children: [
>> lib\screens\counter_screen.dart echo                             ElevatedButton(
>> lib\screens\counter_screen.dart echo                                 onPressed: app.decrementCounter,
>> lib\screens\counter_screen.dart echo                                 child: Text('-'),
>> lib\screens\counter_screen.dart echo                             ),
>> lib\screens\counter_screen.dart echo                             SizedBox(width: 20),
>> lib\screens\counter_screen.dart echo                             ElevatedButton(
>> lib\screens\counter_screen.dart echo                                 onPressed: app.incrementCounter,
>> lib\screens\counter_screen.dart echo                                 child: Text('+'),
>> lib\screens\counter_screen.dart echo                             ),
>> lib\screens\counter_screen.dart echo                         ],
>> lib\screens\counter_screen.dart echo                     ),
>> lib\screens\counter_screen.dart echo                     SizedBox(height: 20),
>> lib\screens\counter_screen.dart echo                     ElevatedButton(
>> lib\screens\counter_screen.dart echo                         onPressed: app.toggleBool,
>> lib\screens\counter_screen.dart echo                         child: Text('Toggle: ${app.toggle}'),
>> lib\screens\counter_screen.dart echo                     ),
>> lib\screens\counter_screen.dart echo                 ],
>> lib\screens\counter_screen.dart echo             ),
>> lib\screens\counter_screen.dart echo         );
>> lib\screens\counter_screen.dart echo     }
>> lib\screens\counter_screen.dart echo }


REM ==========================================
REM Input Screen
REM ==========================================
> lib\screens\input_screen.dart echo import 'package:flutter/material.dart';
>> lib\screens\input_screen.dart echo import 'package:provider/provider.dart';
>> lib\screens\input_screen.dart echo import '../providers/app_provider.dart';
>> lib\screens\input_screen.dart echo.
>> lib\screens\input_screen.dart echo class InputScreen extends StatelessWidget {
>> lib\screens\input_screen.dart echo     const InputScreen({super.key});
>> lib\screens\input_screen.dart echo.
>> lib\screens\input_screen.dart echo     @override
>> lib\screens\input_screen.dart echo     Widget build(BuildContext context) {
>> lib\screens\input_screen.dart echo         final app = context.watch^<^AppProvider^>^(^)^;
>> lib\screens\input_screen.dart echo         return Padding(
>> lib\screens\input_screen.dart echo             padding: const EdgeInsets.all(16),
>> lib\screens\input_screen.dart echo             child: Column(
>> lib\screens\input_screen.dart echo                 mainAxisAlignment: MainAxisAlignment.center,
>> lib\screens\input_screen.dart echo                 children: [
>> lib\screens\input_screen.dart echo                     TextField(
>> lib\screens\input_screen.dart echo                         onChanged: app.setInputText,
>> lib\screens\input_screen.dart echo                         decoration: InputDecoration(
>> lib\screens\input_screen.dart echo                             labelText: 'Ingresa texto',
>> lib\screens\input_screen.dart echo                             border: OutlineInputBorder(),
>> lib\screens\input_screen.dart echo                         ),
>> lib\screens\input_screen.dart echo                     ),
>> lib\screens\input_screen.dart echo                     SizedBox(height: 20),
>> lib\screens\input_screen.dart echo                     Text('Texto ingresado: ${app.inputText}'),
>> lib\screens\input_screen.dart echo                     SizedBox(height: 20),
>> lib\screens\input_screen.dart echo                     Text('Toggle actual: ${app.toggle}'),
>> lib\screens\input_screen.dart echo                 ],
>> lib\screens\input_screen.dart echo             ),
>> lib\screens\input_screen.dart echo         );
>> lib\screens\input_screen.dart echo     }
>> lib\screens\input_screen.dart echo }

REM ==========================================
REM Bool & Radio Screen
REM ==========================================
REM ==========================================
REM BoolRadio Screen Corregido
REM ==========================================
> lib\screens\boolradio_screen.dart echo import 'package:flutter/material.dart';
>> lib\screens\boolradio_screen.dart echo import 'package:provider/provider.dart';
>> lib\screens\boolradio_screen.dart echo import '../providers/app_provider.dart';
>> lib\screens\boolradio_screen.dart echo.
>> lib\screens\boolradio_screen.dart echo class BoolRadioScreen extends StatelessWidget ^{
>> lib\screens\boolradio_screen.dart echo   const BoolRadioScreen^(^{super.key^}^);
>> lib\screens\boolradio_screen.dart echo.
>> lib\screens\boolradio_screen.dart echo   @override
>> lib\screens\boolradio_screen.dart echo   Widget build^(BuildContext context^) ^{
>> lib\screens\boolradio_screen.dart echo     final appProvider = context.watch^<^AppProvider^>^(^)^;
>> lib\screens\boolradio_screen.dart echo.
>> lib\screens\boolradio_screen.dart echo     return Padding^(
>> lib\screens\boolradio_screen.dart echo       padding: const EdgeInsets.all^(16^),
>> lib\screens\boolradio_screen.dart echo       child: Column^(
>> lib\screens\boolradio_screen.dart echo         mainAxisAlignment: MainAxisAlignment.center,
>> lib\screens\boolradio_screen.dart echo         children: [
>> lib\screens\boolradio_screen.dart echo           ListTile^(
>> lib\screens\boolradio_screen.dart echo             leading: Radio^<bool^>^(
>> lib\screens\boolradio_screen.dart echo               value: true,
>> lib\screens\boolradio_screen.dart echo               groupValue: appProvider.toggle,
>> lib\screens\boolradio_screen.dart echo               onChanged: ^(bool? value^) ^{
>> lib\screens\boolradio_screen.dart echo                 if ^(value != null ^&^& value != appProvider.toggle^) ^{
>> lib\screens\boolradio_screen.dart echo                   appProvider.toggleBool^(^);
>> lib\screens\boolradio_screen.dart echo                 ^}
>> lib\screens\boolradio_screen.dart echo               ^},
>> lib\screens\boolradio_screen.dart echo             ^),
>> lib\screens\boolradio_screen.dart echo             title: const Text^('True'^),
>> lib\screens\boolradio_screen.dart echo             onTap: ^(^) ^{
>> lib\screens\boolradio_screen.dart echo               if ^(!appProvider.toggle^) ^{
>> lib\screens\boolradio_screen.dart echo                 appProvider.toggleBool^(^);
>> lib\screens\boolradio_screen.dart echo               ^}
>> lib\screens\boolradio_screen.dart echo             ^},
>> lib\screens\boolradio_screen.dart echo           ^),
>> lib\screens\boolradio_screen.dart echo           ListTile^(
>> lib\screens\boolradio_screen.dart echo             leading: Radio^<bool^>^(
>> lib\screens\boolradio_screen.dart echo               value: false,
>> lib\screens\boolradio_screen.dart echo               groupValue: appProvider.toggle,
>> lib\screens\boolradio_screen.dart echo               onChanged: ^(bool? value^) ^{
>> lib\screens\boolradio_screen.dart echo                 if ^(value != null ^&^& value != appProvider.toggle^) ^{
>> lib\screens\boolradio_screen.dart echo                   appProvider.toggleBool^(^);
>> lib\screens\boolradio_screen.dart echo                 ^}
>> lib\screens\boolradio_screen.dart echo               ^},
>> lib\screens\boolradio_screen.dart echo             ^),
>> lib\screens\boolradio_screen.dart echo             title: const Text^('False'^),
>> lib\screens\boolradio_screen.dart echo             onTap: ^(^) ^{
>> lib\screens\boolradio_screen.dart echo               if ^(appProvider.toggle^) ^{
>> lib\screens\boolradio_screen.dart echo                 appProvider.toggleBool^(^);
>> lib\screens\boolradio_screen.dart echo               ^}
>> lib\screens\boolradio_screen.dart echo             ^},
>> lib\screens\boolradio_screen.dart echo           ^),
>> lib\screens\boolradio_screen.dart echo           const SizedBox^(height: 20^),
>> lib\screens\boolradio_screen.dart echo           Text^('Toggle: ^${appProvider.toggle}^'^),
>> lib\screens\boolradio_screen.dart echo           const SizedBox^(height: 20^),
>> lib\screens\boolradio_screen.dart echo           Text^('Contador: ^${appProvider.counter}^'^),
>> lib\screens\boolradio_screen.dart echo           const SizedBox^(height: 20^),
>> lib\screens\boolradio_screen.dart echo           Text^('Texto: ^${appProvider.inputText}^'^),
>> lib\screens\boolradio_screen.dart echo         ],
>> lib\screens\boolradio_screen.dart echo       ^),
>> lib\screens\boolradio_screen.dart echo     ^);
>> lib\screens\boolradio_screen.dart echo   ^}
>> lib\screens\boolradio_screen.dart echo ^}


echo.
echo Estructura creada exitosamente!
echo Ejecuta 'flutter pub get' para instalar las dependencias