import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:  Color.fromARGB(255, 244, 244, 244),
        ),
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      onPressed: () {
        // Geri tuşuna basıldığında yapılacak işlem
        Navigator.of(context).pop();
      },
    );
  }
}
