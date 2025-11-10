import 'dart:io';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import '../../Internals/Languaje/InfoError.dart';


/// ---------- Base Validator ----------
abstract class ValidatorField {
  String name;
  String? input;
  String? placeholder;
  final void Function(dynamic oldValue, dynamic newValue)? onValueChanged;

  ValidatorField(this.name, {this.input, this.placeholder, this.onValueChanged});

  @protected
  void notifyValueChanged(dynamic oldValue, dynamic newValue) {
    if (oldValue != newValue) {
      onValueChanged?.call(oldValue, newValue);
      onValueChangedOverride(oldValue, newValue);
    }
  }

  @protected
  void onValueChangedOverride(dynamic oldValue, dynamic newValue) {}

   String? validate(BuildContext context);
}

/// ---------- Condition Checker ----------
class ConditionChecker {
  static String? check({
    required String fieldName,
    required BuildContext context,
    dynamic value,
    bool? noNull,
    num? min,
    num? max,
    int? minLength,
    int? maxLength,
  }) {
    if (noNull == true && (value == null || (value is String && value.isEmpty) || (value is List && value.isEmpty))) {
      return ValidatorError.get(context,"required", {"field": fieldName});
    }
    if (value != null) {
      if (value is num) {
        if (min != null && value < min) {
          return ValidatorError.get(context,"min", {"field": fieldName, "min": min});
        }
        if (max != null && value > max) {
          return ValidatorError.get(context,"max", {"field": fieldName, "max": max});
        }
      } else if (value is String || value is List) {
        final len = value.length;
        if (minLength != null && len < minLength) {
          return ValidatorError.get(context,"minLength", {"field": fieldName, "minLength": minLength});
        }
        if (maxLength != null && len > maxLength) {
          return ValidatorError.get(context,"maxLength", {"field": fieldName, "maxLength": maxLength});
        }
      } else {
        return ValidatorError.get(context, "invalidType", {"field": fieldName});
      }
    }
    return null;
  }
}


/// ---------- NumberField ----------
abstract class NumericField<T extends num> extends ValidatorField {
  T? value;
  final bool? noNull;
  final T? min, max;
  final String? suffix;

  NumericField(
    String name, {
    this.noNull,
    this.min,
    this.max,
    String? input,
    String? placeholder,
    this.suffix,
    void Function(dynamic, dynamic)? onValueChanged,
  }) : super(name, input: input, placeholder: placeholder, onValueChanged: onValueChanged);

  T convert(num result);

  void liveSanitize() {
    if (input == null) return;
    input = input!.replaceAll(',', '.');
    input = input!.replaceAll(RegExp(r'[^0-9+\-*/().]'), '');
  }

  void evaluateFinal({bool appendSuffix = true}) {
    final old = value;

    if (input == null || input!.trim().isEmpty) {
      value = null;
      input = null;
    } else {
      liveSanitize();
      try {
        final result = Parser().parse(input!).evaluate(EvaluationType.REAL, ContextModel());
        var parsed = convert(result);

        if (min != null && parsed < min!) parsed = min!;
        if (max != null && parsed > max!) parsed = max!;

        value = parsed;

        if (appendSuffix && suffix != null) {
          input = "$value$suffix";
        } else {
          input = value.toString();
        }
      } catch (_) {
        value = null;
      }
    }

    notifyValueChanged(old, value);
  }

  @override
  String? validate(context) {
    evaluateFinal();
    if (noNull == true && value == null) return ValidatorError.get(context,"required", {"field": name});



    return ConditionChecker.check(context:context, fieldName: name, value: value, noNull: noNull, min: min, max: max);
  }
}

/// ---------- Int ----------
class Number_Field extends NumericField<int> {
  Number_Field({
    required String name,
    bool? noNull,
    int? min,
    int? max,
    String? input,
    String? placeholder,
    void Function(dynamic, dynamic)? onValueChanged,
  }) : super(name, noNull: noNull, min: min, max: max, input: input, placeholder: placeholder, onValueChanged: onValueChanged);

  @override
  int convert(num result) => result.toInt();
}

/// ---------- Float ----------
class Float_Field extends NumericField<double> {
  Float_Field({
    required String name,
    bool? noNull,
    double? min,
    double? max,
    String? input,
    String? placeholder,
    void Function(dynamic, dynamic)? onValueChanged,
  }) : super(name, noNull: noNull, min: min, max: max, input: input, placeholder: placeholder, onValueChanged: onValueChanged);

  @override
  double convert(num result) => result.toDouble();
}

/// ---------- TextValidator ----------
class Text_Input extends ValidatorField {
  String? value;
  final bool? noNull;
  final int? minLength, maxLength;
  final String? pattern;
  final bool showCounter;

