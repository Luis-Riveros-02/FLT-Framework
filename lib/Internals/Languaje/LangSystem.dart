

enum AppLanguage { es, en, fr, pt }
extension AppLanguageExtension on AppLanguage {
  String get code {
    switch (this) {
      case AppLanguage.es:
        return 'es';
      case AppLanguage.en:
        return 'en';
      case AppLanguage.fr:
        return 'fr';
      case AppLanguage.pt:
        return 'pt';
    }
  }
  String get label {
    switch (this) {
      case AppLanguage.es:
        return 'ES';
      case AppLanguage.en:
        return 'EN';
      case AppLanguage.fr:
        return 'FR';
      case AppLanguage.pt:
        return 'PT';
    }
  }


  String get displayName {
    switch (this) {
      case AppLanguage.es:
        return 'Español';
      case AppLanguage.en:
        return 'English';
      case AppLanguage.fr:
        return 'Français';
      case AppLanguage.pt:
        return 'Português';
    }
  }
}