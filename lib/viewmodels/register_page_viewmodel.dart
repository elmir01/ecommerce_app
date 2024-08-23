

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


  notifyListeners();
  final db = DatabaseHelper();
  signUp(BuildContext context)async{
    var res = await db.createUser(User(firstName: firstNameController.text,email: emailController.text,lastName: lastNameController.text, password: passwordController.text));
    if(res>0){
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      passwordController.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
      notifyListeners();
    }
  }
}