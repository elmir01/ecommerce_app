import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/db_helper.dart';
import '../models/payment.dart';

class PaymentViewModel extends ChangeNotifier{
  final DatabaseHelper dbhelper = DatabaseHelper();
  List<Payment> payments = [];
  notifyListeners();
  String maskText(String text) {
    if (text.length <= 4) {
      return text;
    }
    String maskedPart = '****';
    String lastFourChars = text.substring(text.length - 4);
    return maskedPart + lastFourChars;
  }
  Future<void> fetchPayments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    print('UserId: $userId');
    if (userId != null) {
      final getPayments = await dbhelper.getPaymentByUserId(userId);
      print('Tapılan adreslər: ${payments}');

        payments = getPayments;
      notifyListeners();
    } else {
      print('user yoxdu');
        payments = [];
      notifyListeners();
    }
  }
}