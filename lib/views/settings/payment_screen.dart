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
  String maskText(String text) {
    if (text.length <= 4) {
      return text;
    }
    String maskedPart = '****';
    String lastFourChars = text.substring(text.length - 4);
    return maskedPart + lastFourChars;
  }

  final DatabaseHelper _dbhelper = DatabaseHelper();
  List<Payment> _payments = [];
  @override
  void initState() {
    super.initState();
    _fetchPayments();

  }
  Future<void> _fetchPayments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    print('UserId: $userId');
    if (userId != null) {
      final payments = await _dbhelper.getPaymentByUserId(userId);
      print('Tapılan adreslər: ${payments}');
      setState(() {
        _payments = payments; // id-si null olanları filter edin
      });
    } else {
      print('user yoxdu');
      setState(() {
        _payments = [];

      });
    }
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
              ).then((_) => _fetchPayments());
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
                  itemCount: _payments.length,
                  itemBuilder: (context,index){
                    final payment = _payments[index];
                    String originalText = payment.cardNumber;
                    int maskCount = 15;
                    String maskedText = maskText(originalText);
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
                          await _dbhelper.deletePayment(payment.id!);
                          _fetchPayments();
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
                                    _fetchPayments(); // Yenidən adresləri əldə et
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
              // SettingsContainer(
              //   width: 342.sp,
              //   height: 72.sp,
              //   child: Center(
              //     child: ListTile(
              //       title: Text('**** 4187'),
              //       trailing: Icon(
              //         Icons.navigate_next,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
