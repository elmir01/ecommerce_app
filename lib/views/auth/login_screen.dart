import 'dart:async';
import 'package:ecommerce_app/management/flutter_management.dart';
import 'package:ecommerce_app/views/auth/register_screen.dart';
import 'package:ecommerce_app/views/main/main_screen.dart';
import 'package:ecommerce_app/widgets/custom_textfield.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/db_helper.dart';
import '../../models/user.dart';

import '../../widgets/login_container.dart';
import '../home/home_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  var key = GlobalKey<FormState>();
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  bool _isDeviceSupported = false;
  bool _authenticated = false;
  String _authStatus = 'Not Authenticated';
  bool _passwordVisible = false;
  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      canCheckBiometrics = false;
    }
    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _checkDeviceSupport() async {
    bool isSupported;
    try {
      isSupported = await auth.isDeviceSupported();
    } catch (e) {
      isSupported = false;
    }
    setState(() {
      _isDeviceSupported = isSupported;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      print('Autentifikasiyaya başlanıldı');
      authenticated = await auth.authenticate(
        localizedReason: 'Biometrik autentifikasiya üçün barmaq izindən istifadə edin',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      print('Autentifikasiya nəticəsi: $authenticated');
    } catch (e) {
      print('Autentifikasiya zamanı xəta: $e');
      authenticated = false;
    }
    setState(() {
      _authenticated = authenticated;
      _authStatus = authenticated ? 'Authenticated' : 'Not Authenticated';
    });

    if (authenticated) {
      print('Autentifikasiya uğurlu oldu');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      print('Autentifikasiya uğursuz oldu');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
    _checkBiometrics();
    _checkDeviceSupport();
    print('_canCheckBiometrics: $_canCheckBiometrics');
    print('_isDeviceSupported: $_isDeviceSupported');
  }

  @override
  Widget build(BuildContext context) {
    // final themeNotifier = ref.watch(themeNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(

        actions: [],
      ),
      body: SingleChildScrollView(
        child: IntrinsicWidth(
          stepWidth: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.sp,
                ),
                Text(
                  'Sign in',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Form(
                    key: key,
                    child: Column(
                      children: [
                        CustomTextfield(
                            validator:
                            ref
                                .read(registerPageViewModel)
                                .emailValidator,
                            textInputType: TextInputType.emailAddress,
                            controller:
                            ref
                                .watch(loginPageViewModel)
                                .emailController,
                            text: Text('Email')),
                        SizedBox(
                          height: 8.sp,
                        ),
                        CustomTextfield(
                          validator:
                          ref
                              .read(registerPageViewModel)
                              .passwordValidator,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: !_passwordVisible,
                          controller:
                          ref
                              .watch(loginPageViewModel)
                              .passwordController,
                          text: Text('Password'),
                          iconButton: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: _passwordVisible
                                ? Icon(Icons.visibility)
                                : Icon(
                              Icons.visibility_off,
                            ),
                          ),
                        ),


                        SizedBox(
                          height: 8.sp,
                        ),
                        CustomButton(
                          text: 'Sign in',
                          onPressed: () async {
                            if (key.currentState!.validate()) {
                              final vm = ref.read(loginPageViewModel);
                              bool loginSuccess = await vm.login(context);
                              if (loginSuccess) {
                                if (_canCheckBiometrics && _isDeviceSupported) {
                                  await _authenticate();
                                }
                                if (_authenticated) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => MainScreen()),
                                  );
                                }
                              } else {
                                ref.read(loginPageViewModel).showLoginDialog(context: context);
                                print('Login məlumatları düzgün deyil');
                              }
                            }
                          },
                        ),

                        SizedBox(
                          height: 10.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Forgot password?',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Reset',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Or',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an Account?',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Create one',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: 30.sp,
                ),
                GestureDetector(
                  onTap: () {},
                  child: LoginContainer(
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.sp),
                          child: Image.asset('assets/apple.png'),
                        ),
                        SizedBox(
                          width: 70.sp,
                        ),
                        Text(
                          'Continue with Apple',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                GestureDetector(
                  onTap: () {},
                  child: LoginContainer(
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.sp),
                          child: Image.asset('assets/google.png'),
                        ),
                        SizedBox(
                          width: 60.sp,
                        ),
                        Text(
                          'Continue with Google',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                GestureDetector(
                  onTap: () {},
                  child: LoginContainer(
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.sp),
                          child: Image.asset('assets/facebook.png'),
                        ),
                        SizedBox(
                          width: 55.sp,
                        ),
                        Text(
                          'Continue with Facebook',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
