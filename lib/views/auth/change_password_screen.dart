import 'package:ecommerce_app/views/auth/login_screen.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_textfield.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntrinsicWidth(
        stepWidth: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.sp),
          child: Column(
            children: [
              SizedBox(
                height: 30.sp,
              ),
              Text(
                'Change Password',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30.sp,
              ),
              CustomTextfield(
                controller: passwordController,
                text: Text('Password'),
                obscureText: !_passwordVisible,
                iconButton: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: _passwordVisible
                      ? Icon(
                          Icons.visibility,
                        )
                      : Icon(
                          Icons.visibility_off,
                        ),
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              CustomTextfield(
                controller: confirmPasswordController,
                text: Text('Confirm Password'),
                obscureText: !_confirmPasswordVisible,
                iconButton: IconButton(
                  onPressed: () {
                    setState(() {
                      _confirmPasswordVisible = !_confirmPasswordVisible;
                    });
                  },
                  icon: _confirmPasswordVisible
                      ? Icon(
                          Icons.visibility,
                        )
                      : Icon(
                          Icons.visibility_off,
                        ),
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              CustomButton(
                text: 'Change',
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
