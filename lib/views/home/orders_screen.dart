
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/appbar_back_button.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //  final orders = ref.watch(orderProvider);
    //  if (orders == null || orders.isEmpty) {
    //    return Scaffold(
    //      appBar: AppBar(
    //        title: const Text('Wishlist (0)'),
    //        leading: const AppBarBackButton(),
    //      ),
    //      body: Center(
    //        child: Text(
    //          'No orders found!',
    //          style: TextStyle(fontSize: 18.sp),
    //        ),
    //      ),
    //    );
    //  }
    return Scaffold(
        appBar: AppBar(
          title: Text('Wishlist '),
          leading: AppBarBackButton(),
        ),
    );
  }
}
