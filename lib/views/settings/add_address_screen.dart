import 'package:ecommerce_app/widgets/appbar_back_button.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/db_helper.dart';
import '../../models/address.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  const AddAddressScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  TextEditingController streetAddressController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController zipCodeController = new TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  @override
  void dispose() {
    streetAddressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    super.dispose();
  }
  void _saveAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    final streetAddress = streetAddressController.text;
    final city = cityController.text;
    final state = stateController.text;
    final zipCode = zipCodeController.text;

    if (streetAddress.isNotEmpty &&
        city.isNotEmpty &&
        state.isNotEmpty &&
        zipCode.isNotEmpty) {
      final address = Address(
        id: 0, // 0 for auto increment
        streetAddress: streetAddress,
        city: city,
        state: state,
        zipCode: zipCode, userId: userId!,
      );

      await _databaseHelper.addAddress(address);
      Navigator.pop(context); // Navigate back to the previous screen
    } else {
      // Optionally, show an error message or handle validation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
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
              controller: streetAddressController,
              text: Text('Street Address'),
            ),
            SizedBox(
              height: 15.sp,
            ),
            CustomTextfield(
              controller: cityController,
              text: Text('City'),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextfield(
                  width: 161.sp,
                  height: 56.sp,
                  controller: stateController,
                  text: Text('State'),
                ),
                SizedBox(
                  width: 23.sp,
                ),
                CustomTextfield(
                  width: 161.sp,
                  height: 56.sp,
                  controller: zipCodeController,
                  text: Text('Zip Code'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: CustomButton(
          text: 'Save',
          onPressed: _saveAddress,
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
