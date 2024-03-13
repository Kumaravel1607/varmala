import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T value;
  final String getLabel;
  // final void Function(T) onChanged;

  AppDropdownInput(
    String s,
    List astro_stauts, {
    this.hintText = 'Please select an Option',
    this.options = const [],
    required this.getLabel,
    required this.value,
    // required this.onChanged,
  });

  @override
  void initState() {
    print(options);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            // labelStyle: textStyle,
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
            hintText: hintText,
            labelText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              onChanged: (value) {},
              items: options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(getLabel),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