  Text_Input({
    required String name,
    this.noNull,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.showCounter = false,
    String? placeholder,
    String? input,
    void Function(dynamic, dynamic)? onValueChanged,
  }) : super(name, input: input, placeholder: placeholder, onValueChanged: onValueChanged);

  void liveEvaluate() {
    final old = value;
    value = input?.trim();
    notifyValueChanged(old, value);
  }

  @override
  String? validate(context) {
    final old = value;
    value = input?.trim();
    notifyValueChanged(old, value);
    if (pattern != null && value != null && !RegExp(pattern!).hasMatch(value!)) {
      return ValidatorError.get(context, "invalidFormat", {"field": name});
    }
    return ConditionChecker.check(
      context:context,
      fieldName: name,
      value: value,
      noNull: noNull,
      minLength: minLength,
      maxLength: maxLength,
    );
  }
}

class TextArea_Input extends ValidatorField {
  String? value;
  final bool? noNull;
  final int? minLength, maxLength;
  final int heightScale;
  final bool showCounter; 

  TextArea_Input({
    required String name,
    this.noNull,
    this.minLength,
    this.maxLength,
    this.heightScale = 3,
    this.showCounter = false,
    String? placeholder,
    String? input,
    void Function(dynamic, dynamic)? onValueChanged,
  })  : value = input,
        super(
          name,
          input: input,
          placeholder: placeholder,
          onValueChanged: onValueChanged,
        );

  void liveEvaluate() {
    final old = value;
    value = input?.trim();
    notifyValueChanged(old, value);
  }

  @override
  String? validate(context) {
    final old = value;
    value = input?.trim();
    notifyValueChanged(old, value);

    return ConditionChecker.check(
      context:context,
      fieldName: name,
      value: value,
      noNull: noNull,
      minLength: minLength,
      maxLength: maxLength,
    );
  }
}



// ---------- Password Input ----------
class Password_Input extends Text_Input {
  bool obscure;

  Password_Input({
    required String name,
    bool? noNull,
    int? minLength,
    int? maxLength,
    String? pattern,
    String? placeholder,
    String? input,
    this.obscure = true,
    bool showCounter = false,
    void Function(dynamic, dynamic)? onValueChanged,
  }) : super(
          name: name,
          noNull: noNull,
          minLength: minLength,
          maxLength: maxLength,
          pattern: pattern,
          placeholder: placeholder,
          input: input,
          showCounter: showCounter,
          onValueChanged: onValueChanged,
        );
}

/// ---------- Email Input ----------
class Email_Input extends Text_Input {
  Email_Input({
    required String name,
    bool? noNull,
    int? minLength,
    int? maxLength,
    bool showCounter = false,
    String? placeholder,
    String? input,
    void Function(dynamic, dynamic)? onValueChanged,
  }) : super(
          name: name,
          noNull: noNull,
          minLength: minLength,
          maxLength: maxLength,
          pattern:
              r"^[\w\.\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z]{2,}$",
          placeholder: placeholder,
          input: input,
          showCounter: showCounter,
          onValueChanged: onValueChanged,
        );

  @override
  String? validate(context) {
    final old = value;
    value = input?.trim();
    notifyValueChanged(old, value);

    if (value != null && value!.isNotEmpty) {
      final regex = RegExp(r"^[\w\.\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z]{2,}$");
      if (!regex.hasMatch(value!)) {
        return ValidatorError.get(context,"email", {"field": name});
      }
    }

    return ConditionChecker.check(
      context:context,
      fieldName: name,
      value: value,
      noNull: noNull,
      minLength: minLength,
      maxLength: maxLength,
    );
  }

}


/// ---------- DropdownValidator ----------
class Dropdown_Input extends ValidatorField {
  String? value;
  final bool? noNull;
  final List<String> values;

  Dropdown_Input({
    required String name,
    this.noNull,
    required this.values,
    String? placeholder,
    String? input,
    void Function(dynamic, dynamic)? onValueChanged,
  }) : super(
          name,
          input: input,
          placeholder: placeholder,
          onValueChanged: onValueChanged,
        ) {
    value = input;
  }

  void setValue(String newValue) {
    final old = value;
    value = newValue;
    input = newValue;
    notifyValueChanged(old, value);
  }

  @override
  String? validate(context) {
    if (noNull == true && (value == null || value!.isEmpty)) {
      return ValidatorError.get(context, "dropdownEmpty", {"field": name});
    }
    if (value != null && !values.contains(value)) {
      return ValidatorError.get(context, "dropdownInvalid", {"field": name});
    }
    return null;
  }
}

