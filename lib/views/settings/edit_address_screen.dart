import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/address.dart';
import '../../widgets/appbar_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../data/db_helper.dart';

class EditAddressScreen extends ConsumerStatefulWidget {
  final Address address;

  const EditAddressScreen({super.key, required this.address});

  @override
  ConsumerState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends ConsumerState<EditAddressScreen> {
  late TextEditingController streetAddressController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController zipCodeController;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    final address = widget.address;
    streetAddressController = TextEditingController(text: address.streetAddress);
    cityController = TextEditingController(text: address.city);
    stateController = TextEditingController(text: address.state);
    zipCodeController = TextEditingController(text: address.zipCode);
  }

  void _updateAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    final updatedAddress = Address(
      id: widget.address.id,
      streetAddress: streetAddressController.text,
      city: cityController.text,
      state: stateController.text,
      zipCode: zipCodeController.text, userId: userId!,
    );

    await _dbHelper.updateAddress(updatedAddress);

    Navigator.pop(context,true); // geri qayıdın
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: AppBarBackButton(),
      ),
      body: Column(
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
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: CustomButton(
          text: 'Edit',
          onPressed: _updateAddress,
          width: 342.sp,
          height: 52.sp,
        ),
      ),
    );
  }
}
