import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuantityProvider extends StateNotifier<int> {
  QuantityProvider() : super(1); // Default quantity

  void increment() => state++;
  void decrement() {
    if (state > 1) state--;
  }
}

final quantityProvider = StateNotifierProvider<QuantityProvider, int>((ref) {
  return QuantityProvider();
});