/// ---------- RadioValidator ----------
class Radio_Input extends ValidatorField {
  String? value;
  final bool? noNull;
  final List<String> values;

  Radio_Input({
    required String name,
    this.noNull,
    required this.values,
    String? placeholder,
    String? input,
    void Function(dynamic, dynamic)? onValueChanged,
  }) : super(
          name,
          input: input,
          placeholder: placeholder,
          onValueChanged: onValueChanged,
        ) {
    value = input;
  }

  void selectValue(String newValue) {
    final old = value;
    value = newValue;
    input = newValue;
    notifyValueChanged(old, value);
  }

  @override
  String? validate(context) {
    if (noNull == true && (value == null || value!.isEmpty)) {
      return ValidatorError.get(context,"radioEmpty", {"field": name});
    }
    if (value != null && !values.contains(value)) {
      return ValidatorError.get(context,"radioInvalid", {"field": name});
    }
    return null;
  }
}


/// ---------- Date Input ----------
class Date_Input extends ValidatorField {
  DateTime? value;
  final bool? noNull;
  final DateTime? minDate;
  final DateTime? maxDate;

  Date_Input({
    required String name,
    this.noNull,
    this.minDate,
    this.maxDate,
    DateTime? input,
    void Function(dynamic, dynamic)? onValueChanged,
  }) : super(
          name,
          input: input != null ? "${input.toLocal()}".split(' ')[0] : null,
          onValueChanged: onValueChanged,
        ) {
    value = input;
  }

  void setDate(DateTime newDate) {
    final old = value;
    value = newDate;
    input = "${value!.toLocal()}".split(' ')[0];
    notifyValueChanged(old, value);
  }

  @override
  String? validate(context) {
    if (noNull == true && value == null) {
      return ValidatorError.get(context,"dateEmpty", {"field": name});
    }
    if (minDate != null && value != null && value!.isBefore(minDate!)) {
      return ValidatorError.get(context,"dateTooEarly", {"field": name,"min": "${minDate!.toLocal()}".split(" ")[0]});
    }
    if (maxDate != null && value != null && value!.isAfter(maxDate!)) {
      return ValidatorError.get(context,"dateTooLate", {"field": name,"max": "${maxDate!.toLocal()}".split(" ")[0]});
    }
    return null;
  }
}


/// ---------- Time Input ----------
class Time_Input extends ValidatorField {
  TimeOfDay? value;
  final bool? noNull;
  final TimeOfDay? minTime;
  final TimeOfDay? maxTime;

  Time_Input({
    required String name,
    this.noNull,
    this.minTime,
    this.maxTime,
    TimeOfDay? input,
    String? placeholder,
    void Function(dynamic, dynamic)? onValueChanged,
  }) : super(
          name,
          input: input != null ? _formatTime(input) : null,
          placeholder: placeholder,
          onValueChanged: onValueChanged,
        ) {
    value = input;
  }

  void setTime(TimeOfDay newTime, BuildContext context) {
    final old = value;
    value = newTime;
    input = _formatTime(value!, context);
    notifyValueChanged(old, value);
  }

  static String _formatTime(TimeOfDay time, [BuildContext? context]) {
    if (context != null) return time.format(context);
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

 @override
  String? validate(context) {
    if (noNull == true && value == null) {
      return ValidatorError.get(context,"timeEmpty", {"field": name});
    }

    if (value != null) {
      final totalMinutes = value!.hour * 60 + value!.minute;

      if (minTime != null) {
        final minMinutes = minTime!.hour * 60 + minTime!.minute;
        if (totalMinutes < minMinutes) {
          return ValidatorError.get(context,"timeTooEarly", {"field": name,"min": _formatTime(minTime!)});
        }
      }

      if (maxTime != null) {
        final maxMinutes = maxTime!.hour * 60 + maxTime!.minute;
        if (totalMinutes > maxMinutes) {
          return ValidatorError.get(context,"timeTooLate", {"field": name, "max": _formatTime(maxTime!)});
        }
      }
    }
    return null;
  }
}

/// ---------- Phone Input ----------
class Phone_Input extends ValidatorField {
  final bool? noNull;
  final int? minLength;
  final int? maxLength;

  Phone_Input({
    required String name,
    this.noNull,
    this.minLength,
    this.maxLength,
    String? input,
    void Function(dynamic, dynamic)? onValueChanged,
    String? placeholder,
  }) : super(
          name,
          input: input,
          placeholder: placeholder ?? 'Ingrese número de teléfono',
          onValueChanged: onValueChanged,
        );

