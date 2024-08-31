
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/db_helper.dart';
import '../models/address.dart';

class AddressViewModel extends ChangeNotifier {
  final DatabaseHelper dbhelper = DatabaseHelper();
  List<Address> addresses = [];
  notifyListeners();
  Future<void> fetchAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    print('UserId: $userId');
    if (userId != null) {
      final getAddresses = await dbhelper.getAddressesByUserId(userId);
      print('Tapılan adreslər: ${addresses}');

        addresses = getAddresses;
     notifyListeners();
    } else {
      print('user yoxdu');

        addresses = [];
      notifyListeners();

    }
  }
}
