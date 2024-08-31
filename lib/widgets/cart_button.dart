import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../provider/cart_notifier.dart';
import '../views/home/cart_screen.dart';
import 'package:badges/badges.dart' as badges;
class CartButton extends ConsumerStatefulWidget {
  const CartButton({super.key});

  @override
  ConsumerState createState() => _CartButtonState();
}

class _CartButtonState extends ConsumerState<CartButton> {
  @override
  Widget build(BuildContext context) {
    return     InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => CartScreen(),
          ),
        );
      },
      child: Consumer(builder: (context, watch, child) {
        final itemCount = ref.watch(cartProvider).length;
        return badges.Badge(
            badgeContent: Text(itemCount.toString(),
                style: TextStyle(color: Colors.white)),
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 142, 108, 209),
              child: Icon(
                Icons.card_travel,
                color: Colors.white,
              ),
            ));
      }),
    );
  }
}
