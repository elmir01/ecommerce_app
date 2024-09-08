import 'package:ecommerce_app/models/payment.dart';
import 'package:ecommerce_app/widgets/appbar_back_button.dart';
import 'package:ecommerce_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/db_helper.dart';
import '../../widgets/custom_button.dart';

class AddCardScreen extends ConsumerStatefulWidget {
  const AddCardScreen({super.key});

  @override
  ConsumerState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  var cardNumberController = new TextEditingController();
  var cvvController = new TextEditingController();
  var expController = new TextEditingController();
  var cardHolderNameController = new TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void dispose() {
    cardNumberController.dispose();
    cvvController.dispose();
    expController.dispose();
    cardHolderNameController.dispose();
    super.dispose();
  }


  void _savePayments() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('user_id');
      final cardNumber = cardNumberController.text;
      final cvv = cvvController.text;
      final exp = expController.text;
      final cardHolderName = cardHolderNameController.text;

      final payment = Payment(
        id: 0,
        cardNumber: cardNumber,
        cvv: int.parse(cvv),
        exp: exp,
        cardHolderName: cardHolderName,
        userId: userId!,
      );

      await _databaseHelper.addPayment(payment);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please correct the errors in the form')),
      );
    }
  }

  var _formKey = GlobalKey<FormState>();
  String? _validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter card number';
    } else if (value.length != 16) {
      return 'Card number must be 16 digits';
    }
    return null;
  }

  String? _validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter CVV';
    } else if (value.length != 3) {
      return 'CVV must be 3 digits';
    }
    return null;
  }

  String? _validateExp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter expiration date';
    } else if (!RegExp(r"^(0[1-9]|1[0-2])\/([0-9]{2})$").hasMatch(value)) {
      return 'Expiration date must be in MM/YY format';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        title: Text('Add Card'),
      ),
      body: IntrinsicWidth(
        stepWidth: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 25.sp,
            ),
            Form(
              key: _formKey,
                child: Column(
              children: [
                CustomTextfield(
                  validator: _validateCardNumber,
                  controller: cardNumberController,
                  text: Text('Card Number'),
                ),
                // SizedBox(
                //   height: 15.sp,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextfield(
                      validator: _validateCVV,
                      controller: cvvController,
                      text: Text('CVV'),
                      width: 161.sp,
                      height: 80.sp,
                    ),
                    SizedBox(
                      width: 23.sp,
                    ),
                    CustomTextfield(
                      validator: _validateExp,
                      controller: expController,
                      text: Text('Exp'),
                      width: 161.sp,
                      height: 80.sp,
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 15.sp,
                // ),
                CustomTextfield(
                  controller: cardHolderNameController,
                  text: Text('CardHolder Name'),
                ),
              ],
            )),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: CustomButton(
          text: 'Save',
          onPressed: _savePayments,
          width: 342.sp,
          height: 52.sp,
        ),
      ),
    );
  }
}
