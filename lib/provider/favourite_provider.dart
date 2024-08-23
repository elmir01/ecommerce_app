import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';

class FavouriteProvider extends StateNotifier<List<Product>> {
  FavouriteProvider() : super([]);

  void addToFavourite(Product product) {
    state = [...state, product];
  }
  void toggleFavourite(Product product) {
    if (state.contains(product)) {
      state = state.where((item) => item != product).toList();
    } else {
      state = [...state, product];
    }
  }
  void removeFromFavourite(Product product) {
    state = state.where((item) => item.id != product.id || item.listId != product.listId).toList();
  }

  bool isFavourite(Product product) {
    return state.contains(product);
  }
}

final favouriteProvider =
StateNotifierProvider<FavouriteProvider, List<Product>>((ref) {
  return FavouriteProvider();
});
