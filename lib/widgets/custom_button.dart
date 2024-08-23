import 'dart:ffi' as prefix;

import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  String text;
  double width;
  double height;
  ui.VoidCallback onPressed;


  CustomButton({
    required this.text,
    required this.onPressed,
    this.width=344,this.height = 49
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width.sp, height.sp),
        backgroundColor: Color.fromARGB(255, 142, 108, 239),
      ),
    );
  }
}