  @override
  String? validate(context) {
    if (noNull == true && (input == null || input!.isEmpty)) {
      return ValidatorError.get(context, "required", {"field": name});
    }
    if (minLength != null && (input?.length ?? 0) < minLength!) {
      return ValidatorError.get(context, "minLength", {"field": name});
    }
    if (maxLength != null && (input?.length ?? 0) > maxLength!) {
      return ValidatorError.get(context, "maxLength", {"field": name});
    }

    final pattern = RegExp(r'^[0-9 +()-]*$');
    if (input != null && !pattern.hasMatch(input!)) {
      return ValidatorError.get(context,"invalidFormat", {"field": name});
    }
    return null;
  }
}

class Checkbox_Input extends ValidatorField {
  bool value;
  final bool? noNull;

  Checkbox_Input({
    required String name,
    this.noNull,
    bool initialValue = false,
    String? placeholder,
    String? input,
    void Function(dynamic, dynamic)? onValueChanged,
  })  : value = initialValue,
        super(
          name,
          input: input ?? initialValue.toString(),
          placeholder: placeholder,
          onValueChanged: onValueChanged,
        );

  void toggle() {
    final old = value;
    value = !value;
    input = value.toString();
    notifyValueChanged(old, value);
  }

  @override
  String? validate(context) {
    if (noNull == true && !value) {
      return ValidatorError.get(context, "checkboxEmpty", {"field": name});
    }
    return null;
  }
}

class Checkbox_Multi_Input extends ValidatorField {
  List<String> values;  
  List<String> selected; 
  final bool? noNull;

  Checkbox_Multi_Input({
    required String name,
    required this.values,
    List<String>? initialValue,
    this.noNull,
    String? placeholder,
    String? input,
    void Function(dynamic, dynamic)? onValueChanged,
  })  : selected = initialValue ?? [],
        super(
          name,
          input: input ?? (initialValue?.join(", ") ?? ""),
          placeholder: placeholder,
          onValueChanged: onValueChanged,
        );

  void toggle(String option) {
    final old = List<String>.from(selected);
    if (selected.contains(option)) {
      selected.remove(option);
    } else {
      selected.add(option);
    }
    input = selected.join(", "); 
    notifyValueChanged(old, selected);
  }

 @override
String? validate(context) {   
    if (noNull == true && selected.isEmpty) {
    final error = ValidatorError.get(context,"multiCheckboxEmpty", {"field": name});
    return error;
  }
  return null;
}

  void selectAll() {
    final old = List<String>.from(selected);
    selected = List<String>.from(values);
    input = selected.join(", ");
    notifyValueChanged(old, selected);
  }

  void clearAll() {
    final old = List<String>.from(selected);
    selected.clear();
    input = "";
    notifyValueChanged(old, selected);
  }
}



/// ---------- FileValidator ----------
class File_Input extends ValidatorField {
  List<File> files;
  final bool? noNull;
  final int? minLength, maxLength;
  final List<String>? allowedExtensions;
  final int maxFiles;
  final double? maxFileSizeMB;

  File_Input({
    required String name,
    this.noNull,
    this.minLength,
    this.maxLength,
    List<File>? files,
    this.allowedExtensions,
    this.maxFiles = 1,
    this.maxFileSizeMB,
    String? placeholder,
  })  : files = files ?? [],
        super(name, placeholder: placeholder);

  void addFile(File file) {
    if (files.length >= maxFiles) return;
    files.add(file);
  }

  void removeFile(File file) {
    files.remove(file);
  }

  @override
  String? validate(context) {
    if (noNull == true && files.isEmpty) {
      return ValidatorError.get(context, "fileEmpty", {"field": name});
    }

    if (files.length > maxFiles) {
      return ValidatorError.get(context, "fileTooMany", {"field": name,"maxFiles": maxFiles.toString()});
    }

    for (var f in files) {
      if (allowedExtensions != null &&
          !allowedExtensions!.any(
            (ext) => f.path.toLowerCase().endsWith(ext.toLowerCase()),
          )) {
        return ValidatorError.get(context, "fileInvalidExtension", {"field": name,"file": f.path });
      }

      if (maxFileSizeMB != null) {
        final sizeInMB = f.lengthSync() / (1024 * 1024);
        if (sizeInMB > maxFileSizeMB!) {
          return ValidatorError.get(context, "fileTooLarge", {"field": name,"file": f.path,"maxSize": maxFileSizeMB.toString()});
        }
      }
    }

    return ConditionChecker.check(
      context:context,
      fieldName: name,
      value: files,
      noNull: noNull,
      minLength: minLength,
      maxLength: maxLength,
    );
  }
}
