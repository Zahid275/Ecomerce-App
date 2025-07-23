import 'package:flutter/material.dart';

Widget cusTomTextField(
    {required Function onChanged,
      required String label,
      required IconData prefixIcon,
      IconButton? suffixIcon,
      bool? obsText,

      bool obsecure =false }) {
  return SizedBox(
    width: 360,
    height: 47,
    child: TextField(
      onChanged: (value) {
        onChanged(value);
      },
      obscureText: obsecure,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
        hintText: label,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.deepPurple.shade300, width: 2),
            borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.deepPurple.shade300, width: 2),
            borderRadius: BorderRadius.circular(12)),
        disabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.deepPurple.shade300, width: 2),
            borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}