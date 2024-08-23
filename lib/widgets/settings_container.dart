import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsContainer extends StatefulWidget {
  double width;
  double height;
  Widget child;
   SettingsContainer({required this.width,required this.height,required this.child,});

  @override
  State<SettingsContainer> createState() => _SettingsContainerState();
}

class _SettingsContainerState extends State<SettingsContainer> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 244, 244, 244),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: widget.child,
    );
  }
}
