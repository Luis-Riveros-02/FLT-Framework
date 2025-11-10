import 'package:flutter/material.dart';
import 'validators.dart';
import '../../Internals/logic_provider.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class StyleForms {
  static Widget textInput({
    required BuildContext context,
    required ValidatorField field,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    InputDecoration? decoration,
    required String? error,
    TextStyle? textStyle,
    TextStyle? placeholderStyle,
    TextStyle? errorStyle,
    EdgeInsetsGeometry padding = const EdgeInsets.only(bottom: 16),
    bool showLabel = true,
  }) {
    final focusNode = FocusNode();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        if (field is Number_Field) {
          field.evaluateFinal();
          controller.text = field.value?.toString() ?? '';
        } else if (field is Float_Field) {
          field.evaluateFinal();
          controller.text = field.value?.toString() ?? '';
        } else if (field is Text_Input) {
          field.liveEvaluate();
        }
      }
    });

    // Función auxiliar para construir inputs con error
    Widget buildInputWithError(Widget inputWidget) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          inputWidget,
          if (error != null && error!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                error!,
                style: errorStyle,
              ),
            ),
        ],
      );
    }

    // ========== NUMBER FIELD ==========
    if (field is Number_Field) {
      return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              style: textStyle,
              decoration: decoration?.copyWith(
                    labelText: showLabel ? field.name : null,
                    hintText: field.placeholder,
                    hintStyle: placeholderStyle,
                  ) ??
                  InputDecoration(
                    labelText: showLabel ? field.name : null,
                    hintText: field.placeholder ?? '',
                    hintStyle: placeholderStyle,
                  ),
              onChanged: (text) {
                field.input = text;
                field.liveSanitize();
                controller.text = field.input ?? '';
                controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length),
                );
              },
            ),
            if (error != null && error!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  error!,
                  style: errorStyle,
                ),
              ),
          ],
        ),
      );
    }

    // ========== FLOAT FIELD ==========
    if (field is Float_Field) {
      return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: textStyle,
              decoration: decoration?.copyWith(
                    labelText: showLabel ? field.name : null,
                    hintText: field.placeholder,
                    hintStyle: placeholderStyle,
                  ) ??
                  InputDecoration(
                    labelText: showLabel ? field.name : null,
                    hintText: field.placeholder ?? '',
                    hintStyle: placeholderStyle,
                  ),
              onChanged: (text) {
                field.input = text;
                field.liveSanitize();
                controller.text = field.input ?? '';
                controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length),
                );
              },
            ),
            if (error != null && error!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  error!,
                  style: errorStyle,
                ),
              ),
          ],
        ),
      );
    }

    // ========== TEXT INPUT ==========
    if (field is Text_Input) {
      return buildInputWithError(
        Padding(
          padding: padding,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            style: textStyle,
            maxLength: field.maxLength,
            decoration: decoration?.copyWith(
                  labelText: showLabel ? field.name : null,
                  hintText: field.placeholder,
                  hintStyle: placeholderStyle,
                ) ??
                InputDecoration(
                  labelText: showLabel ? field.name : null,
                  hintText: field.placeholder ?? '',
                  hintStyle: placeholderStyle,
                ),
            buildCounter: (context, {required currentLength, maxLength, required isFocused}) {
              if (field.showCounter && maxLength != null) {
                return Text(
                  "$currentLength/$maxLength",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                );
              }
              return null;
            },
            onChanged: (text) {
              field.input = text;
              field.liveEvaluate();
            },
          ),
        ),
      );
    }

    // ========== PASSWORD INPUT ==========
    if (field is Password_Input) {
      return StatefulBuilder(builder: (contextSB, setState) {
        return Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: TextInputType.text,
                style: textStyle,
                obscureText: field.obscure,
                maxLength: (field.showCounter && field.maxLength != null)
                    ? field.maxLength
                    : null,
                decoration: (decoration?.copyWith(
                      labelText: showLabel ? field.name : null,
                      hintText: field.placeholder,
                      hintStyle: placeholderStyle,
                      counterText: (field.showCounter && field.maxLength != null)
                          ? "${controller.text.length}/${field.maxLength}"
                          : "",
                      suffixIcon: IconButton(
                        icon: Icon(
                          field.obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            field.obscure = !field.obscure;
                          });
                        },
                      ),
                    )) ??
                    InputDecoration(
                      labelText: showLabel ? field.name : null,
                      hintText: field.placeholder ?? '',
                      hintStyle: placeholderStyle,
                    ),
                onChanged: (text) {
                  field.input = text;
                  field.liveEvaluate();
                  setState(() {});
                },
              ),
              const SizedBox(height: 8),
              FlutterPasswordStrength(
                password: controller.text,
                strengthCallback: (strength) {
                  debugPrint("Password strength: $strength");
                },
              ),
              if (error != null && error!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    error!,
                    style: errorStyle,
                  ),
                ),
            ],
          ),
        );
      });
    }

    // ========== DROPDOWN INPUT ==========
    if (field is Dropdown_Input) {
      return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: field.value,
              decoration: InputDecoration(
                labelText: showLabel ? field.name : null,
                hintText: field.placeholder,
              ),
              items: field.values
                  .map((v) => DropdownMenuItem<String>(
                        value: v,
                        child: Text(v, style: textStyle),
                      ))
                  .toList(),
              onChanged: (val) {
                field.input = val;
                controller.text = val ?? '';
              },
            ),
            if (error != null && error!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  error!,
                  style: errorStyle,
                ),
              ),
          ],
        ),
      );
    }

    // ========== RADIO INPUT ==========
    if (field is Radio_Input) {
      return StatefulBuilder(
        builder: (contextSB, setState) {
          return Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showLabel) Text(field.name, style: textStyle),
                ...field.values.map((v) {
                  return RadioListTile<String>(
                    title: Text(v, style: textStyle),
                    value: v,
                    groupValue: field.value,
                    onChanged: (val) {
                      setState(() {
                        field.value = val;
                        field.input = val;
                        controller.text = val ?? '';
                      });
                    },
                  );
                }).toList(),
                if (error != null && error!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      error!,
                      style: errorStyle,
                    ),
                  ),
              ],
            ),
          );
        },
      );
    }

    // ========== DATE INPUT ==========
    if (field is Date_Input) {
      return StatefulBuilder(builder: (contextSB, setState) {
        return Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: showLabel ? field.name : null,
                  hintText: field.placeholder,
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: field.value ?? DateTime.now(),
                    firstDate: field.minDate ?? DateTime(1900),
                    lastDate: field.maxDate ?? DateTime(2100),
                  );
                  if (picked != null) {
                    field.setDate(picked);
                    controller.text = field.input ?? '';
                    setState(() {});
                  }
                },
              ),
              if (error != null && error!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    error!,
                    style: errorStyle,
                  ),
                ),
            ],
          ),
        );
      });
    }

    // ========== TIME INPUT ==========
    if (field is Time_Input) {
      return StatefulBuilder(builder: (contextSB, setState) {
        return Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: showLabel ? field.name : null,
                  hintText: field.placeholder,
                  suffixIcon: const Icon(Icons.access_time),
                ),
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: field.value ?? TimeOfDay.now(),
                  );
                  if (picked != null) {
                    field.setTime(picked, context);
                    controller.text = field.input ?? '';
                    setState(() {});
                  }
                },
              ),
              if (error != null && error!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    error!,
                    style: errorStyle,
                  ),
                ),
            ],
          ),
        );
      });
    }

    // ========== PHONE INPUT ==========
    if (field is Phone_Input) {
      PhoneNumber? initialPhone;
      if (field.input != null) {
        try {
          initialPhone = PhoneNumber.parse(field.input!);
        } catch (e) {
          initialPhone = null;
        }
      }

      return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhoneFormField(
              decoration: InputDecoration(
                labelText: showLabel ? field.name : null,
                hintText: field.placeholder,
              ),
              initialValue: initialPhone,
              onChanged: (phone) {
                field.input = phone?.international;
              },
              validator: (phone) {
                return field.validate(context);
              },
            ),
            if (error != null && error!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  error!,
                  style: errorStyle,
                ),
              ),
          ],
        ),
      );
    }

    // ========== CHECKBOX INPUT ==========
    if (field is Checkbox_Input) {
      return StatefulBuilder(
        builder: (contextSB, setState) {
          return Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: field.value,
                      onChanged: (val) {
                        final old = field.value;
                        setState(() {
                          field.value = val ?? false;
                          field.input = field.value.toString();
                          controller.text = field.input!;
                        });
                        field.onValueChanged?.call(old, field.value);
                      },
                    ),
                    if (showLabel) Text(field.name, style: textStyle),
                  ],
                ),
                if (error != null && error!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 40.0),
                    child: Text(
                      error!,
                      style: errorStyle,
                    ),
                  ),
              ],
            ),
          );
        },
      );
    }

    // ========== CHECKBOX MULTI INPUT ==========
  if (field is Checkbox_Multi_Input) {
    return StatefulBuilder(
      builder: (contextSB, setState) {
        return Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showLabel) Text(field.name, style: textStyle),
              ...field.values.map((v) {
                final checked = field.selected.contains(v);
                return CheckboxListTile(
                  title: Text(v, style: textStyle),
                  value: checked,
                  onChanged: (val) {
                    final old = List<String>.from(field.selected);
                    setState(() {
                      if (val == true) {
                        if (!field.selected.contains(v)) {
                          field.selected.add(v);
                        }
                      } else {
                        field.selected.remove(v);
                      }
                      field.input = field.selected.join(", ");
                      controller.text = field.input!; // ✅ ESTA LÍNEA ESTÁ BIEN
                    });
                    field.onValueChanged?.call(old, List<String>.from(field.selected));
                  },
                );
              }).toList(),
              if (error != null && error!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    error!,
                    style: errorStyle,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

    // ========== TEXTAREA INPUT ==========
    if (field is TextArea_Input) {
      return buildInputWithError(
        Padding(
          padding: padding,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: field.heightScale,
            style: textStyle,
            maxLength: field.maxLength,
            decoration: decoration?.copyWith(
                  labelText: showLabel ? field.name : null,
                  hintText: field.placeholder,
                  hintStyle: placeholderStyle,
                  counterText: field.showCounter && field.maxLength != null
                      ? "${controller.text.length}/${field.maxLength}"
                      : null,
                ) ??
                InputDecoration(
                  labelText: showLabel ? field.name : null,
                  hintText: field.placeholder ?? '',
                  hintStyle: placeholderStyle,
                ),
            onChanged: (text) {
              field.input = text;
              field.liveEvaluate();
            },
          ),
        ),
      );
    }

    // ========== FILE INPUT ==========
    if (field is File_Input) {
      return StatefulBuilder(builder: (contextSB, setState) {
        return Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showLabel) Text(field.name, style: textStyle),
              const SizedBox(height: 4),
              ElevatedButton.icon(
                icon: const Icon(Icons.attach_file),
                label: Text(field.placeholder ?? ''),
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                    type: FileType.custom,
                    allowedExtensions: field.allowedExtensions,
                  );

                  if (result != null) {
                    for (var file in result.files) {
                      final f = File(file.path!);
                      final tempField = File_Input(
                        name: field.name,
                        allowedExtensions: field.allowedExtensions,
                        maxFileSizeMB: field.maxFileSizeMB,
                        maxFiles: field.maxFiles,
                      );
                      tempField.addFile(f);
                      final error = tempField.validate(context);
                      if (error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error)),
                        );
                        continue;
                      }
                      if (field.files.length >= field.maxFiles) break;
                      field.addFile(f);
                    }
                    setState(() {});
                  }
                },
              ),
              const SizedBox(height: 8),
              Column(
                children: field.files
                    .map((f) => ListTile(
                          title: Text(f.path.split('/').last),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              field.removeFile(f);
                              setState(() {});
                            },
                          ),
                        ))
                    .toList(),
              ),
              if (error != null && error!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    error!,
                    style: errorStyle,
                  ),
                ),
            ],
          ),
        );
      });
    }

    // ========== CASO GENÉRICO ==========
    return buildInputWithError(
      Padding(
        padding: padding,
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: textStyle,
          decoration: decoration?.copyWith(
                labelText: showLabel ? field.name : null,
                hintText: field.placeholder,
                hintStyle: placeholderStyle,
              ) ??
              InputDecoration(
                labelText: showLabel ? field.name : null,
                hintText: field.placeholder ?? '',
                hintStyle: placeholderStyle,
              ),
          onChanged: (text) {
            field.input = text;
            if (field is NumericField) {
              field.liveSanitize();
            }
          },
        ),
      ),
    );
  }

  static Widget submitButton({
    required String label,
    required VoidCallback onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.only(bottom: 16),
    ButtonStyle? style,
    TextStyle? textStyle,
  }) =>
      Padding(
        padding: padding,
        child: ElevatedButton(
          onPressed: onPressed, 
          style: style, 
          child: Text(label, style: textStyle)
        ),
      );

  static Widget errorMessages(Map<String, String> errors, {TextStyle? textStyle, EdgeInsetsGeometry padding = const EdgeInsets.only(bottom: 4)}) {
    final generalErrors = errors.values.where((error) => error.isNotEmpty).toList();
    if (generalErrors.isEmpty) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: generalErrors.map((e) => Padding(padding: padding, child: Text(e, style: textStyle ?? const TextStyle(color: Colors.red)))).toList(),
    );
  }

  static List<Widget> _buildFieldGrid(
    List<ValidatorField> fields, 
    Widget Function(ValidatorField) buildField, 
    int columnsCount
  ) {
    final List<Widget> rows = [];
    
    for (int i = 0; i < fields.length; i += columnsCount) {
      final rowFields = fields.sublist(
        i, 
        i + columnsCount > fields.length ? fields.length : i + columnsCount
      );
      
      final rowChildren = rowFields.map(buildField).toList();
      
      // ✅ COMPLETAR FILA CON CAMPOS VACÍOS SI ES NECESARIO
      while (rowChildren.length < columnsCount) {
        rowChildren.add(const SizedBox.shrink());
      }
      
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, // ✅ ALINEACIÓN SUPERIOR
          children: rowChildren.asMap().entries.map((entry) {
            final index = entry.key;
            final widget = entry.value;
            
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < columnsCount - 1 ? 8.0 : 0.0, // ✅ ESPACIO DERECHO, EXCEPTO ÚLTIMO
                ),
                child: widget,
              ),
            );
          }).toList(),
        )
      );
      
      // ✅ ESPACIO ENTRE FILAS (excepto después de la última)
      if (i + columnsCount < fields.length) {
        rows.add(const SizedBox(height: 8.0));
      }
    }
    
    return rows;
  }

  static Widget renderForm({
    required BuildContext context,
    required List<ValidatorField> fields,
    required Map<String, TextEditingController> controllers,
    required Map<String, String> errors,
    required VoidCallback onSubmit,
    dynamic visualForm,
    String? title,
    bool showLabels = true,
    int columnsInputs = 1,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        // ✅ FILTRAR CAMPOS VÁLIDOS
        final validFields = fields.where((field) =>
          field is Number_Field || field is Float_Field || field is Text_Input || 
          field is Date_Input || field is Time_Input || field is Phone_Input || 
          field is Password_Input || field is Dropdown_Input || field is Radio_Input || 
          field is TextArea_Input || field is Checkbox_Input || field is Checkbox_Multi_Input || 
          field is File_Input
        ).toList();

        // ✅ FUNCIÓN PARA CONSTRUIR UN INPUT INDIVIDUAL
        Widget buildField(ValidatorField field) {
          return StyleForms.textInput(
            context: context,
            field: field,
            controller: controllers.putIfAbsent(
                field.name, () => TextEditingController(text: field.input ?? '')),
            keyboardType: (field is Number_Field || field is Float_Field)
                ? TextInputType.number
                : TextInputType.text,
            decoration: visualForm?.inputDecoration,
            error: errors[field.name],
            textStyle: visualForm?.inputTextStyle,
            errorStyle: visualForm?.textError,
            placeholderStyle: visualForm?.placeholderStyle,

            showLabel: showLabels,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  title, 
                  textAlign: TextAlign.center,
                  style: visualForm?.titleStyle ?? 
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                ),
              ),

            if (columnsInputs == 1) ...[
              ...validFields.map(buildField).toList(),
            ]
            else ...[
              ..._buildFieldGrid(validFields, buildField, columnsInputs),
            ],

 
            const SizedBox(height: 16),
            submitButton(
              label: "Submit", 
              onPressed: () {
                onSubmit();
                setState(() {});
              }, 
              style: visualForm?.buttonStyle, 
              textStyle: visualForm?.buttonTextStyle
            ),
          ],
        );
      },
    );
  }
}


