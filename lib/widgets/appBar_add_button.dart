import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarAddButton extends StatefulWidget {
  VoidCallback onPressed;
   AppBarAddButton({required this.onPressed});

  @override
  State<AppBarAddButton> createState() => _AppBarAddButtonState();
}

class _AppBarAddButtonState extends State<AppBarAddButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(
              255, 244, 244, 244), // Dairenin arkaplan rengi
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
