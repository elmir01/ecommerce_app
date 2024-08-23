import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'change_password_screen.dart';

class ForgotPasswordResultScreen extends ConsumerStatefulWidget {
  const ForgotPasswordResultScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordResultScreenState();
}

class _ForgotPasswordResultScreenState
    extends ConsumerState<ForgotPasswordResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntrinsicWidth(
          stepWidth: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image 4.png',
                ),
                SizedBox(
                  height: 25.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.sp),
                  child: Text(
                    'We Sent you an Email to reset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.sp,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   CupertinoPageRoute(
                    //     builder: (context) => ChangePasswordScreen(),
                    //   ),
                    // );
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ChangePasswordScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 13.sp,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(159.sp, 52.sp),
                    backgroundColor: Color.fromARGB(255, 142, 108, 239),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