abstract class BaseForm {
  List<ValidatorField> get fields;
  late final Map<String, TextEditingController> controllers;
  Map<String, String> errors = {};
  final dynamic visualForm;
  final String? formTitle;
  final bool showLabels;
  final int columnsInputs;

  BaseForm({
    this.visualForm,
    this.formTitle,
    this.showLabels = true,
    this.columnsInputs = 1,
  }) {
    controllers = {
      for (var f in fields)
        if (f is Number_Field || f is Float_Field || f is Text_Input)
          f.name: TextEditingController(text: f.input ?? '')
    };
  }

  /// 🟡 Cambiamos: ahora recibe BuildContext
  bool submitValues(AppProvider app, BuildContext context) {
    errors.clear();

    for (var f in fields) {
      // Actualiza el input desde el controlador
      f.input = controllers[f.name]?.text;

      // ✅ Ahora validamos con context
      final err = f.validate(context);

      if (err != null) {
        errors[f.name] = err;
      } else {
        errors.remove(f.name);
      }

      // Sincroniza el valor limpio de nuevo al controlador
      if (f is Number_Field || f is Float_Field || f is Text_Input) {
        controllers[f.name]!.text = f.input ?? '';
      }
    }

    if (errors.isEmpty) {
      successfulEvent(app);
      return true;
    } else {
      errorEvent(app);
      return false;
    }
  }

  void successfulEvent(AppProvider app) {}
  void errorEvent(AppProvider app) {}

  Widget renderWithStyle(AppProvider app, BuildContext context) {
    return StyleForms.renderForm(
      context: context,
      fields: fields,
      controllers: controllers,
      errors: errors,
      // 👇 Pasamos el context aquí también
      onSubmit: () => submitValues(app, context),
      visualForm: visualForm,
      title: formTitle,
      showLabels: showLabels,
      columnsInputs: columnsInputs,
    );
  }
}
