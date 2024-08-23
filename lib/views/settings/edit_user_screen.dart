import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/db_helper.dart';
import '../../models/user.dart';
import '../../widgets/appbar_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class EditUserScreen extends ConsumerStatefulWidget {
User user;
   EditUserScreen({super.key,required this.user});

  @override
  ConsumerState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends ConsumerState<EditUserScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    final user = widget.user;
    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);
    emailController = TextEditingController(text: user.email);
    passwordController = TextEditingController(text: user.password);
  }
  void _updateAddress() async {

    final updatedAddress = User(
      id: widget.user.id,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    await _databaseHelper.updateUser(updatedAddress);

    Navigator.pop(context,true); // geri qayıdın
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: AppBarBackButton(),
      ),
      body: IntrinsicWidth(
        stepWidth: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 30.sp,
            ),
            CustomTextfield(
              controller: firstNameController,
              text: Text('First Name'),
            ),
            SizedBox(
              height: 15.sp,
            ),
            CustomTextfield(
              controller: lastNameController,
              text: Text('Last Name'),
            ),
            SizedBox(
              height: 15.sp,
            ),
            CustomTextfield(
              controller: emailController,
              text: Text('E-mail'),
            ),
            SizedBox(
              height: 15.sp,
            ),
            CustomTextfield(
              controller: passwordController,
              text: Text('Password'),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: CustomButton(
          text: 'Edit',
          onPressed: _updateAddress,
          width: 342.sp,
          height: 52.sp,
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: CustomButton(
      //     text: 'Save',
      //     onPressed: () {},
      //     width: 342.sp,
      //     height: 52.sp,
      //   ),
      //
      // ),
    );
  }
}
