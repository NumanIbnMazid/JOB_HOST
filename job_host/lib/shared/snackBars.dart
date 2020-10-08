import 'package:flutter/material.dart';

Widget errorSnackBar({int duration, String errorText}) {
  return SnackBar(
    duration: Duration(seconds: duration != null ? duration : 7),
    content: SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Please fix the error(s) below : ",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(errorText != null ? '$errorText' : 'Error'),
        ],
      ),
    ),
    backgroundColor: Colors.red,
  );
}
