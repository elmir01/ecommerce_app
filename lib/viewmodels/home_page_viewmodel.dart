import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/db_helper.dart';

class HomePageViewModel extends ChangeNotifier{
  DatabaseHelper db = new DatabaseHelper();
  late Future<String?> imageFuture;
  notifyListeners();
  Future<String?> fetchImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    // Replace with your method to fetch the image path from the database
    final imageUrl = await db.getProfileImagePath(userId!);
    return imageUrl;
  }
}