import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/db_helper.dart';
import '../models/user.dart';
import '../views/auth/login_screen.dart';

class RegisterPageViewModel extends ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Enter email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }
  String? passwordValidator(value){
    if(value!.length<8){
      return 'Password must be at least 8 characters long';
    }
    return null;
  }


  showRegisterDialog(
      {required context,
       AlertDialog Function(BuildContext context)? builder}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text(
            'Username or password is incorrect',
          ),
          actions: <Widget>[

            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  notifyListeners();

  final db = DatabaseHelper();

  signUp(BuildContext context) async {
    var res = await db.createUser(User(
        firstName: firstNameController.text,
        email: emailController.text,
        lastName: lastNameController.text,
        password: passwordController.text));
    if (res > 0 &&
        emailController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      passwordController.clear();
      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
      Navigator.pop(context);
      notifyListeners();
    }
  }
}
