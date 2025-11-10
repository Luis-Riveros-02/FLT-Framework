import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../logic_provider.dart';
import 'LangSystem.dart';

class ValidatorError {
  static String lang(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    return provider.currentLanguage.code;
  }

  static final Map<String, Map<String, String>> _errors = {
    "es": {
      "required": "El campo '{field}' no puede estar vacío.",
      "min": "El campo '{field}' debe ser mayor o igual a {min}.",
      "max": "El campo '{field}' debe ser menor o igual a {max}.",
      "minLength": "El campo '{field}' debe tener al menos {minLength} caracteres.",
      "maxLength": "El campo '{field}' debe tener como máximo {maxLength} caracteres.",
      "invalidType": "El campo '{field}' tiene un tipo inválido.",
      "invalidFormat": "El campo '{field}' tiene un formato inválido.",
      "email": "El campo '{field}' debe ser un email válido.",
      "radioEmpty": "Debes seleccionar una opción en '{field}'.",
      "radioInvalid": "La opción seleccionada en '{field}' no es válida.",
      "checkboxEmpty": "Debes marcar el campo '{field}'.",
      "multiCheckboxEmpty": "Debes seleccionar al menos una opción en '{field}'.",
      "dateEmpty": "El campo '{field}' no puede estar vacío.",
      "dateTooEarly": "La fecha en '{field}' no puede ser anterior a {min}.",
      "dateTooLate": "La fecha en '{field}' no puede ser posterior a {max}.",
      "timeEmpty": "El campo '{field}' no puede estar vacío.",
      "timeTooEarly": "La hora en '{field}' no puede ser antes de {min}.",
      "timeTooLate": "La hora en '{field}' no puede ser después de {max}.",
      "fileEmpty": "El campo '{field}' requiere al menos un archivo.",
      "fileTooMany": "No puedes subir más de {maxFiles} archivos en '{field}'.",
      "fileInvalidExtension": "Archivo '{file}' en '{field}' tiene una extensión inválida.",
      "fileTooLarge": "Archivo '{file}' en '{field}' excede el tamaño máximo de {maxSize} MB.",
      "dropdownEmpty": "Debes seleccionar un valor en '{field}'.",
      "dropdownInvalid": "El valor seleccionado en '{field}' no es válido."
    },
    "en": {
      "required": "Field '{field}' cannot be empty.",
      "min": "Field '{field}' must be >= {min}.",
      "max": "Field '{field}' must be <= {max}.",
      "minLength": "Field '{field}' must have at least {minLength} characters.",
      "maxLength": "Field '{field}' must have at most {maxLength} characters.",
      "invalidType": "Field '{field}' has an invalid type.",
      "invalidFormat": "Field '{field}' has invalid format.",
      "email": "Field '{field}' must be a valid email.",
      "radioEmpty": "You must select an option in '{field}'.",
      "radioInvalid": "The selected option in '{field}' is not valid.",
      "checkboxEmpty": "You must check '{field}'.",
      "multiCheckboxEmpty": "You must select at least one option in '{field}'.",
      "dateEmpty": "Field '{field}' cannot be empty.",
      "dateTooEarly": "The date in '{field}' cannot be before {min}.",
      "dateTooLate": "The date in '{field}' cannot be after {max}.",
      "timeEmpty": "Field '{field}' cannot be empty.",
      "timeTooEarly": "The time in '{field}' cannot be before {min}.",
      "timeTooLate": "The time in '{field}' cannot be after {max}.",
      "fileEmpty": "Field '{field}' requires at least one file.",
      "fileTooMany": "You cannot upload more than {maxFiles} files in '{field}'.",
      "fileInvalidExtension": "File '{file}' in '{field}' has an invalid extension.",
      "fileTooLarge": "File '{file}' in '{field}' exceeds the maximum size of {maxSize} MB.",
      "dropdownEmpty": "You must select a value in '{field}'.",
      "dropdownInvalid": "The selected value in '{field}' is not valid."
    },
    "fr": {
      "required": "Le champ '{field}' ne peut pas être vide.",
      "min": "Le champ '{field}' doit être ≥ {min}.",
      "max": "Le champ '{field}' doit être ≤ {max}.",
      "minLength": "Le champ '{field}' doit contenir au moins {minLength} caractères.",
      "maxLength": "Le champ '{field}' doit contenir au maximum {maxLength} caractères.",
      "invalidType": "Le champ '{field}' a un type invalide.",
      "invalidFormat": "Le champ '{field}' a un format invalide.",
      "email": "Le champ '{field}' doit être un email valide.",
      "radioEmpty": "Vous devez sélectionner une option dans '{field}'.",
      "radioInvalid": "L'option sélectionnée dans '{field}' n'est pas valide.",
      "checkboxEmpty": "Vous devez cocher '{field}'.",
      "multiCheckboxEmpty": "Vous devez sélectionner au moins une option dans '{field}'.",
      "dateEmpty": "Le champ '{field}' ne peut pas être vide.",
      "dateTooEarly": "La date dans '{field}' ne peut pas être antérieure à {min}.",
      "dateTooLate": "La date dans '{field}' ne peut pas être postérieure à {max}.",
      "timeEmpty": "Le champ '{field}' ne peut pas être vide.",
      "timeTooEarly": "L'heure dans '{field}' ne peut pas être avant {min}.",
      "timeTooLate": "L'heure dans '{field}' ne peut pas être après {max}.",
      "fileEmpty": "Le champ '{field}' requiert au moins un fichier.",
      "fileTooMany": "Vous ne pouvez pas télécharger plus de {maxFiles} fichiers dans '{field}'.",
      "fileInvalidExtension": "Le fichier '{file}' dans '{field}' a une extension invalide.",
      "fileTooLarge": "Le fichier '{file}' dans '{field}' dépasse la taille maximale de {maxSize} Mo.",
      "dropdownEmpty": "Vous devez sélectionner une valeur dans '{field}'.",
      "dropdownInvalid": "La valeur sélectionnée dans '{field}' n'est pas valide."
    },
    "pt": {
      "required": "O campo '{field}' não pode estar vazio.",
      "min": "O campo '{field}' deve ser ≥ {min}.",
      "max": "O campo '{field}' deve ser ≤ {max}.",
      "minLength": "O campo '{field}' deve ter pelo menos {minLength} caracteres.",
      "maxLength": "O campo '{field}' deve ter no máximo {maxLength} caracteres.",
      "invalidType": "O campo '{field}' tem um tipo inválido.",
      "invalidFormat": "O campo '{field}' tem um formato inválido.",
      "email": "O campo '{field}' deve ser um e-mail válido.",
      "radioEmpty": "Você deve selecionar uma opção em '{field}'.",
      "radioInvalid": "A opção selecionada em '{field}' não é válida.",
      "checkboxEmpty": "Você deve marcar '{field}'.",
      "multiCheckboxEmpty": "Você deve selecionar pelo menos uma opção em '{field}'.",
      "dateEmpty": "O campo '{field}' não pode estar vazio.",
      "dateTooEarly": "A data em '{field}' não pode ser anterior a {min}.",
      "dateTooLate": "A data em '{field}' não pode ser posterior a {max}.",
      "timeEmpty": "O campo '{field}' não pode estar vazio.",
      "timeTooEarly": "A hora em '{field}' não pode ser antes de {min}.",
      "timeTooLate": "A hora em '{field}' não pode ser depois de {max}.",
      "fileEmpty": "O campo '{field}' requer pelo menos um arquivo.",
      "fileTooMany": "Você não pode enviar mais de {maxFiles} arquivos em '{field}'.",
      "fileInvalidExtension": "O arquivo '{file}' em '{field}' tem uma extensão inválida.",
      "fileTooLarge": "O arquivo '{file}' em '{field}' excede o tamanho máximo de {maxSize} MB.",
      "dropdownEmpty": "Você deve selecionar um valor em '{field}'.",
      "dropdownInvalid": "O valor selecionado em '{field}' não é válido."
    }
  };

    static String get(BuildContext context, String key, [Map<String, dynamic> params = const {}]) {
    final currentLang = lang(context);
    String template = _errors[currentLang]?[key] ?? key;

    params.forEach((k, v) {
      template = template.replaceAll('{$k}', v.toString());
    });

    return template;
  }
}
