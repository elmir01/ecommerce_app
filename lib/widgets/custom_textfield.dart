import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfield extends StatelessWidget {
  TextEditingController controller;
  IconButton? iconButton;
  bool obscureText;
  double width;
  double height;
  Text text;

   CustomTextfield({required this.controller,required this.text,this.iconButton,this.obscureText=false,this.width=345,this.height=56});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: width.sp,
      height: height.sp,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 244, 244, 244),
          label: text,
          suffixIcon: iconButton,
          labelStyle: TextStyle(fontSize: 16.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.sp)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
