import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterTextField extends StatefulWidget {
  TextInputType textInputType;
  TextEditingController controller;
  Function(String) onChanged;
  String labelText;
  Icon prefixIcon;

  FilterTextField({
    required this.controller,
    required this.onChanged,
    required this.labelText,
    required this.prefixIcon,
    required this.textInputType,
  });

  @override
  State<FilterTextField> createState() => _FilterTextFieldState();
}

class _FilterTextFieldState extends State<FilterTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        contentPadding: EdgeInsets.symmetric(vertical: 5.sp),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Color.fromARGB(255, 244, 244, 244),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        prefixIcon: widget.prefixIcon,
      ),
      keyboardType: widget.textInputType,
      onChanged: widget.onChanged,

    );
  }
}
