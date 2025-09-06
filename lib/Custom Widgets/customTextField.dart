import 'package:flutter/material.dart';



class CustomTextfield extends StatelessWidget {
  final label;
  final IconData prefixIcon;
  final IconButton? suffixIcon;
  final bool? obsText;
  final obsecure;
  void Function(String) onChanged;

   CustomTextfield( {super.key, 
    required  this.onChanged,
    required  this.label,
    required  this.prefixIcon,
    this.suffixIcon,
    this.obsText,

     this.obsecure =false });


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: height*0.069,
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
}


