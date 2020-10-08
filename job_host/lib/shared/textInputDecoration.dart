import 'package:flutter/material.dart';

textInputDecoration({
  bool fieldStatus,
  String fieldMessage,
  bool isChanged,
  @required String labelText,
  String hintText,
  String helperText,
  String prefixText,
  IconData prefixIcon,
}) {
  return InputDecoration(
    labelText: labelText,
    errorText: fieldStatus == false ? fieldMessage : null,
    errorStyle: TextStyle(
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: 7,
    hintText: hintText != null ? hintText : null,
    helperText: helperText != null ? helperText : null,
    prefixText: prefixText != null ? prefixText : null,
    prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
    suffixText: null,
    suffixIcon: isChanged == true
        ? Icon(
            fieldStatus == true ? Icons.check_circle : Icons.error,
            color: fieldStatus == true ? Colors.green : Colors.red,
          )
        : null,
    suffixStyle: TextStyle(color: Colors.blue),
    border: OutlineInputBorder(),
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue,
        width: 0.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green,
        width: 0.0,
      ),
    ),
  );
}
