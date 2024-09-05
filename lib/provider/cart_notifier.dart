import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<Cart>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<Cart>> {
  CartNotifier() : super([]);

  void addToCart(Cart cart) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? currentUserId = prefs.getInt('user_id');
    if(currentUserId==cart.userId) {
      state = [...state, cart];
    }
  }

  void removeFromCart(Cart cart) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? currentUserId = prefs.getInt('user_id');
    if(currentUserId==cart.userId){
      state = state.where((p) => p.id != cart.id).toList();
    }

  }

  void increaseQuantity(Cart cartItem) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? currentUserId = prefs.getInt('user_id');
    state = state.map((item) {
      if (item.userId == currentUserId && item == cartItem) {
        return Cart(
          productName: item.productName,
          productImage: item.productImage,
          price: item.price,
          quantity: item.quantity + 1,
          size: item.size,
          color: item.color,
          listId: item.listId,
          productJson: item.productJson, userId: currentUserId!,
        );
      }
      return item;
    }).toList();
  }

  void decreaseQuantity(Cart cartItem) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? currentUserId = prefs.getInt('user_id');
    state = state.map((item) {
      if (item == cartItem&&item.userId == currentUserId && item == cartItem) {
        if (item.quantity > 1) {
          return Cart(
            productName: item.productName,
            productImage: item.productImage,
            price: item.price,
            quantity: item.quantity - 1,
            size: item.size,
            color: item.color,
            listId: item.listId,
            productJson: item.productJson, userId: currentUserId!,
          );
        }
        return item;
      }
      return item;
    }).toList();
  }

  List<Cart> get cartItems => state;
}
