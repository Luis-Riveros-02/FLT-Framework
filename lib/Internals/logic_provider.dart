import 'package:flutter/material.dart';
import '../config/paths/routes.dart';
import '../config/models.dart';
import 'Languaje/LangSystem.dart';

//global state management and functions
class AppProvider extends ChangeNotifier {

  // settings and navigation
  String currentRoute = '/';
  bool notifyLight = true;
  bool animHeader = false;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  

  final List<AppLanguage> availableLanguages = [
    AppLanguage.es,
    AppLanguage.en,
    AppLanguage.fr,
    AppLanguage.pt,
  ];

  AppLanguage _currentLanguage = AppLanguage.en;
   AppLanguage get currentLanguage => _currentLanguage;
  Locale get currentLocale => Locale(_currentLanguage.code, '');

  void setLanguage(AppLanguage language) {
    if (language == _currentLanguage) return;
    _currentLanguage = language;
    notifyListeners();
  }
 void navigateTo(String route) {
    if (!RouteConfig.routes.containsKey(route)) return;
    currentRoute = route;
    notifyListeners();
  }

  void setAnimHeader(bool value) {
    animHeader = value;
    notifyListeners();
  }

  //--------------------------------//
  // Model form state
  Person? _person;
  Person? get person => _person;
  void setPerson(Person p) {
    _person = p;
    notifyListeners();
  }
  //--------------------------------//


  // misselaneous app state
  bool toggle = false;
  String inputText = '';
  int counter = 0;


  void toggleBool() {
    toggle = !toggle;
    notifyListeners();
  }

  void setInputText(String text) {
    inputText = text;
    notifyListeners();
  }

  void incrementCounter() {
    counter++;
    notifyListeners();
  }

  void decrementCounter() {
    counter--;
    notifyListeners();
  }

  void setNotifyLight(bool value) {
    notifyLight = value;
    notifyListeners();
  }
}
