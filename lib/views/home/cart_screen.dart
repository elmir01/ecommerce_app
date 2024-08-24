import 'package:ecommerce_app/widgets/appbar_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product.dart';

class CartScreen extends ConsumerStatefulWidget {
  List<Product>? cartProducts;
  int? quantity;
  String? color;
  String? size;

  CartScreen(
      {super.key, this.cartProducts, this.quantity, this.size, this.color});

  @override
  ConsumerState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: ListView.builder(
        itemCount: widget.cartProducts!.length,
        itemBuilder: (context, index) {
          final product = widget.cartProducts![index];
          return ListTile(
            leading: Image.asset(product.images[0]),
            title: Text(product.name),
            subtitle: Text('\$${product.price},${widget.quantity}   ${widget.color}  ${widget.size}'),
          );
        },
      ),
    );
  }
}
