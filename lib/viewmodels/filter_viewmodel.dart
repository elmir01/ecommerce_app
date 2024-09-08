import 'package:flutter/material.dart';

import '../data/data_service.dart';
import '../models/product.dart';

class FilterViewModel extends ChangeNotifier {
  var searchController = TextEditingController();
  ScrollController? scrollController = ScrollController();
  List<Product> filteredProducts = [];
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  var products1 = DataService.predefinedProducts;
  var products2 = DataService.predefinedNewInProducts;
  var products3 = DataService.predefinedTopSellingProducts;
  double minPrice = 0;
  double maxPrice = 0;
  String searchText = '';
  notifyListeners();
  Future<void> mergeProductLists() async{
    filteredProducts = [...products1, ...products2, ...products3];
    notifyListeners();
  }
  Future<void> filterProducts(String query, double minPrice, double maxPrice) async{
    List<Product> results = [];
    results = [...products1, ...products2, ...products3];
    results = results
        .where(
            (product) => product.price >= minPrice && product.price <= maxPrice)
        .toList();
    if (query.isNotEmpty) {
      results = results
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
   notifyListeners();
      filteredProducts = results;

  }
}