import 'package:ecommerce_app/models/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/db_helper.dart';
import '../../widgets/appbar_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class EditPaymentsScreen extends ConsumerStatefulWidget {
  final Payment payment;
   EditPaymentsScreen({super.key,required this.payment});

  @override
  ConsumerState createState() => _EditPaymentsScreenState();
}

class _EditPaymentsScreenState extends ConsumerState<EditPaymentsScreen> {
  late TextEditingController cardNumberController ;
  late TextEditingController cvvController;
  late TextEditingController expController ;
  late TextEditingController cardHolderNameController ;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  void initState() {
    super.initState();
    final payment = widget.payment;
    cardNumberController = TextEditingController(text: payment.cardNumber);
    cvvController = TextEditingController(text: (payment.cvv).toString());
    expController = TextEditingController(text: payment.exp);
    cardHolderNameController = TextEditingController(text: payment.cardHolderName);
  }
  void _updatePayment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    final updatedPayment = Payment(
      id: widget.payment.id,
      cardNumber: cardNumberController.text,
      cvv:int.parse(cvvController.text) ,
      exp: expController.text,
      cardHolderName: cardHolderNameController.text, userId: userId!,
    );

    await _databaseHelper.updatePayment(updatedPayment);
    print('ID:${updatedPayment.id}');
    Navigator.pop(context,true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        title: Text('Edit Card'),
      ),
      body: IntrinsicWidth(
        stepWidth: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 25.sp,
            ),
            CustomTextfield(
              controller: cardNumberController,
              text: Text('Card Number'),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextfield(
                  controller: cvvController,
                  text: Text('CVV'),
                  width: 161.sp,
                  height: 56.sp,
                ),
                SizedBox(
                  width: 23.sp,
                ),
                CustomTextfield(
                  controller: expController,
                  text: Text('Exp'),
                  width: 161.sp,
                  height: 56.sp,
                ),
              ],
            ),
            SizedBox(
              height: 15.sp,
            ),
            CustomTextfield(
              controller: cardHolderNameController,
              text: Text('CardHolder Name'),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: CustomButton(
          text: 'Edit',
          onPressed: _updatePayment,
          width: 342.sp,
          height: 52.sp,
        ),
      ),
    );
  }
}
