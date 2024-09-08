import 'package:ecommerce_app/management/flutter_management.dart';
import 'package:ecommerce_app/models/payment.dart';
import 'package:ecommerce_app/views/settings/edit_payments_screen.dart';
import 'package:ecommerce_app/widgets/appBar_add_button.dart';
import 'package:ecommerce_app/widgets/appbar_back_button.dart';
import 'package:ecommerce_app/widgets/custom_textfield.dart';
import 'package:ecommerce_app/widgets/settings_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/db_helper.dart';
import 'add_card_screen.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(paymentViewModel).fetchPayments();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        leading: AppBarBackButton(),
        actions: [
          AppBarAddButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => AddCardScreen(),
                ),
              ).then((_) => ref.read(paymentViewModel).fetchPayments());
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.sp,
              ),
              Text(
                'Cards',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.sp,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: ref.watch(paymentViewModel).payments.length,
                  itemBuilder: (context,index){
                    final payment = ref.watch(paymentViewModel).payments[index];
                    String originalText = payment.cardNumber;
                    int maskCount = 15;
                    String maskedText =ref.read(paymentViewModel).maskText(originalText);
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) async {
                        if (payment.id != null) {
                          await ref.watch(paymentViewModel).dbhelper.deletePayment(payment.id!);
                          ref.read(paymentViewModel).fetchPayments();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${payment.cardNumber} deleted')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Unable to delete card')),
                          );
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.sp),
                        child: SettingsContainer(
                          width: 342.sp,
                          height: 72.sp,
                          child: ListTile(
                            title: Text(
                              '${maskedText}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => EditPaymentsScreen(payment: payment,),
                                  ),
                                ).then((result) {
                                  if (result == true) {
                                    ref.read(paymentViewModel).fetchPayments(); // Yenidən adresləri əldə et
                                  }
                                });;
                              },
                              child: Text('Edit'),

                            ),
                          ),
                        ),
                      ),
                    );
              }),

            ],
          ),
        ),
      ),
    );
  }
}
