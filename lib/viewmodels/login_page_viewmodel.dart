import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/db_helper.dart';
import '../models/user.dart';
import '../views/home/home_screen.dart';
import '../views/main/main_screen.dart';

class LoginPageViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoginTrue = false;
  final db = DatabaseHelper();


  notifyListeners();

  showLoginDialog(
      {required context, AlertDialog Function(BuildContext context)? builder}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text(
            'Login information is incorrect',
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



  Future<void> _saveUserId(int? userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userId != null) {
      await prefs.setInt('user_id', userId);
      notifyListeners();
    }
  }

  Future<bool> login(BuildContext context) async {
    User? usrDetails = await db.getUser(emailController.text);
    var res = await db.authenticate(
      User(email: emailController.text, password: passwordController.text),
    );
    if (res == true) {
      await _saveUserId(usrDetails!.id);
      emailController.clear();
      passwordController.clear();
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

}
